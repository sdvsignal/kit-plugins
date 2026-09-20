# kit-plugins

Four small Claude Code plugins from [Kit](https://kit-sdvsignal.pages.dev). Plain markdown and JSON, no telemetry, no secrets. Read any of them in two minutes.

| Plugin | Command | What it does |
|---|---|---|
| [kit-ship-check](plugins/kit-ship-check) | `/kit-ship-check:run` | Runs test + lint + type check, prints PASS/FAIL. Can't-run = FAIL. |
| [kit-explain-diff](plugins/kit-explain-diff) | `/kit-explain-diff:run` | Plain-English diff review with risky `file:line`s. |
| [kit-new-feature](plugins/kit-new-feature) | `/kit-new-feature:run` | 5-line plan → your yes → build → test → ship check. |
| [kit-storekit-check](plugins/kit-storekit-check) | `/kit-storekit-check:run` | Six offline StoreKit / Xcode pre-flight file checks for iOS subscription apps. |

## Install

In Claude Code:

```
/plugin marketplace add sdvsignal/kit-plugins
/plugin install kit-ship-check@kit-plugins
```

Or from a shell: `claude plugin marketplace add sdvsignal/kit-plugins && claude plugin install kit-ship-check@kit-plugins`.

Want the whole setup (CLAUDE.md, allowlist, hooks, MCP example) instead of plugins? See [kit-claude-code-starter](https://github.com/sdvsignal/kit-claude-code-starter).

---

**Want this tuned to your repo?** Fixed-price setup from Kit: **Setup Lite $29** (a CLAUDE.md, a tool allowlist and one skill for your repo, back as a PR in 24h) · **Setup Sprint $99** (48h) · **MCP Basic $199** (one custom MCP tool, schema and handoff notes) · **Build Packet $399** (custom MCP server or Cloudflare Worker, 5 business days). Order and scope: [kit-sdvsignal.pages.dev](https://kit-sdvsignal.pages.dev)

Shipping to the App Store? `kit-storekit-check` covers the StoreKit side of a submission; the **ASO Launch Pack $19** covers the metadata side (keyword map, subtitle and description templates, screenshot storyboard, App Store Connect paste checklist). Same page.

We use AI tools including Claude; a person reviews every deliverable before it ships.

## License

MIT
