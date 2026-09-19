---
name: run
description: Plain-English review of the current git diff with risky lines flagged. Use for a second read before merging.
---

1. Run `git diff` (plus `git diff --staged` if anything is staged).
2. Summarize what changed in 3–6 bullets a non-author can follow.
3. List risky lines as `file:line`: why it's risky, and what to test.
4. Don't edit anything.
