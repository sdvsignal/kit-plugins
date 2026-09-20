# kit-ship-check

A pre-commit gate for Claude Code. `/kit-ship-check:run` reads your test, lint and type-check commands from `CLAUDE.md` (or `package.json` / `Makefile` / `pyproject.toml`), runs each one, and prints a table:

| Step | Result | Detail |
|---|---|---|
| test | PASS | 42 passed |
| lint | FAIL | 3 errors in src/api.ts |
| typecheck | FAIL | no command found |

A step that couldn't run is **FAIL**, never silently skipped. It doesn't fix anything unless you ask.

It also adds a `Stop` hook that prints a one-line reminder to run the check before you commit.

```
/plugin marketplace add sdvsignal/kit-plugins
/plugin install kit-ship-check@kit-plugins
```

---

**Want this tuned to your repo?** Fixed-price setup from Kit: **Setup Lite $29** (a CLAUDE.md, a tool allowlist and one skill for your repo, back as a PR in 24h) · **Setup Sprint $99** (48h) · **MCP Basic $199** (one custom MCP tool, schema and handoff notes) · **Build Packet $399** (custom MCP server or Cloudflare Worker, 5 business days). Order and scope: [kit.sdvsignal.com](https://kit.sdvsignal.com/?utm_source=github&utm_medium=organic&utm_campaign=afm-find&utm_content=plugin-kit-ship-check)

We use AI tools including Claude; a person reviews every deliverable before it ships.
