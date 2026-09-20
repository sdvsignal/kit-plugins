# kit-storekit-check

Six offline checks for the StoreKit and Xcode traps that get iOS builds rejected or break subscriptions after launch. `/kit-storekit-check:run` reads your project files and prints a table. No network, no App Store Connect keys, no AI judgement: bash, grep and jq.

| # | Check | FAIL / WARN when | Apple reference |
|---|---|---|---|
| 1 | `.storekit` not bundled | a `.storekit` file is in Copy Bundle Resources (pbxproj), or XcodeGen `sources` don't exclude it | [StoreKit testing in Xcode](https://developer.apple.com/documentation/xcode/setting-up-storekit-testing-in-xcode) |
| 2 | no `distantFuture` expiry | Swift uses `expirationDate ?? .distantFuture`, so a nil expiry reads as subscribed forever | [Transaction.expirationDate](https://developer.apple.com/documentation/storekit/transaction/expirationdate) |
| 3 | product IDs match code (WARN) | an ID is in the `.storekit` file but not in Swift, or the other way round | [Product.products(for:)](https://developer.apple.com/documentation/storekit/product/products(for:)) |
| 4 | intro offer also in ASC (WARN) | the `.storekit` file has an introductory offer. It is local only; the same offer has to exist in App Store Connect | [Introductory offers](https://developer.apple.com/help/app-store-connect/manage-subscriptions/set-up-introductory-offers-for-auto-renewable-subscriptions) |
| 5 | encryption key declared (WARN) | `ITSAppUsesNonExemptEncryption` is in no Info.plist, project.yml or build setting | [ITSAppUsesNonExemptEncryption](https://developer.apple.com/documentation/bundleresources/information-property-list/itsappusesnonexemptencryption) |
| 6 | no prices in metadata text (WARN) | repo-side metadata (`fastlane/metadata`, `aso/`, `screenshots/*.md`) has `$4.99`, "free", "% off" | [App Review Guidelines 2.3.7](https://developer.apple.com/app-store/review/guidelines/#2.3.7) |

Anything that can't run prints **SKIP** with the reason, never PASS. The run exits non-zero only on a FAIL.

```
| # | Res  | Check                       | Detail
|---|------|-----------------------------|-------
| 1 | PASS | .storekit not bundled       | none in Copy Bundle Resources
| 2 | PASS | no distantFuture expiry     | 77 Swift files
| 3 | PASS | product IDs match code      | 2 IDs on both sides
| 4 | WARN | intro offer also in ASC     | 2 intro offer(s) are local only; se~
| 5 | PASS | encryption key declared     | ITSAppUsesNonExemptEncryption set
| 6 | SKIP | no prices in metadata text  | no fastlane/metadata, aso/ or scree~
#4 WARN: 2 intro offer(s) are local only; set the same in App Store Connect
```

This reports what is in your files. It does not predict App Review. Whether Apple accepts your app is up to Apple.

Not covered here: privacy manifests (see appstore-prep) and App Store Connect metadata (see fastlane precheck).

```
/plugin marketplace add sdvsignal/kit-plugins
/plugin install kit-storekit-check@kit-plugins
```

Self-test (runs the bad fixture in `fixtures/bad`): `bash scripts/check.sh --self-test`

---

**Want this tuned to your repo?** Fixed-price setup from Kit: **Setup Lite $29** (a CLAUDE.md, a tool allowlist and one skill for your repo, back as a PR in 24h) · **Setup Sprint $99** (48h) · **MCP Basic $199** (one custom MCP tool, schema and handoff notes) · **Build Packet $399** (custom MCP server or Cloudflare Worker, 5 business days). Order and scope: [kit.sdvsignal.com](https://kit.sdvsignal.com/?utm_source=github&utm_medium=organic&utm_campaign=afm-find&utm_content=plugin-kit-storekit-check)

We use AI tools including Claude; a person reviews every deliverable before it ships.
