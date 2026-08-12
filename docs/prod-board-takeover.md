# Taking over the production Product Roadmap Board

The product plugin runs today against the team's own board (the one that grew out of the
HQ sandbox). The production **Product Roadmap Board** is read-only reference — no skill
writes to it, and the three addresses that name it are listed in `issue-tracker.md`.

This file is the ledger for the day that changes. It records what already matches, what
differs, and which differences are deliberate. **Nothing here is scheduled**; the fields
listed under "Not adopted" were examined 2026-08-11 and left alone because their value is
unproven for our workflow.

## What already matches

| Ours | Prod | Note |
| ---- | ---- | ---- |
| `Phase` (status) | `Phase` (status) | renamed 2026-08-11 to match |
| `Dependencies` ⇄ `Blocks` | `Dependency` (one-way) | adopted 2026-08-11 — prod has 12 rows using it, 4 of them active. Ours is **dual** (both directions readable) and plural; prod's single one-way `Dependency` becomes `Dependencies` at takeover |
| `Squad` | `Squad` | renamed 2026-08-11; option list already identical (9 squads) |
| `Quarter` | `Quarter` | identical option-for-option (Q4'25 → Q4'26) |
| `Priority` | `Priority` | identical (High / Medium / Low) |
| `Owner` (person) | `Owner` (person) | same |
| In Design · Ready for development · In development · In QA · Ready to roll out · Rolled out · On Hold | same labels | survive takeover untouched |

## Deliberate divergences (each costs one rename at takeover)

- **`Backlog` → `Draft`** — more explicit about what the row holds.
- **`In PRD` → `In Refinement`** (2026-08-11) — every phase from Draft to Rolled out is
  "in PRD"; the artifact is the constant, so the old label named nothing. The new one
  names the phase.
- **`PRD in product review` and `Done` dissolve** — the first became the two review flags
  (`Data review` / `Tech review`, which are parallel and optional, not phases); the second
  duplicated `Rolled out`.
- **`Ready for data review` → the `Data review` property** — a review is not a phase; it
  runs alongside one.

## Ours that prod has no equivalent for

`Rev` (the revision counter review verdicts are stamped against) · `Data review` /
`Tech review` (the two court flags) · `Tickets` (the synced relation to the decision map) ·
`Decisions` (the ADR relation) · `Tech issue` (back-filled at handoff).

## What prod fills in — measured, 2026-08-11

Declared columns say nothing about use, so this is the fill rate across all **306** prod
rows (123 of them still active). It is the evidence for every adopt/skip call below.

| Prod field | Rows filled | Our equivalent |
| ---------- | ----------- | -------------- |
| `Owner` | 279 (91%) | `Owner` ✓ |
| `Squad` | 240 (78%) | `Squad` ✓ |
| `Quarter` | 218 (71%) | `Quarter` ✓ |
| `Responsible Engineer` | 125 (41%) | `Responsible Engineers` ✓ |
| `Priority` | 81 (26%) | `Priority` ✓ |
| `Figma Link` | 73 (24%) | `Figma` ✓ (real URL, not text) |
| `Jira Link` | 60 (20%) | `Tech issue` ✓ |
| **`Rollout type`** | **49 (16%)** | **none — recommended** |
| **`Ops-Involved` + `Ops-led`** | **48 + 16 (21%)** | **none — recommended** |
| `Experiment` | 37 (12%) | none — needs a database we don't have |
| `Target Release` | 19 (6%) | none |
| `Results` | 17 (6%) | none — see the loop note below |
| `Size` | 9 (3%) | none |
| `Venue Coordinator` | 8 (3%) | none |
| `Cities` | 3 (1%) | none |
| `Design Due Date` | 3 (1%) | none |
| `QA Checklist` | 1 | none |
| `Sent to #data_product` | 1 | superseded by `Data review` |

## Adopted 2026-08-12 on measured usage

- **`Rollout type`** (Global Rollout / Gradual Market Rollout / A/B Experiment, prod's own
  option colours). 49 prod rows, and unlike everything else unadopted it **changes what the
  PRD must contain**: an A/B experiment owes its success metric and variants before handoff,
  a gradual rollout owes the market order. The gate's handoff-surface check now reads it.
  Prod's is identical, so takeover needs no migration here.
- **`Ops`** (`Involved` / `Led`, empty = neither). Prod splits this across two checkboxes
  (`Ops-Involved` 48, `Ops-led` 16 — 64 rows of real use); ours is one select, because the
  two are degrees of one fact and two booleans permit a contradiction. At takeover the two
  checkboxes collapse into this one column. The gate names Ops as a third handoff audience
  when it is set.

  **Left open deliberately:** we gate on `Data review: Approved` when a PRD declares new
  data work, and there is no equivalent for a PRD the Ops team has to *run*. An `Ops review`
  flag would close that asymmetry — not proposed, because "a third review axis" is the
  trigger recorded for revisiting the parked Reviews-DB design, and adding a flag ahead of
  that decision would prejudge it.

## Not adopted — examined and left

**We are not migrating these**; the fill rates above are why.

| Prod field | What it is | Why not |
| ---------- | ---------- | ------- |
| `Size` | XL → XS | 3% used; the map's ticket count already signals size |
| `Cities` | 23-city multi-select | 1% |
| `Design Due Date` | date | 1% |
| `QA Checklist` | text | one row |
| `Sent to #data_product` | checkbox | one row, and `Data review` says the same thing with a verdict attached |
| `Venue Coordinator` | person | 3%, and ops-side staffing |
| `Target Release`, `Experiment` | relations | 6% / 12%, and both point at databases we don't have |
| `Results` | URL to the outcome | 6% — thin, but it names something our machine genuinely lacks: **nothing asks "did it work?" after `Rolled out`.** That's a workflow gap, not a column gap, and worth its own design pass rather than a field nobody fills |

## Two shape differences that will bite at takeover

- **The title column: adopted, singular.** In Notion, one column per database holds the
  page names themselves — the cell you click to open a row. Prod heads it `Features`; ours
  is now **`Feature`** (PO's call, 2026-08-11 — *one PRD = one feature*, which turns the
  no-"and"-bundles rule from style into structure: a page needing "and" is two features,
  so two PRDs). Only the plural differs at takeover, one rename.

  The tension I flagged and the PO overruled, recorded because the guard still has to
  exist: at *filing* the cell holds a **problem**, not a feature, per the lifecycle-naming
  rule. A header reading `Feature` invites a filing session to name a feature before
  anyone chose one — the failure triage exists to prevent. The reconciliation is written
  into the tracker doc's handle rules: the header names what the row is *becoming*, and
  filing still names the problem.
- **`Responsible Engineers` is plural here, `Responsible Engineer` singular there**, and
  prod's Figma column is **text** (`Figma Link`) where ours is a real `url` (`Figma`).

## Field-tested constraints the takeover run will hit

- Renaming a status option, and setting **any** option's colour, are **UI-only** acts —
  the API cannot do either (see `issue-tracker.md`'s install-time note). A takeover that
  needs prod's palette or labels changed is a human clicking, not a migration script.
- View filters on relation properties and on status-type properties cannot be set via the
  API either. Prod's existing views are therefore inherited as-is or rebuilt by hand.
