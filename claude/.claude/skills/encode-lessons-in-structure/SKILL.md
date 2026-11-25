---
name: encode-lessons-in-structure
description: Turn a recurring correction into a mechanism (type, lint rule, script, runtime check, CI step) instead of another line of instructions. Use when the user corrects the same thing a second time, when you are about to write a rule into AGENTS.md / CLAUDE.md / a skill / memory that already exists there in some form, when a review keeps flagging the same pattern, or when the user says "又來了", "每次都", "怎麼又", "可以擋掉嗎", "能不能變成 lint".
---

# Encode lessons in structure

Adapted from poteto's `principle-encode-lessons-in-structure` (github.com/poteto/plugins, pstack).

A written rule only works if the reader notices it, remembers it, and follows it. A mechanism works without cooperation. When the same correction comes up twice, the written rule has already failed once; adding more text repeats the failure.

## When a correction comes in

1. **One-off or pattern?** A pattern is the same correction seen before (in this session, in memory, in AGENTS.md, in a skill, or in past review comments). Search memory and AGENTS.md before deciding.
2. **One-off:** record it in memory if it is non-obvious, and move on.
3. **Pattern:** pick the strongest mechanism that can enforce it, from strongest to weakest:
   1. Make the wrong state unrepresentable: a type, a required prop, a single helper that is the only way to do the thing.
   2. A check that fails CI: a lint rule (in `platform`: `no-restricted-imports` / `no-restricted-syntax` in `.oxlintrc.json`, or ESLint), a script wired into `pnpm lint` or `.gitlab/ci/cicd.yml`, a test that scans the codebase.
   3. A runtime check or assertion at the boundary where the mistake enters.
   4. A hook in `settings.json` (PreToolUse / PostToolUse) for mistakes in how the agent works rather than in the code.
   5. Text, as a last resort: only when the rule needs judgment that no mechanism can make.
4. **Encode it, then delete the text it replaces.** Leaving both makes the text drift from the mechanism. Remove or shorten the matching line in AGENTS.md, the skill, or memory, and point to the mechanism instead.
5. **If it has to stay text,** make it prominent and add one concrete example of the failure it prevents.

Pick the strongest rung that fits. Agents and people copy whatever the surrounding code already does, so a weak guard becomes the template for the next change.

## Do not

- Say "I'll keep that in mind." Nothing persists from that.
- Record a lesson that names a missing lint rule without writing the lint rule or proposing it to the user.
- Fix the single instance the user pointed at while the same pattern sits elsewhere. Grep for siblings.
- Change shared mechanisms (repo lint config, CI, AGENTS.md) without showing the user the diff first.

## Report

State: the correction, why it counts as a pattern (where it was seen before), the mechanism chosen and why a stronger rung did not fit, and which text was removed.
