---
name: run
description: Run six offline StoreKit / Xcode pre-flight file checks on this repo and print a PASS/FAIL/WARN/SKIP table. Use before uploading an iOS build with in-app purchases or subscriptions.
---

1. Run the check script on the repo root: `bash "${CLAUDE_PLUGIN_ROOT}/scripts/check.sh" .`
   If `CLAUDE_PLUGIN_ROOT` is empty, the script is `scripts/check.sh` two folders up from this skill's base directory.
2. Paste the table and the detail lines exactly as printed. Don't reword the results.
3. For each FAIL, then each WARN, say in one line what to change in which file. Don't edit anything unless asked.
4. A SKIP is not a pass. Say why it skipped.
5. Never say whether Apple will approve the app. These are file facts only; whether Apple accepts an app is up to Apple.
