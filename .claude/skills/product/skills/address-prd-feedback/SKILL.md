---
name: address-prd-feedback
description: Answer every piece of feedback on a PRD, one at a time — change the PRD, or say why not, never silently resolve. Use when a PRD has comments waiting, from the tech team's or the data team's review, or from anyone else who has read it.
---

<!-- Net-new: no upstream counterpart in mattpocock/skills at 2ab9580 (checked skills/engineering and skills/productivity) — see the plugin's lock.md. -->

# Address

**How you sound.** Load the `product-config` skill before your first reply and read
its Voice section, whole. You are talking to a product manager — address them as "you", never in the third
person and never by an assumed name or gender. Their words (PRD, QA, rollout, scope) yes,
machinery no — never a skill name, a status label, a rev number, or a count of tickets.
Answer in the first line, one idea per line, an opinion rather than a menu, and end with
who does what next.

Comments arrive from everywhere — the tech team's bounce, the data lead's review, `/send-prd-to-dev`'s own gate failures, a stakeholder reading the document. Address treats them all the same way: **every comment is a mini-ticket.** It resolves in exactly one of three ways — the document changes, a reply says why it won't, or the point proves to be an open decision and joins the map as a ticket. Silence is not a resolution.

## The walk

1. Fetch the issue and enumerate its open comments per the tracker doc. Present the list — who, what it concerns, what it asks — then walk it **one comment at a time**.
2. For each, check the page's **full comment history** first — not just open
   threads: review rounds arrive as fresh comments, so a point a prior round already
   answered only shows up by reading the earlier replies and the re-request records.
   A re-raised point belongs to the same-point-twice rule below, not to this menu.
   Then propose exactly one of:
   - **Fix** — the edit to the section the comment concerns, shown before writing.
   - **Decline** — a drafted reply explaining why not, citing the ticket or decision that settled the point. Link the *why*; don't re-argue it from memory.
   - **Ticket** — the comment names a missing decision: nothing to fix, nothing settled to cite. File the ticket per the tracker doc — Open, unassigned, linked to this issue — and reply linking it, so the thread closes on the map's record, never on a promise. `/refine-prd`'s checkpoint wires it in on its next pass. Deciding it inline would bypass the map; declining it would lose it.
3. **The human approves each outcome before any write.** Fixes follow the tracker doc's section-writing act; replies post on the comment's own thread — opening with the AI line and saying only what the raiser can't see for themselves, per the tracker doc's reply act. A reply is one sentence, two at the most; anything longer belongs in the document.
4. Resolve a thread only after its fix or reply has landed. A thread resolved with neither is this skill's one failure mode.

## The second-bounce rule

If a comment re-raises a point a previous round already addressed — same question, second lap — stop treating it as a comment. That is a disagreement about where the boundary sits, not a clarity gap: name the PO and the tech lead, say the loop is paused for a human conversation, and leave the thread open.

## After the walk

Report: fixed, declined, ticketed, escalated — each by name, with links. If the comments rode a review verdict (`Changes requested` on either flag), the walk ends by re-requesting that review — the verdict is the reviewer's to give again — and the re-request comment **lists the points addressed, one line each**: that list is what the next round's walk reads to spot a re-raised point. **The whole close is one package behind one line**: the fixes, the thread replies, the flag back to `Requested`, and its ledger comment are shown and land together — the ledger is plumbing, and plumbing never earns a second confirmation. When the objection came at the gate or at the handoff (`Ready for development`), the addressed document goes back through `/send-prd-to-dev` — an early-phase verdict just gets its re-request, the gate isn't due yet — and only after the map absorbs anything the walk ticketed: an open ticket fails the gate by definition, so ticketed decisions resolve first (`/refine-prd` and the resolvers, as ever). Address itself flips no phase.
