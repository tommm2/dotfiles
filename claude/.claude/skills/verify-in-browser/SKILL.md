---
name: verify-in-browser
description: Verify a change in the real platform app (anyinsight / geniebench) through the browser — pick the right code (current branch or an MR worktree), make sure the dev server and backend are up, drive the flow with claude-in-chrome, check console and network, report pass/fail, then clean up. Use when the user says "用 claude in chrome 看一下", "操作一下", "跑網頁確認", "看一下畫面", "測試 user flow", "確認權限是否正確", "測試環境收掉", or asks to confirm a fix or MR behaves correctly in the app.
---

# Verify in browser

Applies to the `platform` repo (`~/Desktop/projects/platform`). Goal: prove the change works the way a user meets it, with evidence. Do not modify code during verification unless the user asks; if the user says "主要是先看畫面測試", only observe and report.

## 1. Pick the code to run

| Target | Where | Port |
|---|---|---|
| Current branch, anyinsight | repo root, `pnpm dev:anyinsight` | 5173 |
| Current branch, geniebench | repo root, `pnpm dev:geniebench` | 5174 |
| Someone else's MR | worktree `.worktrees/review/mr-<n>` | 5180 (next free 518x if taken) |

MR worktree setup:

```bash
git fetch origin <source-branch>
git worktree add .worktrees/review/mr-<n> origin/<source-branch>
ln -s "$PWD/node_modules" .worktrees/review/mr-<n>/node_modules
ln -s "$PWD/.env" .worktrees/review/mr-<n>/.env
cd .worktrees/review/mr-<n> && VITE_APP=anyinsight nohup ./node_modules/.bin/vite --port 5180 --strictPort > <scratchpad>/vite-mr-<n>.log 2>&1 &
```

If the user says to switch branches instead of a worktree ("worktree 刪掉，直接切到那個分支"), do that and use 5173.

## 2. Check the environment

```bash
for p in 5173 5174 5180 8000 8001; do printf "%s: " $p; lsof -nP -tiTCP:$p -sTCP:LISTEN >/dev/null && echo listening || echo free; done
pid=$(lsof -nP -tiTCP:5173 -sTCP:LISTEN | head -1); lsof -a -p $pid -d cwd -Fn | grep ^n
```

- A port that is already listening may belong to another worktree. Confirm the server's cwd matches the target in step 1. If it does not, ask before killing it.
- Backend: `.env` points at `localhost:8000` (API) and `localhost:8001` (dashboard API). Check both with `curl -s -o /dev/null -w "%{http_code}"`; any HTTP status means the process is up. If a backend is down, tell the user which one and stop. A blank page tested against a dead backend proves nothing.
- Start a dev server only when none is running for the target. Run it in the background, log to the scratchpad, and remember that this skill started it (needed for cleanup).
- Wait until the dev server returns 200 before opening the browser.

## 3. Open the browser

- Default: `claude-in-chrome`. It uses the user's own Chrome, so the login session persists.
- Use `chrome-devtools` only for viewport emulation or performance traces.
- Call `tabs_context_mcp` first, then open a new tab. Never reuse or close the user's own tabs.

## 4. Login

If the page lands on the login screen, ask the user to log in in that tab and wait for their reply. Never type credentials. Never conclude "需要登入，沒辦法重現" and skip verification. For permission checks that need a different role, tell the user which role or account to switch to and wait.

## 5. List what to verify

Derive the checklist before clicking anything:

- Source: the diff (`git diff dev...HEAD --stat`), the Jira ticket, the MR description, or review comments the user wants confirmed.
- Map changed pages to routes via `src/config/app-config/path.ts`.
- For each item, write the action and the expected result. Show the list to the user, then start.

## 6. Verify

For every item:

- Perform the actual interaction (click, type, switch tab, submit). Loading a page alone is not verification.
- Console: `read_console_messages` with pattern `Warning|Error`. Report new messages verbatim (for example `validateDOMNesting`, `Missing Description or aria-describedby`).
- Network: `read_network_requests` for 4xx/5xx, duplicate requests, and requests that should have been aborted or deferred.
- Layout changes: also check a mobile width with `resize_window` (or `chrome-devtools` `emulate`).
- When a result is visual, take a screenshot and look at it.

## 7. Report

One line per checklist item: pass / fail, plus evidence (console line, request, or what the screen showed). List anything that was not verified and why. When verifying an MR's review comments, state for each comment whether the behavior matches the claim.

## 8. Clean up

Run this when verification ends, or when the user says "測試環境收掉":

- Close only the tabs this skill opened.
- Kill only the dev servers this skill started: `kill $(lsof -tiTCP:<port> -sTCP:LISTEN)`. Ask before stopping a server the user started (usually 5173).
- MR worktree: remove the symlinks, then `git worktree remove .worktrees/review/mr-<n>`.
