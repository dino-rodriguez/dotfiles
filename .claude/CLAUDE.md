## Bash tool

Never chain commands with `&&` or `;` in a single Bash call. Use separate Bash calls instead — chained commands don't match permission allowlist entries (e.g., `Bash(git add *)` won't match `git add . && git commit`).
