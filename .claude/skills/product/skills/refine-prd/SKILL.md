---
name: refine-prd
description: Work out what is still undecided in a PRD. Put the open questions on it, then settle them one at a time — some by going and finding out, some by talking them through with you — until the PRD is ready to hand over. Use it again later to challenge a plan that has drifted.
---

<!-- Vendored word-for-word from mattpocock/skills skills/engineering/wayfinder at 2ab9580, plus 12 audited patches (P1–P12) — see the plugin's lock.md for the drift records. -->

A loose idea has arrived — too big for one agent session, and wrapped in fog: the way from here to the **destination** isn't visible yet. Wayfinding is about finding that way, not charging at the destination. This skill charts the way as a **shared map** on the repo's issue tracker, then works its **decision tickets** — questions whose resolution is a decision, not slices of a build to execute — one at a time until the route is clear.

The destination varies per effort, and naming it is the first act of charting — it shapes every ticket. It might be a spec to hand off and iterate on, a decision to lock before planning starts, or a change made in place like a data-structure migration. The map is domain-agnostic — engineering work, course content, whatever fits the shape.


**How you sound.** Load the `product-config` skill before your first reply and read
its Voice section, whole. You are talking to a product manager — address them as "you", never in the third
person and never by an assumed name or gender. Their words (PRD, QA, rollout, scope) yes,
machinery no — never a skill name, a status label, a rev number, or a count of tickets.
Answer in the first line, one idea per line, an opinion rather than a menu, and end with
who does what next.

## Plan, don't do

Wayfinder is **planning** by default: each ticket resolves a decision, and the map is done when the way is clear — nothing left to decide before someone goes and does the thing. The pull to just do the work is usually the signal you've reached the edge of the map and it's time to hand off. An effort can override this in its **Notes** — carrying execution into the map itself — but absent that, produce decisions, not deliverables.

## Refer by name

Every map and ticket is an issue, so it has a **name** — its title. In everything the human reads — narration, the map's Decisions-so-far — refer to it by that name, never by a bare id, number, or slug. A wall of `#42, #43, #44` is illegible; names read at a glance. The id and URL don't vanish — a name wraps its link — but they ride *inside* the name, never stand in for it.

## The Map

The map is a single issue on this repo's issue tracker, labelled `wayfinder:map` — the canonical artifact. Its tickets are child issues of the map. **This tracker expresses that differently and its doc wins**: there is no separate map issue and no such label — the PRD *is* the map, and the phase plays the label's part. Never file a row to hold one.

The map is an **index**, not a store. It lists the decisions made and points at the tickets that hold their detail; a decision lives in exactly one place — its ticket — so the map never restates it, only gists it and links.

**Where the map, its child tickets, blocking, and frontier queries physically live is tracker-specific.** The issue tracker should have been provided to you — the binding lives in the **`product-config`** skill — load it and read its `issue-tracker.md`. Consult that document's "Wayfinding operations" section for how _this_ tracker expresses them.

### The map body

The whole map at low resolution, loaded once per session. Open tickets are **not** listed — they are open child issues, found by query.

```markdown
## Destination

<what reaching the end of this map looks like — the spec, decision, or change this effort is finding its way to. One or two lines; every session orients to it before choosing a ticket.>

## Notes

<domain; skills every session should consult; standing preferences for this effort>

## Decisions so far

<!-- the index — one line per closed ticket: enough to judge relevance, then zoom the link for the detail the ticket holds -->

- [<closed ticket title>](link) — <one-line gist of the answer>

## Not yet specified

<!-- see "Fog of war": in-scope fog you can't ticket yet; graduates as the frontier advances -->

## Out of scope

<!-- see "Out of scope": work ruled beyond the destination; closed, never graduates -->
```

### Tickets

Each ticket is a **child issue** of the map; the tracker's issue id is its identity. Its body is the question, sized to one 100K token agent session:

```markdown
## Question

<the decision or investigation this ticket resolves>
```

Each ticket carries a `wayfinder:<type>` label — one of `research`, `prototype`, `grilling`, `task` (see [Ticket Types](#ticket-types)).

A session **claims** a ticket by assigning it to the dev driving the map, **first**, before any work, so concurrent sessions skip it. That assignee _is_ the claim: an open, unassigned ticket is unclaimed.

Blocking uses the tracker's **native** dependency relationship — essential because it renders the frontier _visually_ in the tracker's own UI, so the human sees what's takeable without opening the map. Only a tracker that lacks native blocking falls back to a body convention. A ticket is **unblocked** when every ticket blocking it is closed; the **frontier** is the open, unblocked, unclaimed children — the edge of the known.

The answer isn't part of the body — it's recorded on resolution (see [Work through the map](#work-through-the-map)). Assets created while resolving a ticket are linked from the issue, not pasted in.

## Ticket Types

Every ticket is either **HITL** — human in the loop, worked *with* a human who speaks for themselves — or **AFK**, driven by the agent alone. A HITL ticket only resolves through that live exchange; the agent never stands in for the human's side of it (a grilling agent that answers its own questions has broken this).

- **Research** (AFK): Reading documentation, third-party APIs, or local resources like knowledge bases to surface a fact a decision waits on. Resolved by a `/research` **subagent**. Use when knowledge outside the current working directory is required.
- **Prototype** (HITL): Raise the fidelity of the discussion by making a cheap, rough, concrete artifact to react to — an outline, a rough take, a stub, or UI/logic code via the /design-prd skill. Links the prototype as an asset. Use when "how should it look" or "how should it behave" is the key question.
- **Grilling** (HITL): Conversation via the /grilling and /glossary-and-decisions skills, one question at a time. The default case.
- **Task** (HITL or AFK): Manual work that must happen before a *decision* can be made — nothing to decide, prototype, or research, but the discussion is blocked until it's done. Signing up for a service so its API can be judged, provisioning access, moving data so its shape can be seen. This is the one type that *does* rather than decides — and it earns its place by unblocking a decision, not by delivering the destination. The agent drives it alone where it can (AFK); otherwise it hands the human a precise checklist (HITL). Resolved when the work is done; the answer records what was done and any resulting facts (credentials location, new URLs, row counts) later tickets depend on.

## Ticket budget

A map carries at most **3 research**, **3 grilling**, and **1 prototype** ticket at any time. The budget is not a cap on questions — it is a forcing function to **fold** them.

Fold by theme, never cut. Cluster open decisions by the conversation that would naturally settle them: two questions belong in the same session when answering one reshapes the other, or when the human needs the same context in their head for both. Name the ticket after the theme and list the folded decisions as sub-questions in its body; the session resolves them together, and the resolution comment records each decision individually, so the map's index loses nothing to the fold.

The budget is a **ceiling, not a quota**. Three grilling tickets is the most a map may carry, never a number to hit — an empty slot is not a missing ticket, and a settled question (see Fog of war) never spends a slot.

One prototype, always: every look-and-behavior question converges on a single artifact, with as many screens and states as it needs. A question cheaper to *react to* than to discuss folds into the prototype ticket as a review prompt, not a grilling session.

Overflow goes to the fog — a question that fits no theme usually isn't sharp enough yet; park it in **Not yet specified**. One exception: a question that arrives already sharp — an inbound note's named decision — never parks in fog; fold it into the nearest theme even when the fit is imperfect, and say so on the ticket. Never create a fourth ticket of a type to dodge a fold, and never silently drop a question to fit the budget: it lands in a ticket body, a review prompt, or the fog, always somewhere a reader can find it.

## Fog of war

The map is _deliberately_ incomplete: don't chart what you can't yet see. Beyond the live tickets lies the **fog of war** — the dim view of decisions and investigations you can tell are coming but can't yet pin down, because they hang on questions still open. Resolving a ticket clears the fog ahead of it, graduating whatever's now specifiable into fresh tickets — one at a time, until the way to the destination is clear and no tickets remain.

The map's **Not yet specified** section is where that dim view is written down: the suspected question, the area to revisit later. It's the undiscovered frontier _toward_ the destination — everything here is in scope, just not sharp enough to ticket. Write as loosely or as fully as the view allows; it doubles as a signpost for collaborators reading where the effort is headed.

**Fog or ticket?** The test is whether you can state the question precisely now — _not_ whether you can answer it now.

- **Ticket when** the question is already sharp — even if it's blocked and you can't act on it yet.
- **Not yet specified when** you can't yet phrase it that sharply. Don't pre-slice the fog into ticket-sized pieces: it's coarser than a ticket, and one patch may graduate into several tickets, or none, once the frontier reaches it.

**Decide or look up?** Sort this before you ask anything: a question whose answer is a fact about what the product does today has no side to take and nobody here to ask — establish it yourself first, per the tracker doc's creating-a-ticket act, and sort only what survives.

**Sharp or settled?** The fog test asks whether you can state the question — not whether it deserves a session. And charting is already a conversation, so never sort that alone: **put the sharp question to the human in one line, with your recommended answer.** Their reaction does the sorting.

- **A nod settles it.** Don't open a ticket just to close it: fold the answer, and the reasoning that killed the alternatives, into the part of the destination it changes — the same fold-back a resolved ticket produces, minus the ticket. A decision that outlives the effort goes to the decision record. (Decisions so far indexes closed tickets; a decision that never had one doesn't belong there.)
- **A hesitation is the ticket.** So is a counter-answer, a "let me think", or a question back — two answers just survived being said out loud, and that's what tickets are for.

A ticket whose whole session is you recommending and the human agreeing was never a question — it was a line you already knew how to write. The reasoning still gets recorded; it costs a sentence instead of a session. And the real cost isn't the session: a map padded with foregone conclusions no longer shows where the risk sits.

**Not yet specified** excludes what's already decided (Decisions so far), what's already a live ticket, and what's out of scope (the next section).

## Out of scope

Fog only ever gathers _toward_ the destination. The destination fixes the scope, so work beyond it is **out of scope** — it isn't fog, and it doesn't belong in **Not yet specified**. It gets its own **Out of scope** section on the map: work you've consciously ruled out of _this_ effort. Scope, not sharpness, lands it here.

Out-of-scope work never graduates — the frontier stops at the destination — so it returns only if the destination is redrawn, and then as a fresh effort, not a resumption.

Ruling something out of scope is a scoping act, not a step on the route. When a ticket that already exists turns out to sit past the destination — mis-scoped in while charting, or exposed by a resolution — **close it** (a closed ticket is unambiguously off the frontier) and leave one line in the **Out of scope** section: the gist plus why it's out of scope, linking the closed ticket. It stays out of **Decisions so far**, which records the route actually walked — a scope boundary isn't a step on it.

## Invocation

Two modes. Either way, **never resolve more than one ticket per session** — with the exception of research tickets.

### Chart the map

User invokes with a loose idea.

On this tracker the loose idea arrives already drafted — an issue whose problem statement and first-pass solution `/triage-prd` and `/draft-prd` have shaped. Chart against it: the map lives on that issue per the tracker doc, and creating the map flips it to `In Refinement` under the tracker doc's phase rules.

1. **Name the destination.** Run a `/grilling` and `/glossary-and-decisions` session to pin down what this map is finding its way to — the spec, decision, or change. The destination fixes the scope, so it's settled first.
2. **Map the frontier.** Grill again, **breadth-first** this time: fan out across the whole space rather than deep on any one thread, surfacing the open decisions and the first steps takeable now. **If this surfaces no fog** — the way to the destination is already clear, the whole journey small enough for one session — you don't need a map. Stop and ask the user how they'd like to proceed.
3. **Create the map** (label `wayfinder:map`, or what the tracker doc puts in its place): Destination and Notes filled in, Decisions-so-far empty, the fog sketched into **Not yet specified**.
4. **Create the tickets you can specify now** as child issues of the map — then wire blocking edges in a **second pass** (issues need ids before they can reference each other). Wiring sorts them into the frontier and the blocked; everything you can't yet specify stays in the fog — the **Not yet specified** section.
5. **Claim, then fire the research subagents.** **Claim every `research` ticket first** — the subagent has no identity on the tracker and cannot claim for itself, so an unclaimed one keeps advertising itself on the frontier while an agent is already working it. Then spin up a `/research` subagent per ticket, in parallel. **Findings land where the tracker doc says they land** — the shared `/research` skill deliberately names no destination, so pass it the binding rather than letting it choose one.
6. Stop — charting is one session's work; it hand-resolves nothing.

### Work through the map

User invokes with a map (URL or number). A ticket is **optional** — without one, you pick the next decision, not the user.

1. Load the **map** — the low-res view, not every ticket body.
2. Choose the ticket. If the user named one, use it. Otherwise take the first frontier ticket in order. **Claim it**: assign it to yourself before any work.
3. Resolve it — **read its comments before anything else**, per the tracker doc's pick-up act: a comment is a constraint the human added after the ticket was written, and it is hidden unless you ask for it. Then **zoom as needed**: fetch the full body of any related or closed ticket on demand; invoke the skills the `## Notes` block names. If in doubt, use `/grilling` and `/glossary-and-decisions`.
4. Record the resolution as the tracker doc's resolve act expresses it — **it differs from this line on all three counts** (where the answer goes, what closing means, and whether an index line is written at all), and it is the authority. Read it before you write; don't reconstruct it from here.
5. Add newly-surfaced tickets (create-then-wire); graduate any fog the answer has made specifiable, clearing each graduated patch from **Not yet specified** so it lives only as its new ticket. If the answer reveals a ticket — this one or another — sits beyond the destination, **rule it out of scope** rather than resolving it on the route. If the decision invalidates other parts of the map, update or delete those tickets.

The user may run unblocked tickets in parallel, so expect other sessions to be editing the tracker concurrently.

### Checkpoint

Invoked on a map already refining, with no ticket named and substance in hand — inbound notes, a challenge, "does this still hold?" — the session re-evaluates instead of resolving: read the map and its issue as they now stand, verify every decision folded back actually landed in the issue body, surface holes as new tickets (create-then-wire, the budget binds), graduate ripened fog, and rule mis-scoped tickets out. A plain "what's next" is not a checkpoint — that's a frontier read. Challenge the *map* here; challenging the *document* is `/send-prd-to-dev`'s job.
