---
name: no-comments
description: Strip low-value comments from a diff or given files, following the project's "default to no comments" rule. Use on "刪註解", "no comments", "清掉註解", "review 這段的 comment", or before committing when comments look like noise.
---

# No comments

Default to no comments. A comment earns its place only when it explains a non-obvious *why* that code cannot. Everything else is noise — delete it.

## Scope

Use the files or diff the caller names. Otherwise use the current diff against the base branch (default `dev`), including the working tree:

```bash
git diff dev...HEAD
git diff
```

Only touch comments on lines the scope covers. Never rewrite application code except to replace a comment with a better name or an extracted constant/function.

## Delete these

- Narration of what the code already says (`// loop over users`, `// set state`, comments restating a rename).
- Block comments explaining a change you made — that belongs in the commit message or MR.
- Commented-out code.
- Banners and section dividers.
- A *why* comment that a better name or an extracted well-named constant/function would make unnecessary. The bar is high: a note about a library timing pitfall or why a magic number was picked does **not** qualify — rename or extract instead.

## Keep these

- Legal / license headers.
- A genuinely non-obvious *why* that no naming can express — forced by an external dependency, platform, or protocol you cannot reshape.
- Doc comments defining a public API contract.
- Issue / RFC links explaining a constraint the code cannot express.

When unsure a keep applies, delete it.

## Lint / TS suppressions

`// eslint-disable*`, `// @ts-ignore`, `// @ts-expect-error`, `// prettier-ignore`: the project forbids these — fix the root cause instead of suppressing. Flag each one with the underlying issue to fix, not the suppression to keep.

## Steps

1. Read the scope's comments.
2. Delete everything in **Delete these**. For a *why* that a name would kill, rename the symbol or extract a constant/function, then delete the comment.
3. Leave **Keep these** untouched.
4. Report: deletion count, kept comments (one line each, why), and any suppression that needs a root-cause fix.
