# kit-plugins

**Four things you end up re-typing to Claude Code every day, turned into slash commands.** "Run the
tests and tell me if I can ship." "Explain this diff and flag anything risky." "Plan it before you
build it." "Check my StoreKit setup before I waste an App Store review."

Plain markdown and JSON. No telemetry, no secrets, no network calls. Read any of them in two minutes.

| Plugin | Command | What it does |
|---|---|---|
| [kit-ship-check](plugins/kit-ship-check) | `/kit-ship-check:run` | Runs test + lint + type check, prints PASS/FAIL. Can't-run = FAIL. |
| [kit-explain-diff](plugins/kit-explain-diff) | `/kit-explain-diff:run` | Plain-English diff review with risky `file:line`s. |
| [kit-new-feature](plugins/kit-new-feature) | `/kit-new-feature:run` | 5-line plan → your yes → build → test → ship check. |
| [kit-storekit-check](plugins/kit-storekit-check) | `/kit-storekit-check:run` | Six offline StoreKit / Xcode pre-flight file checks for iOS subscription apps. |

Looking for a Claude Code plugin example, a Claude Code marketplace you can add in one line, or a StoreKit
pre-flight check to run before an App Store build? That is what these four are.

## 60-second start

In Claude Code:

```
/plugin marketplace add sdvsignal/kit-plugins
/plugin install kit-ship-check@kit-plugins
```

Then type `/kit-ship-check:run`. That is the whole install.

From a shell instead:

```bash
claude plugin marketplace add sdvsignal/kit-plugins
claude plugin install kit-ship-check@kit-plugins
```

In Cursor, install straight from this repo:

```
github:sdvsignal/kit-plugins
```

Every plugin here carries both a `.cursor-plugin/plugin.json` and a `.claude-plugin/plugin.json`, so the same directory loads in either client. The skills are identical; the hooks in `kit-ship-check` and `kit-new-feature` are Claude Code hooks and only run there.

## Why `ship-check` fails loudly

`kit-ship-check` treats **"could not run that command"** as a FAIL, not as a skip. A gate that silently
passes when it cannot find your test runner is worse than no gate — it teaches you to trust a green
that never actually ran. If it can't run it, it says so and fails.

## Free here vs. paid

**All four plugins are MIT and complete.** There is no locked tier, no key, nothing phoning home.

If you want the full setup rather than four plugins — project memory, a permission allowlist, hooks
and MCP wiring, tuned to your repo — start with
[kit-claude-code-starter](https://github.com/sdvsignal/kit-claude-code-starter), which is also free.

Paid is only ever the tuning: **Setup Lite $29** (a CLAUDE.md, a tool allowlist and one skill for
your repo, back as a PR in 24h) · **Setup Sprint $99** (the full setup, 48h) · **MCP Basic $199**
(one custom MCP tool, schema and handoff notes) · **Build Packet $399** (custom MCP server or
Cloudflare Worker, 5 business days).

Shipping to the App Store? `kit-storekit-check` covers the StoreKit side of a submission; the
**ASO Launch Pack $19** covers the metadata side (keyword map, subtitle and description templates,
screenshot storyboard, App Store Connect paste checklist). Need the preview video itself?
**Preview Pack $149**: one App Store preview to Apple's spec from your screen recordings, 5 stills,
2 revision rounds, 72 hours.

**→ Scope and order: [kit.sdvsignal.com](https://kit.sdvsignal.com/?utm_source=github&utm_medium=organic&utm_campaign=afm-find&utm_content=gh-readme-kit-plugins)**

We use AI tools including Claude; a person reviews every deliverable before it ships.
Independent project, not affiliated with Anthropic, Cursor or Apple.

## License

MIT
