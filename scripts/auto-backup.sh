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

export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/etc/nixos/dotfiles/ssh/known_hosts -o StrictHostKeyChecking=yes"

# Evaluates a Nix expression that returns a list of derivations and prints their pname.
get_package_names() {
  local attr_path="$1"
  nix eval --raw --extra-experimental-features 'nix-command flakes' --apply "list: builtins.concatStringsSep \"\n\" (map (p: p.pname or p) list)" "$attr_path" 2>/dev/null || true
}

# Evaluates a Nix expression that returns a list of strings and prints them.
get_string_list() {
  local attr_path="$1"
  nix eval --raw --extra-experimental-features 'nix-command flakes' --apply "list: builtins.concatStringsSep \"\n\" list" "$attr_path" 2>/dev/null || true
}


# Capture key flake information and render the README overview
render_overview() {
  local readme="$REPO_DIR/README.md"

  local system_packages flatpaks ollama_models modules host timezone desktop gnome_extensions
  # This awk script finds a list assignment (like `packages = [ ... ]`) and extracts the items.
  local parse_pkg_list_cmd="awk '/= .*\\[/ { in_list=1; next } /\\]/ { in_list=0 } in_list { for (i=1; i<=NF; i++) { if (\$i !~ /\\[|\\]|=/ && \$i != \"\") { sub(/#.*/, \"\", \$i); if (\$i != \"\") print \$i } } }'"

  system_packages=$(eval "$parse_pkg_list_cmd" "apps/package.nix")
  gnome_extensions=$(eval "$parse_pkg_list_cmd" "apps/gnome-extensions.nix")
  flatpaks=$(eval "$parse_pkg_list_cmd" "apps/flatpaks.nix" | tr -d '"')
  ollama_models=$(eval "$parse_pkg_list_cmd" "apps/ollama.nix" | tr -d '"')

  system_packages_categorized=$(generate_categorization "$system_packages" "NixOS system packages")
  flatpaks_categorized=$(generate_categorization "$flatpaks" "Flatpak applications")
  gnome_extensions_categorized=$(generate_categorization "$gnome_extensions" "GNOME extensions")

  host="$(nix eval --raw --extra-experimental-features 'nix-command flakes' ".#nixosConfigurations.hypr.config.networking.hostName" 2>/dev/null || echo "hypr")"
  timezone="$(nix eval --raw --extra-experimental-features 'nix-command flakes' ".#nixosConfigurations.hypr.config.time.timeZone" 2>/dev/null || echo "UTC")"
  desktop="GNOME (GDM)"


  modules="$(python - <<'PY'
import re, pathlib
txt = pathlib.Path("flake.nix").read_text()
mods = re.findall(r'\./[A-Za-z0-9_.\\/-]+', txt)
seen = []
for m in mods:
    if m not in seen:
        seen.append(m)
print("\n".join(seen))
PY
)"

  local daily_section_content=""
  if [ -f "$readme" ]; then
    # Get all content from "## Daily Changes" onwards, but strip the header itself.
    daily_section_content="$(sed -n '/^## Daily Changes/,$p' "$readme" | tail -n +2)"
  fi

  cat > "$readme" <<EOF
# NixOS Flake Overview (hypr)

## System
- Hostname: $host
- Timezone: $timezone
- Desktop: $desktop

## Modules
$(printf '%s\n' "$modules" | sed 's/^/- /')

## System Packages

$system_packages_categorized

## Flatpaks

$flatpaks_categorized

## GNOME Extensions

$gnome_extensions_categorized

## Ollama Models
$(printf '%s\n' "$ollama_models" | sed 's/^/- /')

## Daily Changes

$daily_section_content
EOF
}

# Insert a new daily AI summary at the top of the daily section
insert_daily_summary() {
  local date="$1"
  local summary="$2"
  local new_hash="$3"
  local readme="$REPO_DIR/README.md"

  # Everything before the "Daily Changes" section
  local before_daily
  before_daily="$(sed '/^## Daily Changes/q' "$readme" | sed '$d')"

  # The existing content of the "Daily Changes" section
  local daily_content
  daily_content="$(sed -n '/^## Daily Changes/,$p' "$readme" | tail -n +2)"

  # The new entry for today
  local new_entry
  new_entry=$(printf "### %s\n<!-- last_hash:%s -->\n\n%s" "$date" "$new_hash" "$summary")

  # Reconstruct the README
  {
    printf "%s\n" "$before_daily"
    echo "## Daily Changes"
    echo
    printf "%s" "$new_entry"
    if [ -n "$daily_content" ]; then
      # Add a newline to separate from older entries
      printf "\n\n%s" "$daily_content"
    fi
  } > "$readme"
}

# Updates an existing daily summary with new content
update_daily_summary() {
  local date="$1"
  local summary_update="$2"
  local new_hash="$3"
  local readme="$REPO_DIR/README.md"
  local temp_readme
  temp_readme="$(mktemp)"

  # Add a "Part X" header to the new summary content
  local part_num
  part_num=$(( $(grep -c '#### Part' "$readme" || echo 0) + 2 ))
  local update_content
  update_content=$(printf "\n\n#### Part %d\n\n%s" "$part_num" "$summary_update")

  # Use awk to find the section for the given date and insert the update before the next section or at the end
  awk -v date_str="### $date" -v update="$update_content" '
    BEGIN { found = 0; inserted = 0 }
    $0 ~ date_str { found = 1 }
    found && !inserted && /^### / && $0 !~ date_str {
      print update;
      inserted = 1;
    }
    { print }
    END {
      if (found && !inserted) {
        print update;
      }
    }
  ' "$readme" > "$temp_readme"

  # Now, update the hash in the temp file
  sed -i "s/<!-- last_hash:.* -->/<!-- last_hash:$new_hash -->/" "$temp_readme"

  # Replace the original readme
  mv "$temp_readme" "$readme"
}


generate_ai_summary() {
  if [ -z "${GEMINI_API_KEY:-}" ]; then
    echo "GEMINI_API_KEY not set; skipping AI summary" >&2
    return
  fi

  local today log_content prompt payload response summary readme
  today="$(date +%Y-%m-%d)"
  readme="$REPO_DIR/README.md"

  local current_hash
  current_hash=$(git rev-parse HEAD)

  # Check if an entry for today already exists
  if grep -q "### $today" "$readme"; then
    # UPDATE existing entry
    local last_hash
    last_hash=$(grep -oP '(?<=<!-- last_hash:)[a-f0-9]+' "$readme" | tail -n1 || true)

    if [ -z "$last_hash" ] || [ ! "$(git cat-file -t "$last_hash" 2>/dev/null)" = "commit" ]; then
      # Fallback if hash is missing or invalid
      log_content=$(git log --since=midnight --pretty=format:'- %h %s (%an)' --no-merges)
    elif [ "$last_hash" != "$current_hash" ]; then
      # Get logs since the last summarized commit
      log_content=$(git log "$last_hash..$current_hash" --pretty=format:'- %h %s (%an)' --no-merges)
    else
      log_content="" # No new commits to summarize
    fi

    if [ -z "$log_content" ]; then
      return
    fi

    prompt=$(cat <<EOF
Summarize these additional changes for today's NixOS flake log. This is an update to an existing summary. Keep it brief (2-4 bullets).
Date: $today
New Changes:
$log_content
EOF
)
    # Get summary from Gemini
    payload=$("$PYTHON_BIN" -c 'import json, sys; print(json.dumps({"contents":[{"parts":[{"text": sys.stdin.read()}]}]}))' <<< "$prompt")
    response="$(curl -sS -w '\n%{http_code}' -H "x-goog-api-key: $GEMINI_API_KEY" -H 'Content-Type: application/json' -X POST -d "$payload" "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent" || true)"
    status="${response##*$'\n'}"
    body="${response%$'\n'$status}"
    summary=$("$PYTHON_BIN" -c '
import json, sys
try:
    data = json.loads(sys.stdin.read())
    if "candidates" in data and len(data["candidates"]) > 0:
        print(data["candidates"][0]["content"]["parts"][0]["text"].strip())
    elif "error" in data:
        print(f"Error from API: {data['error']['message']}", file=sys.stderr)
except (json.JSONDecodeError, IndexError, KeyError) as e:
    # No need to exit, just return empty summary
    pass
' <<< "$body")

    if [ -n "$summary" ]; then
      update_daily_summary "$today" "$summary" "$current_hash"
    fi
  else
    # CREATE new entry for today
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
    # Get summary from Gemini
    payload=$("$PYTHON_BIN" -c 'import json, sys; print(json.dumps({"contents":[{"parts":[{"text": sys.stdin.read()}]}]}))' <<< "$prompt")
    response="$(curl -sS -w '\n%{http_code}' -H "x-goog-api-key: $GEMINI_API_KEY" -H 'Content-Type: application/json' -X POST -d "$payload" "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent" || true)"
    status="${response##*$'\n'}"
    body="${response%$'\n'$status}"
    summary=$("$PYTHON_BIN" -c '
import json, sys
try:
    data = json.loads(sys.stdin.read())
    if "candidates" in data and len(data["candidates"]) > 0:
        print(data["candidates"][0]["content"]["parts"][0]["text"].strip())
    elif "error" in data:
        print("Error from API: " + data["error"]["message"], file=sys.stderr)
except (json.JSONDecodeError, IndexError, KeyError) as e:
    # No need to exit, just return empty summary
    pass
' <<< "$body")

    if [ -n "$summary" ]; then
      insert_daily_summary "$today" "$summary" "$current_hash"
    else
      echo "Gemini call failed or returned no summary (status: ${status:-unknown})" >&2
      if [ -n "$body" ]; then
        echo "Gemini response: $body" >&2
      fi
    fi
  fi
}

# Generate categorized markdown for a list of items using AI
generate_categorization() {
  local items="$1"
  local type="$2"
  if [ -z "${GEMINI_API_KEY:-}" ]; then
    echo "GEMINI_API_KEY not set; skipping AI categorization" >&2
    # Fallback to simple list
    printf '%s\n' "$items" | sed 's/^/- /'
    return
  fi

  local prompt payload response categorized
  prompt=$(cat <<EOF
Categorize these $type into logical groups such as Development, Productivity, Multimedia, Utilities, etc. Output in markdown format with ### Category headers followed by - item lists. Keep it concise and relevant.

Items:
$items
EOF
)
  # Get categorization from Gemini
  payload=$("$PYTHON_BIN" -c 'import json, sys; print(json.dumps({"contents":[{"parts":[{"text": sys.stdin.read()}]}]}))' <<< "$prompt")
  response="$(curl -sS -w '\n%{http_code}' -H "x-goog-api-key: $GEMINI_API_KEY" -H 'Content-Type: application/json' -X POST -d "$payload" "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent" || true)"
  status="${response##*$'\n'}"
  body="${response%$'\n'$status}"
  categorized=$("$PYTHON_BIN" -c '
import json, sys
try:
    data = json.loads(sys.stdin.read())
    if "candidates" in data and len(data["candidates"]) > 0:
        print(data["candidates"][0]["content"]["parts"][0]["text"].strip())
    elif "error" in data:
        print("Error from API: " + data["error"]["message"], file=sys.stderr)
        sys.exit(1)
except (json.JSONDecodeError, IndexError, KeyError) as e:
    print("JSON error: " + str(e), file=sys.stderr)
    sys.exit(1)
' <<< "$body")

  if [ -n "$categorized" ]; then
    echo "$categorized"
  else
    echo "Gemini call failed or returned no categorization (status: ${status:-unknown})" >&2
    if [ -n "$body" ]; then
      echo "Gemini response: $body" >&2
    fi
    # Fallback
    printf '%s\n' "$items" | sed 's/^/- /'
  fi
}

# Build README overview and daily log (with optional Gemini summary)
render_overview
generate_ai_summary

echo "DEBUG: Checking for git changes..."
git status --porcelain

# Only proceed when there is a change to capture
if ! git status --porcelain | grep -q .; then
  echo "DEBUG: No changes detected, exiting."
  exit 0
fi

echo "DEBUG: Changes detected, proceeding with commit."
# Stage and commit everything; if staging fails (e.g., permissions), bail gracefully
if ! git add -A; then
  echo "Auto-backup: git add failed (permissions?); skipping commit/push" >&2
  exit 0
fi
echo "DEBUG: 'git add -A' successful."
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
git commit -m "Auto backup: ${timestamp}"
echo "DEBUG: Commit successful."

# Push to the first configured remote if one exists
remote="$(git remote | head -n1 || true)"
if [ -n "$remote" ]; then
  echo "DEBUG: Pushing to remote '$remote'..."
  if ! git push "$remote" HEAD; then
    echo "Auto-backup: push to '$remote' failed; leaving commit local" >&2
  fi
  echo "DEBUG: Push command finished."
fi
