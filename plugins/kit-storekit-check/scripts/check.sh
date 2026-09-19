#!/usr/bin/env bash
# kit-storekit-check: six offline file checks for StoreKit / Xcode pre-flight traps.
# Reports what is in the files. It does not predict App Review: whether Apple accepts your app is up to Apple.
# Usage: check.sh [repo_root]   |   check.sh --self-test
# Exit: 1 if any check FAILs, else 0 (WARN and SKIP never fail the run).
set -u
if [ "${1:-}" = "--self-test" ]; then
  here="$(cd "$(dirname "$0")/.." && pwd)"
  out="$("$0" "$here/fixtures/bad")"; code=$?
  echo "$out"
  want=("1 FAIL" "2 FAIL" "3 WARN" "4 WARN" "5 WARN" "6 WARN")
  ok=1; for w in "${want[@]}"; do n=${w%% *}; s=${w#* }; echo "$out" | grep -qE "^\| $n +\| $s " || { echo "SELF-TEST: row $n expected $s"; ok=0; }; done
  [ $code -eq 1 ] || { echo "SELF-TEST: expected exit 1, got $code"; ok=0; }
  [ $ok -eq 1 ] && { echo "SELF-TEST: PASS"; exit 0; } || { echo "SELF-TEST: FAIL"; exit 2; }
fi
ROOT="${1:-.}"; cd "$ROOT" 2>/dev/null || { echo "no such directory: $ROOT"; exit 2; }
command -v jq >/dev/null || JQ_MISSING=1
FIND() { find . \( -name .git -o -name node_modules -o -name build -o -name DerivedData -o -name Pods -o -name .build \) -prune -o "$@" -print 2>/dev/null; }
ROWS=(); DETAILS=(); FAILED=0
# Table stays inside 80 columns; the full detail of any non-PASS row prints under the table.
row() { local d="$4"; [ ${#d} -gt 36 ] && d="${d:0:35}~"
  ROWS+=("$(printf '| %-1s | %-4s | %-27s | %s' "$1" "$2" "$3" "$d")"); [ "$2" = PASS ] || [ "$2" = SKIP ] || DETAILS+=("#$1 $2: $4")
  [ "$2" = FAIL ] && FAILED=1; return 0; }
PBX=$(FIND -name project.pbxproj); YML=$(FIND -name project.yml -maxdepth 3); SK=$(FIND -name '*.storekit')
SWIFT=$(FIND -name '*.swift' | grep -viE '/[^/]*tests?/|tests?\.swift$' || true)

# 1. .storekit shipped as a bundle resource
if [ -z "$PBX$YML" ]; then row 1 SKIP ".storekit not bundled" "no .xcodeproj or project.yml found"
else
  hit=""; for f in $PBX; do grep -q '\.storekit in Resources' "$f" && hit="$hit $f"; done
  if [ -z "$hit" ] && [ -n "$SK" ] && [ -n "$YML" ]; then for y in $YML; do grep -q 'sources' "$y" && ! grep -qE '\*\*/\*\.storekit|^[[:space:]]*-[[:space:]]*"?[^":]*\.storekit"?[[:space:]]*$' "$y" && hit="$hit $y(no .storekit exclude)"; done; fi
  [ -n "$hit" ] && row 1 FAIL ".storekit not bundled" "in Copy Bundle Resources:$hit" || row 1 PASS ".storekit not bundled" "none in Copy Bundle Resources"
fi
# 2. expiry fallback to distantFuture
if [ -z "$SWIFT" ]; then row 2 SKIP "no distantFuture expiry" "no Swift sources"
else
  hit=$(grep -nE 'expir(ation|es)Date[^;]*\?\?[[:space:]]*(Date)?\.distantFuture' $SWIFT 2>/dev/null | head -3 | cut -c1-80)
  [ -n "$hit" ] && row 2 FAIL "no distantFuture expiry" "a nil expiry reads as subscribed: $(echo "$hit" | head -1)" || row 2 PASS "no distantFuture expiry" "$(echo "$SWIFT" | wc -l | tr -d ' ') Swift files"
fi
# 3 + 4. .storekit product IDs vs code; local intro offers
if [ -z "$SK" ]; then row 3 SKIP "product IDs match code" "no .storekit file"; row 4 SKIP "intro offer also in ASC" "no .storekit file"
elif [ -n "${JQ_MISSING:-}" ]; then row 3 SKIP "product IDs match code" "jq not installed"; row 4 SKIP "intro offer also in ASC" "jq not installed"
else
  ids=$(for f in $SK; do jq -r '.. | .productID? // empty' "$f" 2>/dev/null; done | sort -u)
  if [ -z "$ids" ]; then row 3 SKIP "product IDs match code" "no productID in .storekit"
  elif [ -z "$SWIFT" ]; then row 3 SKIP "product IDs match code" "no Swift sources"
  else
    pre=$(echo "$ids" | sed -E 's/\.[^.]*$/./' | sort | uniq -c | sort -rn | awk 'NR==1{print $2}')
    code=$(grep -ohE "\"$(echo "$pre" | sed 's/\./\\./g')[A-Za-z0-9_.-]+\"" $SWIFT 2>/dev/null | tr -d '"' | sort -u)
    only_sk=$(comm -23 <(echo "$ids") <(echo "$code") | tr '\n' ' '); only_code=$(comm -13 <(echo "$ids") <(echo "$code") | tr '\n' ' ')
    if [ -z "$only_sk$only_code" ]; then row 3 PASS "product IDs match code" "$(echo "$ids" | wc -l | tr -d ' ') IDs on both sides"
    else row 3 WARN "product IDs match code" "only .storekit: ${only_sk:-none} | only code: ${only_code:-none}"; fi
  fi
  n=$(for f in $SK; do jq '[.. | objects | select(has("introductoryOffer")) | .introductoryOffer | select(. != null)] | length' "$f" 2>/dev/null; done | awk '{s+=$1} END{print s+0}')
  [ "$n" -gt 0 ] && row 4 WARN "intro offer also in ASC" "$n intro offer(s) are local only; set the same in App Store Connect" || row 4 PASS "intro offer also in ASC" "no local intro offers"
fi
# 5. export compliance key
if [ -z "$PBX$YML" ]; then row 5 SKIP "encryption key declared" "no .xcodeproj or project.yml found"
else
  PL=$(FIND -name Info.plist | grep -viE 'tests?/' || true)
  if grep -qs 'ITSAppUsesNonExemptEncryption' $PL $YML $PBX; then row 5 PASS "encryption key declared" "ITSAppUsesNonExemptEncryption set"
  else row 5 WARN "encryption key declared" "ITSAppUsesNonExemptEncryption missing; ASC asks every upload"; fi
fi
# 6. pricing words in repo-side metadata text
META=$( { FIND -path '*fastlane/metadata/*' -name '*.txt'; FIND -path '*/aso/*' -name '*.txt'; FIND -path '*/screenshots/*' -name '*.md'; } | sort -u)
if [ -z "$META" ]; then row 6 SKIP "no prices in metadata text" "no fastlane/metadata, aso/ or screenshots/ text"
else
  hit=$(grep -liE '[$€£][0-9]|\bfree\b|[0-9]+ ?% off|try (it )?for' $META 2>/dev/null | head -3 | tr '\n' ' ')
  [ -n "$hit" ] && row 6 WARN "no prices in metadata text" "price words in: $hit" || row 6 PASS "no prices in metadata text" "$(echo "$META" | wc -l | tr -d ' ') files clean"
fi
echo "| # | Res  | Check                       | Detail"
echo "|---|------|-----------------------------|-------"
for r in "${ROWS[@]}"; do echo "$r"; done
for d in "${DETAILS[@]}"; do echo "$d"; done
echo "Reports file facts only. Whether Apple accepts your app is up to Apple."
exit $FAILED
