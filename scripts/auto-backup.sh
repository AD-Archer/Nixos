#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/etc/nixos"
cd "$REPO_DIR"

# Only proceed when there is a change to capture
if ! git status --porcelain | grep -q .; then
  exit 0
fi

# Stage and commit everything
git add -A
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
git commit -m "Auto backup: ${timestamp}"

# Push to the first configured remote if one exists
remote="$(git remote | head -n1 || true)"
if [ -n "$remote" ]; then
  git push "$remote" HEAD
fi
