#!/usr/bin/env node
// Stop hook: prints one advisory line after Claude finishes a turn.
// Advisory only. No network, no filesystem writes, no subprocess, no env or credential access.
let code = 0;
try {
  process.stdout.write('Reminder: run /kit-ship-check:run before you commit.\n');
} catch {
  code = 0; // a hook must never fail the session
}
process.exit(code);
