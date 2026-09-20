# kit-plugins

Four small Claude Code plugins from [Kit](https://kit-sdvsignal.pages.dev). Plain markdown and JSON, no telemetry, no secrets. Read any of them in two minutes.

Looking for a Claude Code plugin example, a Claude Code marketplace you can add in one line, or a StoreKit
pre-flight check to run before an App Store build? That is what these four are.

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

In Cursor, install straight from this repo:

```
github:sdvsignal/kit-plugins
```

Every plugin here carries both a `.cursor-plugin/plugin.json` and a `.claude-plugin/plugin.json`, so the same directory loads in either client. The skills are identical; the hooks in `kit-ship-check` and `kit-new-feature` are Claude Code hooks and only run there.

Want the whole setup (CLAUDE.md, allowlist, hooks, MCP example) instead of plugins? See [kit-claude-code-starter](https://github.com/sdvsignal/kit-claude-code-starter).

---

**Want this tuned to your repo?** Fixed-price setup from Kit: **Setup Lite $29** (a CLAUDE.md, a tool allowlist and one skill for your repo, back as a PR in 24h) · **Setup Sprint $99** (48h) · **MCP Basic $199** (one custom MCP tool, schema and handoff notes) · **Build Packet $399** (custom MCP server or Cloudflare Worker, 5 business days). Order and scope: [kit-sdvsignal.pages.dev](https://kit-sdvsignal.pages.dev)

Shipping to the App Store? `kit-storekit-check` covers the StoreKit side of a submission; the **ASO Launch Pack $19** covers the metadata side (keyword map, subtitle and description templates, screenshot storyboard, App Store Connect paste checklist). Same page. Need the preview video itself? **Preview Pack $149**: one App Store preview to Apple's spec from your
screen recordings, 5 stills, 2 revision rounds, 72 hours.

We use AI tools including Claude; a person reviews every deliverable before it ships.

## License

MIT
