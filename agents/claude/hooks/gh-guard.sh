#!/usr/bin/env bash

set -uo pipefail

input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // ""' 2>/dev/null || true)

[ -z "$cmd" ] && exit 0

# bare `gh` -> `gh-auto-account` (block)
if printf '%s' "$cmd" | grep -qE '(^|[;&|(`]|[[:space:]])gh([[:space:]]|$)'; then
  echo "Do not use the bare \`gh\` command; use \`gh-auto-account\` instead." >&2
  exit 2
fi

# `gh pr edit` -> 取得してから編集するよう注意喚起 (non-blocking)
if printf '%s' "$cmd" | grep -qE '\bgh(-auto-account)?[[:space:]]+pr[[:space:]]+edit\b'; then
  jq -n '{
		hookSpecificOutput: {
			hookEventName: "PreToolUse",
			additionalContext: "The PR title and body may have been edited manually on GitHub. Before overwriting them, run `gh-auto-account pr view --json title,body` to fetch the current content and apply only the intended changes."
		}
	}'
  exit 0
fi

exit 0
