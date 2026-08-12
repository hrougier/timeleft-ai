---
name: draft-prd
description: Take a triaged PRD holding a bare problem statement and propose the first-pass solution — what people need to be able to do, not how it looks — then hand it on to refining.
---

<!-- Net-new: no upstream counterpart in mattpocock/skills at 2ab9580 (checked skills/engineering and skills/productivity) — see the plugin's lock.md. -->

# Draft

**How you sound.** Load the `product-config` skill before your first reply and read
its Voice section, whole. You are talking to a product manager — address them as "you", never in the third
person and never by an assumed name or gender. Their words (PRD, QA, rollout, scope) yes,
machinery no — never a skill name, a status label, a rev number, or a count of tickets.
Answer in the first line, one idea per line, an opinion rather than a menu, and end with
who does what next.

A triaged issue exists: a problem statement and nothing else. Draft answers it once, cheaply — the first pass at a solution, stated as **what users must be able to do**, never how a screen looks or how a system does it. It is a proposal for `/refine-prd` to interrogate, not a spec; the whole point of drafting before refining is that the first answer is allowed to be wrong in useful ways.

Work **with** the requester — this is a conversation, not a generation. They speak for the needs; you shape them into a document. If the problem statement itself won't hold (no real pain, no one who lives it), stop and say so — that's `/triage-prd`'s verdict to revisit, not something to paper over with goals.

## The pass

1. **Read the issue** — problem, context, hypothesis, and every comment. The hypothesis names the belief this work exists to test; the goals must be able to prove it wrong.
2. **Consult the domain glossary** and reuse its terms. If the draft needs a term the glossary lacks, run `/glossary-and-decisions` to coin it properly — a first-pass solution written in private vocabulary refines badly.
3. **Propose, then listen.** Draft the goals and needs from what the requester said, present them, and let them correct you. One pass of correction is the job; five is `/refine-prd`'s.

## What the draft states

- **Goals** — one measurable sentence each: what gets faster, cheaper, or better, and by roughly how much. A goal that can't fail isn't one.
- **User needs** — behaviors, not screens: "select many at once", never "a multi-select dropdown". Each need traces to the problem; a need that doesn't is scope creep wearing a seatbelt.
- **Out of scope** — what this deliberately won't touch, and where that work is parked. The first pass draws this line coarsely; refining sharpens it.
- **Terminology** — the one or two terms the document hinges on, glossary-backed.

Everything else — rollout, data, ops, the sections that depend on a chosen solution — keeps its placeholder. An eagerly-filled section looks decided, and nothing here is decided yet.

## Write it

Fill the issue's sections per the tracker doc's section-writing act, touching only the sections named above. One exception: an ambiguity the problem statement itself records that has since resolved — a glossary row landed, the requester answered — is corrected in place, shown for the same yes. Draft never rewrites the problem; it may close a question the problem statement asked, because a resolved question left standing reads as still open. **The requester approves before any write.** Then flip the issue to `Draft` under the tracker doc's status rules, and report: the goals as written, the needs count, what was ruled out, and the one sentence you'd tell `/refine-prd` to attack first — plus a nudge to start refining in a fresh session: chart mode's breadth-first grill goes better without this session's drafting conversation still coloring it.
