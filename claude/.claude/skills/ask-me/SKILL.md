---
name: ask-me
description: Check that the user really understands a problem, flow, or change by asking them questions one at a time and correcting the gaps. Use for /ask-me, or when the user says "考我", "問我問題", "確認我懂了沒", "quiz me", "check my understanding".
---

# Ask Me

The user wants to confirm they understand something, not to be told about it again. You ask; they answer; you check the answer against the facts and fix what is missing.

The opposite of /grill-me: grill-me tests a plan, so you propose answers. Here you test the user, so you never give the answer before they have tried.

## Step 1 — Fix the topic and build the answer key

- Topic: the argument if given, else what the conversation is currently about (the bug, the flow, the change just made). State the topic in one line before the first question.
- Build the answer key silently from the code and the conversation, not from memory. Read the files when the facts are not already in context. Every point you will judge against must be traceable to code, a doc, or something the user decided.
- Pick 4–7 key points, ordered from foundation to detail:
  1. What the problem is, and for whom
  2. Why it happens (cause) or why the design is this way (reason)
  3. How the solution or flow works, step by step
  4. Edge cases, failure paths, and trade-offs
  5. Application: what changes if X changes

Do not show the answer key.

## Step 2 — Ask, one question at a time

- One question per message. Wait for the answer.
- Open questions first ("用你自己的話說..."、"如果 X 失敗會怎樣？"). Use multiple choice only for distinguishing two easily confused things.
- Ask about meaning and cause, not trivia (no "what is the function on line 120 called").
- Ask in the user's language. Keep code identifiers as they are.

## Step 3 — Judge each answer

Classify against the answer key and say which it is:

- **Correct** — confirm in one line, add one fact only if it sharpens the point, move on.
- **Partly correct** — say what is right, name the missing or wrong part precisely, give a hint (where to look, which case to consider), and ask once more.
- **Wrong or "不知道"** — explain the point briefly with the file or decision it comes from, then ask a short follow-up that checks the explanation landed.

Never accept a vague answer as correct. If the user's answer is right but differs from the code you assumed, check the code; the user may be right.

## Step 4 — Wrap up

After the key points are covered, or when the user says stop:

- What they understand well (one line each)
- Remaining gaps, each with where to read (`file:line` or the decision)
- Offer one more round on the gaps only

## Rules

- Do not lecture before asking. The explanation comes only after an attempt.
- No trick questions, no score, no praise padding.
- If the user asks a question back, answer it, then return to the current point.
- Stop immediately when the user says stop.
