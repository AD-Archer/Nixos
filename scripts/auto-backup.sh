#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/etc/nixos"
cd "$REPO_DIR"

# Optionally load secrets (e.g., GEMINI_API_KEY) from an untracked file
SECRETS_FILE="$REPO_DIR/.env.secrets"
if [ -f "$SECRETS_FILE" ]; then
  # shellcheck disable=SC1090
  . "$SECRETS_FILE"
fi

# Find python3 (required for JSON parsing); skip quietly if unavailable
PYTHON_BIN="$(command -v python3 2>/dev/null || true)"
if [ -z "$PYTHON_BIN" ] && [ -x /run/current-system/sw/bin/python3 ]; then
  PYTHON_BIN="/run/current-system/sw/bin/python3"
fi
if [ -z "$PYTHON_BIN" ]; then
  echo "python3 not found; skipping README generation and AI summary" >&2
  exit 0
fi

# Convert nix eval JSON arrays into plain lines
json_to_lines() {
  "$PYTHON_BIN" - <<'PY'
import json,sys
raw=sys.stdin.read()
if not raw.strip():
    sys.exit(0)
try:
    data=json.loads(raw)
except Exception:
    sys.exit(0)
if isinstance(data, list):
    for item in data:
        if isinstance(item, str):
            print(item)
        elif isinstance(item, dict) and "name" in item:
            print(item["name"])
PY
}

# Safe array eval helper (returns [] on failure)
eval_array() {
  nix eval --json --extra-experimental-features 'nix-command flakes' "$1" 2>/dev/null || echo "[]"
}

# Capture key flake information and render the README overview
render_overview() {
  local readme="$REPO_DIR/README.md"

  local system_packages flatpaks ollama_models modules host timezone desktop gnome_extensions
  system_packages="$(eval_array ".#nixosConfigurations.hypr.config.environment.systemPackages" | json_to_lines || true)"
  flatpaks="$(eval_array ".#nixosConfigurations.hypr.config.services.flatpak.packages" | json_to_lines || true)"
  ollama_models="$(eval_array ".#nixosConfigurations.hypr.config.services.ollama.loadModels" | json_to_lines || true)"
  host="$(nix eval --raw --extra-experimental-features 'nix-command flakes' ".#nixosConfigurations.hypr.config.networking.hostName" 2>/dev/null || echo "hypr")"
  timezone="$(nix eval --raw --extra-experimental-features 'nix-command flakes' ".#nixosConfigurations.hypr.config.time.timeZone" 2>/dev/null || echo "UTC")"
  desktop="GNOME (GDM)"

  gnome_extensions="$(printf '%s\n' "$system_packages" | grep 'gnome-shell-extension' || true)"

  modules="$(python - <<'PY'
import re, pathlib
txt = pathlib.Path("flake.nix").read_text()
mods = re.findall(r'\./[A-Za-z0-9_.\\/-]+', txt)
seen = []
for m in mods:
    if m not in seen:
        seen.append(m)
print("\\n".join(seen))
PY
)"

  local daily_section=""
  if [ -f "$readme" ]; then
    daily_section="$(sed -n '/^## Daily Changes$/,$p' "$readme")"
  fi
  [ -z "$daily_section" ] && daily_section="## Daily Changes\n\n"

  cat > "$readme" <<EOF
# NixOS Flake Overview (hypr)

## System
- Hostname: $host
- Timezone: $timezone
- Desktop: $desktop

## Modules
$(printf '%s\n' "$modules" | sed 's/^/- /')

## System Packages
$(printf '%s\n' "$system_packages" | sed 's/^/- /')

## Flatpaks
$(printf '%s\n' "$flatpaks" | sed 's/^/- /')

## GNOME Extensions
$(printf '%s\n' "$gnome_extensions" | sed 's/^/- /')

## Ollama Models
$(printf '%s\n' "$ollama_models" | sed 's/^/- /')

$daily_section
EOF
}

# Insert a new daily AI summary at the top of the daily section
insert_daily_summary() {
  local date="$1"
  local summary="$2"
  local readme="$REPO_DIR/README.md"

  local before daily
  before="$(awk '/^## Daily Changes$/{exit} {print}' "$readme")"
  daily="$(sed -n '/^## Daily Changes$/,$p' "$readme")"
  [ -z "$daily" ] && daily="## Daily Changes\n\n"

  daily="$(printf "## Daily Changes\n\n### %s\n\n%s\n\n%s" "$date" "$summary" "$(printf '%s' "$daily" | tail -n +3)")"

  { printf "%s\n%s\n" "$before" "$daily"; } > "$readme"
}

generate_ai_summary() {
  if [ -z "${GEMINI_API_KEY:-}" ]; then
    echo "GEMINI_API_KEY not set; skipping AI summary" >&2
    return
  fi

  local today log_content prompt payload response summary
  today="$(date +%Y-%m-%d)"
  log_content="$(git log --since=midnight --pretty=format:'- %h %s (%an)' --no-merges || true)"

  if [ -z "$log_content" ]; then
    return
  fi

  prompt=$(cat <<EOF
Summarize today's NixOS flake changes for the daily README log.
Date: $today
Changes:
$log_content

Return 3-6 concise bullets and end with one short highlight line prefixed by "Highlight:".
EOF
)

  payload=$(printf '{"contents":[{"parts":[{"text":"%s"}]}]}' "$(printf '%s' "$prompt" | sed 's/"/\\"/g')")

  # Capture both body and status code for debugging
  response="$(curl -sS -w '\n%{http_code}' \
    -H "x-goog-api-key: $GEMINI_API_KEY" \
    -H 'Content-Type: application/json' \
    -X POST \
    -d "$payload" \
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent" || true)"
  status="${response##*$'\n'}"
  body="${response%$'\n'$status}"

  summary="$("$PYTHON_BIN" - <<'PY'
import json,sys
try:
    raw='''$body'''
    if not raw.strip():
        raise RuntimeError("empty")
    data=json.loads(raw)
    text=data["candidates"][0]["content"]["parts"][0]["text"]
    print(text.strip())
except Exception:
    pass
PY
)"

  if [ -n "$summary" ]; then
    insert_daily_summary "$today" "$summary"
  else
    echo "Gemini call failed or returned no summary (status: ${status:-unknown})" >&2
    if [ -n "$body" ]; then
      echo "Gemini response (truncated): $(printf '%s' "$body" | head -c 400)" >&2
    fi
  fi
}

# Build README overview and daily log (with optional Gemini summary)
render_overview
generate_ai_summary

# Only proceed when there is a change to capture
if ! git status --porcelain | grep -q .; then
  exit 0
fi

# Stage and commit everything; if staging fails (e.g., permissions), bail gracefully
if ! git add -A; then
  echo "Auto-backup: git add failed (permissions?); skipping commit/push" >&2
  exit 0
fi
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
git commit -m "Auto backup: ${timestamp}"

# Push to the first configured remote if one exists
remote="$(git remote | head -n1 || true)"
if [ -n "$remote" ]; then
  if ! git push "$remote" HEAD; then
    echo "Auto-backup: push to '$remote' failed; leaving commit local" >&2
  fi
fi
