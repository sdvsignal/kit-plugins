#!/usr/bin/env bash
# PostToolUse hook: format the file Claude just edited. Reads the hook JSON on stdin.
# Never fails the tool call: formatting is best-effort.
f=$(python3 -c 'import sys,json; print(json.load(sys.stdin).get("tool_input",{}).get("file_path",""))' 2>/dev/null)
[ -n "$f" ] && [ -f "$f" ] || exit 0
case "$f" in
  *.js|*.ts|*.tsx|*.jsx|*.json|*.css|*.md) command -v npx >/dev/null && npx --no-install prettier --write "$f" >/dev/null 2>&1 ;;
  *.py) command -v black >/dev/null && black -q "$f" ;;
  *.swift) command -v swift-format >/dev/null && swift-format -i "$f" ;;
esac
exit 0
