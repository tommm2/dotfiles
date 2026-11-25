---
name: note
description: Turn what the user learned in this conversation into a personal note in their note repo, recording their own understanding (what confused them, how concepts relate, conclusions for their situation) rather than facts they could look up. Use only when the user explicitly asks, via /note [folder] or "記筆記", "寫成筆記", "整理成筆記". Never offer it unprompted.
---

# Note

Write the user's understanding from this conversation into a Markdown note, then commit and push it. Argument: an optional target folder.

## Where the note goes

Root: `$NOTE_DIR`, or `~/Desktop/projects/note` when it is unset. It is a git repo (`https://github.com/tommm2/note.git`, private). Each machine sets `NOTE_DIR` in its own `~/.claude/settings.json` under `env`; never hardcode `/Users/<name>`.

Folder, from the argument or from the request in plain words ("放 auth 資料夾"):

- none: `<root>/learning/`
- a relative path such as `auth` or `infra/aws`: `<root>/<path>/`, created if missing
- starting with `/` or `~`: that absolute path, used as is

If the root does not exist, ask whether to clone the repo there. On yes, run `git clone https://github.com/tommm2/note.git "$root"`. If the clone fails (for example `gh` is not logged in on this machine), stop and show the error. Never fall back to writing somewhere else.

## What goes in

Record the user's own understanding. Do not record what a web search or the docs would answer: syntax, protocol details, full attribute lists, library APIs.

Keep only these three kinds of point:

1. **Points of confusion.** Read them off the user's questions. A question asked twice, or a "X 是啥" partway through, marks one. Write down what was confusing and what resolved it.
2. **How concepts relate, and how to decide between them.** For example: "Entra ID 不是雲端版 AD，協定不同", "客戶只有 AD 就走 LDAP，有同步到 Entra 就走 OIDC".
3. **Conclusions for the user's own situation.** Decisions, trade-offs, open items.

A definition gets one line at most, with a source link next to it. Leave out options the conversation rejected, one-off grep output, and anything the user said to set aside.

Example entry:

```
- UPN 長得像 email，但它是登入名稱，不保證能收信。
  我們用它當 key，因為只有 IT 改得了；mail 使用者自己就能改。
  要注意：AD 網域是 corp.local 時，同步到 Entra 後 UPN 會變，兩邊對不上。
```

## File layout

One file per topic, named in English kebab-case (`ad-entra-identity.md`). Before creating one, look through the target folder for a note on the same topic (filenames, `title`, `tags`). If one exists, update it instead of creating a second.

```markdown
---
title: AD 與 Entra ID 身分整合
date: 2026-11-25
status: active
tags: [auth, ad, entra, anyinsight]
---

## 概念

## 在 <project> 的狀況（2026-11-25）

## 待確認
```

- `date`: the last-updated date, rewritten on every update.
- `status`: one of the Inkdrop values `active`, `onHold`, `completed`, `dropped`. Set `active` when `待確認` has items, `completed` when it has none. Never set `onHold` or `dropped` yourself, and keep either one if the user already set it.
- `tags`: first collect the tags already used in the root (`grep -rh '^tags:' "$root"`). Reuse an existing tag before inventing a synonym (`auth`, not `authentication`).
- `## 概念`: what holds outside any project.
- `## 在 <project> 的狀況（date）`: code locations, existing bugs, decisions. It goes stale, so it carries its date. On update, rewrite this section and its date. Omit the section when the topic has no project tie.
- `## 待確認`: unverified points and open decisions. Omit it when empty.

## Writing

- zh-TW. Technical terms and code identifiers stay in their original form.
- Full-width Chinese punctuation (，。：；（）「」).
- No em-dashes, no metaphors, no signpost labels ("一句話", "重點是", "講清楚"), no heavy bold. Plain declarative sentences.

## Flow

1. **Propose.** Show, without writing anything yet:
   - the target path and filename, and whether it is a new file or an update to an existing one
   - the frontmatter
   - the entries planned for each section, one line each
2. **Wait for confirmation.** Apply the user's cuts and additions.
3. **Sync.** If the target folder is inside a git repo, run `git -C "$root" pull --rebase`. If the pull fails (a conflict, no network), stop and report it. Never force anything.
4. **Write** the file.
5. **Commit and push** when the folder is inside a git repo: `note: add <filename>` or `note: update <filename>`, then `git push`. For a folder outside any git repo, write the file only and say so.
6. **Report** the file path and the commit, in one or two lines.
