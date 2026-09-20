# kit-new-feature

`/kit-new-feature:run` for anything bigger than one file: Claude writes a plan of 5 lines or fewer (files, the new test, the risk), **stops for your yes**, builds in small steps with the test run after each, and finishes with a ship check.

It also adds a `PostToolUse` hook that formats each file Claude edits, best-effort and only with a formatter you already have: `prettier` (via `npx --no-install`), `black`, or `swift-format`. If none is installed it does nothing. It never fails the edit.

```
/plugin marketplace add sdvsignal/kit-plugins
/plugin install kit-new-feature@kit-plugins
```

---

**Want this tuned to your repo?** Fixed-price setup from Kit: **Setup Lite $29** (a CLAUDE.md, a tool allowlist and one skill for your repo, back as a PR in 24h) · **Setup Sprint $99** (48h) · **MCP Basic $199** (one custom MCP tool, schema and handoff notes) · **Build Packet $399** (custom MCP server or Cloudflare Worker, 5 business days). Order and scope: [kit-sdvsignal.pages.dev](https://kit-sdvsignal.pages.dev)

We use AI tools including Claude; a person reviews every deliverable before it ships.
