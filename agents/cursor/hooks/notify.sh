#!/bin/bash

set -euo pipefail

payload="$(cat)"
status="$(jq -r '.status // "stopped"' <<<"$payload")"
workspace="$(jq -r '(.workspace_roots[0]) // "unknown workspace"' <<<"$payload" | xargs basename)"

terminal-notifier \
  -title "Cursor ${workspace}" \
  -message "${status}" \
  -sound Glass -activate org.alacritty

exit 0
