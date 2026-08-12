---
name: design-prd
description: Answer a PRD's design question by designing it — blocked until every other open question on the PRD is settled, so it's always the last one. The PRD moves to In Design while the work happens, and stays there once the question is settled. Use when what a screen or a flow should look like is the thing holding the PRD up.
---

<!-- Vendored word-for-word from mattpocock/skills skills/engineering/prototype at 2ab9580, plus 4 audited patches (P1–P4) — see the plugin's lock.md for the drift records. -->

# Prototype

**How you sound.** Load the `product-config` skill before your first reply and read
its Voice section, whole. You are talking to a product manager — address them as "you", never in the third
person and never by an assumed name or gender. Their words (PRD, QA, rollout, scope) yes,
machinery no — never a skill name, a status label, a rev number, or a count of tickets.
Answer in the first line, one idea per line, an opinion rather than a menu, and end with
who does what next.

**Before anything.** This skill moves the PRD, so it never runs on the skill file alone:
load the `product-config` skill's `issue-tracker.md`, and the Workflow Contract page it
names — if the contract is unreachable, stop. The ticket is claimed before any work, the
PRD's phase moves when it is claimed, and the resolve package is the tracker doc's; none
of that is guessed here.

A prototype is **throwaway code that answers a question**. The question decides the shape.

## Pick a branch

Identify which question is being answered — from the user's prompt, the surrounding code, or by asking if the user is around:

- **"Does this logic / state model feel right?"** → [LOGIC.md](LOGIC.md). Build a tiny interactive terminal app that pushes the state machine through cases that are hard to reason about on paper.
- **"What should this look like?"** → [UI.md](UI.md). Generate several radically different UI variations on a single route, switchable via a URL search param and a floating bottom bar.
- **"What should this look like?" — with no codebase at hand** → a design artifact instead of running code: a Figma file or a generated design output, several radically different takes, made to be reacted to. Here the takes are throwaway but the chosen one is not — it becomes the design the PRD hands onward. The medium, the ritual, and the capture live in the **`product-config`** skill, in its `design-tool.md`. Skip the polish until one is chosen; the ticket's folded **review prompts** are put to the human against it, one at a time, their answers recorded with the verdict.

The two branches produce very different artifacts — getting this wrong wastes the whole prototype. If the question is genuinely ambiguous and the user isn't reachable, default to whichever branch better matches the surrounding code (a backend module → logic; a page or component → UI) and state the assumption at the top of the prototype.

## Rules that apply to both

1. **Throwaway from day one, and clearly marked as such.** Locate the prototype code close to where it will actually be used (next to the module or page it's prototyping for) so context is obvious — but name it so a casual reader can see it's a prototype, not production. For throwaway UI routes, obey whatever routing convention the project already uses; don't invent a new top-level structure.
2. **One command to run.** Whatever the project's existing task runner supports — `pnpm <name>`, `python <path>`, `bun <path>`, etc. The user must be able to start it without thinking.
3. **No persistence by default.** State lives in memory. Persistence is the thing the prototype is _checking_, not something it should depend on. If the question explicitly involves a database, hit a scratch DB or a local file with a clear "PROTOTYPE — wipe me" name.
4. **Skip the polish.** No tests, no error handling beyond what makes the prototype _runnable_, no abstractions. The point is to learn something fast.
5. **Surface the state.** After every action (logic) or on every variant switch (UI), print or render the full relevant state so the user can see what changed.
6. **Capture it when done.** Fold any validated decision into the real code, then capture the prototype itself as a **primary source**: commit it to a throwaway branch, out of main, and leave a context pointer to that branch on the implementation issue. Capture the answer too — the verdict and the question it settled — in the issue or a commit. The main branch keeps only the validated decision. **Where there is no repo to commit to — the design-artifact branch above — the capture is the tracker doc's, not git's**: the chosen take, the verdict and the review prompts' answers land where `design-tool.md` says they land, and nothing branches.
