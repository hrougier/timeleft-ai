---
name: send-prd-to-dev
description: Read a PRD as its first outside reader would, then either hand it to the tech team or leave a comment on everything that is not ready yet. Use when a PRD looks finished.
---

<!-- Net-new: no upstream counterpart in mattpocock/skills at 2ab9580 (checked skills/engineering and skills/productivity; code-review reviews diffs, to-spec writes specs — neither is a document gate) — see the plugin's lock.md. -->

# To tech

**How you sound.** Load the `product-config` skill before your first reply and read
its Voice section, whole. You are talking to a product manager — address them as "you", never in the third
person and never by an assumed name or gender. Their words (PRD, QA, rollout, scope) yes,
machinery no — never a skill name, a phase label, a rev number, or a count of tickets.
Answer in the first line, one idea per line, an opinion rather than a menu, and end with
who does what next.

The last product-side act. `/refine-prd`'s checkpoint challenges the *map*; this gate challenges the **document** — read the PRD as the tech team will: an outside reader who attended none of the grillings, with only the page and its links in front of them.

## Before anything

Load the Workflow Contract per the tracker doc's phase rules; if it is unreachable, stop. This skill performs the handoff transition — it never guesses one.

If this session is the one that just refined, resolved, or addressed comments on this PRD, say so and suggest running the gate from a fresh session instead — the whole point of this check is reading the document the way its first outside reader will, and a session that sat through the grillings already knows too much to read it that way. Proceed here anyway if the human would rather not switch; never block on it.

## The gate

Walk all seven checks and collect every failure — don't stop at the first; the tech team wouldn't.

1. **The map is clear.** No open tickets, and nothing in Not yet specified that isn't consciously parked with a reason. An open decision is an automatic fail — the way isn't clear yet.
2. **Decisions are folded.** Spot-check Decisions-so-far against the document: each decision's *what* must live in the section it affects. A decision that exists only on its ticket is a fold-back failure.
3. **No open comments, no pending review.** Every thread resolved the `/address-prd-feedback` way — fixed, answered, or ticketed, never silently. A review flag at `Requested` with no verdict is an open question: wait for the verdict, or withdraw the request explicitly (shown, and recorded in a comment). `Changes requested` on either flag is an automatic fail.
4. **The handoff surface is complete.** The sections the tech team reads are filled — requirements, scope, out of scope, the standard questions — and placeholder text survives only in sections a later phase owns. **How it ships changes what's owed**: if the PRD is marked as an A/B experiment, the success metric and the variants belong in the document — an experiment nobody can call is not a plan; a gradual market rollout owes the market order. Unmarked owes neither. And if the Ops team is involved or leading, the handoff has a third audience — name that, don't leave the tech team to notice.
5. **It reads alone.** Terms match the glossary; problem, goals, and needs parse without any conversation context; every link — prototype, decisions, tickets — resolves. A sentence that needs a grilling transcript to understand fails.
6. **Declared data work carries its approval — a live one.** If Data Requirements names new data work, `Data review` must read `Approved`, and the approval must postdate the content it covers: an `Approved` stamped at a rev before the reviewed sections last changed is spent, and counts as pending (re-request, don't ride it). The fix is requesting the review and waiting on the data lead, not softening the check.
7. **Prerequisites are named, not hidden.** If the PRD depends on another, say so in the handoff — each one and where it stands — so the tech team sequences with its eyes open. A prerequisite still in flight is not a failure: they can build against it. One at `Rejected` is, because nothing will ever satisfy it. And if a dependency is the reason to wait, that's the PO's call to park, not the gate's.

## Two exits

- **Fail** — each failure becomes one comment on the document, anchored to the section it concerns, drafted and shown to the human before posting. The phase does not move. `/address-prd-feedback` walks the comments; the gate reruns after.
- **Pass** — flip the issue to `Ready for development` under the tracker doc's phase rules, and report what was verified. The review verdicts ride across untouched — the handoff is the one flip that spends nothing, since it changes whose court the PRD sits in rather than what the document says — and the pass comment names the rev each verdict was stamped at, so tech can see what was approved and when. From here the tech team's triage takes it: acceptance flips `In development` with the issue link back-filled; a disagreement comes back as `Tech review: Changes requested` with anchored comments — the status stays put, the flag says it's product's move.

Never soften a failure into a pass with caveats. A caveat on a handoff is a comment the tech team has to discover for themselves — the gate exists so they never have to.
