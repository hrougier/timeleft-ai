# product — vendoring lock

Provenance for every skill in this plugin. Maintained by `product:update`.

Doctrine: for every roster skill, upstream `mattpocock/skills` is checked for a
counterpart **first**. Where one exists its text is vendored **word-for-word** from the
pinned commit; every adaptation is a patch-only amendment in MP's voice, recorded as a
drift record below. Only a skill with no upstream counterpart may be net-new.

## Upstream pin

One pin for the whole vendored set. It matches the shared and tech plugins' pins (CI
asserts all three are equal).

| Upstream                             | Ref  | Pinned SHA                                 | Pinned on  |
| ------------------------------------ | ---- | ------------------------------------------ | ---------- |
| https://github.com/mattpocock/skills | main | `2ab958093e83e0ec752e6c1c5932da465bf23e0c` | 2026-08-06 |

## Skills

| Skill    | Origin                                | Verbatim / Adapted | Drift        |
| -------- | ------------------------------------- | ------------------ | ------------ |
| `triage-prd` | `skills/engineering/triage` @ pin     | Adapted (SKILL.md); siblings `AGENT-BRIEF.md`, `OUT-OF-SCOPE.md` verbatim | P1–P6 below + R2 |
| `draft-prd`  | none — no upstream counterpart (checked `skills/engineering/` and `skills/productivity/` at pin) | Net-new, written as if MP wrote it | n/a |
| `refine-prd` | `skills/engineering/wayfinder` @ pin  | Adapted (SKILL.md) | P1–P12 below + R2, R3 |
| `design-prd` | `skills/engineering/prototype` @ pin | Adapted (SKILL.md); siblings `LOGIC.md`, `UI.md` verbatim | P1–P4 below + R2 |
| `address-prd-feedback` | none — no upstream counterpart (checked both skill dirs at pin) | Net-new, written as if MP wrote it | n/a |
| `send-prd-to-dev` | none — no upstream counterpart (`code-review` reviews diffs, `to-spec` writes specs; neither is a document gate) | Net-new, written as if MP wrote it | n/a |
| `product-config` | none — not a skill, a delivery vehicle | Net-new (this plugin's bindings) | n/a — carries the three binding docs so they reach every surface; see the changelog entry of 2026-08-07 |
| `setup-product-ai` | none — counterpart checked and rejected: `skills/engineering/setup-matt-pocock-skills` *installs* MP's skills into a repo, where this one verifies that an already-installed plugin can reach its tracker, its code and its design tool from one person's session. Different act, no text to vendor | Net-new, written as if MP wrote it | n/a — carries the plugin's one deliberate voice exception (it must name connectors and screens, because a click has a name); see the changelog entry of 2026-08-12 |
| `ask-prd-ai`    | `skills/engineering/ask-matt` @ pin — **structure only** | Adapted (shape): ask-matt's flow-map structure (main flow / on-ramps / vocabulary underneath / precondition, reads served not routed), content necessarily local | see note below |

**`ask-prd-ai` drift note**: ask-matt's content *is* MP's roster — vendoring it verbatim would
route to eleven skills this plugin doesn't ship. The flow-map shape is adopted and made
**state-aware** (the main flow keyed on the PRD's status), following tos v2's #815
precedent ("ask-matt's flow-map made state-aware"). Word-for-word vendoring is
impossible for a router whose text is the flow itself; this row records that judgment
rather than claiming net-new (the counterpart exists) or verbatim (it can't be).
**Amended 2026-08-06**: the routing authority moved to the Phases DB's `Handled by`
column — the in-file map is that table narrated, and the database wins on
disagreement, guarded by roster-validation (an unresolvable cell is broken, never
obeyed). Changelog: "the route table moves into the machine".
**Amended again 2026-08-06**: ask gains the review overlay (the `Data review` /
`Tech review` court flags, routed at every product-side status), whose authority is
the Workflow Contract's Reviews section — the `Handled by` column routes the phase
axis only. Changelog: "reviews become court flags".
**Amended 2026-08-07**: `disable-model-invocation` removed and the description made
match-worthy — ask becomes triple-natured (user + model + hook-nudged), completing
the #815 shape: the binding hook and the voice hook both point sessions at it, so a
bare product prompt routes without the `/product:ask-prd-ai` prefix. ask-matt keeps the
flag upstream because it advises; ours dispatches and is dispatched to.
**Amended 2026-08-09**: the `In Design` row of the narrated map changed from a round-trip
back to `In Refinement` to a one-way flip that stays put — the machine's own change (see the
`design-prd` drift record and `issue-tracker.md`'s prototype-ticket bullets). The
`In Refinement, frontier empty` and `In Design` rows now route to the same two candidates
(`/refine-prd` checkpoint or `/send-prd-to-dev`), since a resolved prototype ticket always
leaves the PRD product-side complete. Changelog: "design becomes a one-way stop".

Excluded from the copy: `agents/openai.yaml` (Codex-specific metadata), per the tos v2
vendoring convention.

### Drift records — the descriptions (every vendored skill)

- **R2 — the `description:` line** (frontmatter, 2026-08-09). Upstream descriptions are
  written for an engineer reading an engineer's roster: `triage` offered "issues and
  external PRs", `wayfinder` "a shared map of decision tickets on your issue tracker",
  `prototype` "whether a state model or logic feels right". Every one of them shipped
  here unchanged.

  Two things were wrong with that. A description is what a **person** reads in the
  picker — the one place this plugin's own voice rules could not reach, since they govern
  what a session *says* and a description is written before any session exists. And a
  description is what the **model matches on**, which made `triage-prd`'s the more serious
  bug: it advertised external-PR triage that `issue-tracker.md` explicitly refuses ("not a
  request surface on this tracker"), so a PR request could route to a skill with nowhere
  to put it.

  All eight rewritten for the reader they actually have. Bodies untouched — this is the
  frontmatter only, and the three vendored ones (`triage-prd`, `refine-prd`, `design-prd`)
  are the ones this record covers; the rest were net-new or locally written and simply
  copied upstream's vocabulary out of mimicry.

### Drift records — the voice block (every vendored skill)

- **R3 — the "How you sound" preamble** (body, first block after the title or the opening
  paragraph; `triage-prd` P6, `refine-prd` P11, `design-prd` P3). Recorded 2026-08-12,
  retroactively: the block had been shipping in all three vendored bodies with no drift
  record at all, which is the one thing the vendoring doctrine forbids — an unaudited
  amendment to MP's text.

  What it is: six lines naming the reader (a product manager, addressed as "you"), pointing
  at the `product-config` skill's Voice section, and carrying that section's floor inline.
  Why it is in the body rather than left to the config skill: hooks do not run on claude.ai
  or the Desktop Chat tab, and a vendored skill can be invoked cold by the model, so a skill
  whose first act is talking to a PO has to carry its register itself. Additive in every
  case — no upstream sentence is altered, and the block sits above MP's first instruction so
  his structure reads unchanged beneath it.

  Verified against the pin the same day: the diff of each vendored `SKILL.md` against
  upstream is exactly the patches listed here and nothing else.

### Drift records — the rename (every vendored skill)

- **R1 — the `name:` line** (frontmatter, line 2 of each `SKILL.md`). Every skill in this
  plugin was renamed on 2026-08-09 so that no name collides with the tech roster's:
  claude.ai's chat surface shows no `product:` prefix, and ten of eleven names were
  shared with skills that do different things — tech's `prototype` writes throwaway
  code, product's makes a design artifact, and `/prototype` chose between them silently.
  Acts on a PRD took a `-prd` suffix, the rest a `product-` qualifier.

  **Scope.** The rename is not frontmatter-only. R1 also rewrites every **call site** of a renamed skill inside the vendored bodies
  (`/triage` → `/triage-prd` in triage's §Invocation, `/prototype` → `/design-prd` and
  `/domain-modeling` → `/glossary-and-decisions` in wayfinder's Ticket Types), which is
  correct — a body naming a skill this plugin does not ship would route nowhere. What was
  not correct is that the same sweep hit two strings that are **not** skill names, in two
  files this lock declares verbatim: `UI.md`'s throwaway app route `/prototype/<name>`
  (a path in the prototyped codebase, renamed to `/design-prd/<name>` — a route named
  after a skill, which is nonsense in a product repo) and `AGENT-BRIEF.md`'s
  brief-writing example. **Both reverted to upstream on 2026-08-12**, so the verbatim
  claim on those two siblings is true again. R1's rule from here: rename a call site,
  never a path or an example.

  Renaming *this* plugin rather than tech's was deliberate: tech vendors the same MP
  skills, so leaving its names alone keeps its own drift at zero on this axis.

  **Resolved 2026-08-09** — `research-prd` and `grill-prd` have left this plugin for
  `shared`, where they are named `research` and `grilling`. R1 was written to keep that move
  cheap ("the only thing to undo should be R1"), and it was: `grilling` went back to fully
  verbatim, rename and drift both gone. `research` needed one patch, recorded as C1 in
  the shared plugin's lock, because it was the one of the two that named a destination.
  **`glossary-and-decisions` followed on the same day**, keeping its renamed name at the
  PO's call — so that one rename outlives R1 and is now recorded in the shared plugin's
  lock instead.

### Drift records — `triage-prd`

- **P1 — provenance comment** (line 7). An HTML comment naming the upstream path, pin,
  and this drift list. Invisible to render; keeps the file self-identifying.
- **P2 — role-mapping pointer** (§Roles, last sentence of the canonical-names
  paragraph). Upstream: "run `/setup-matt-pocock-skills` if not." Here the binding
  ships in-plugin — product has exactly one tracker — so the sentence points at
  `issue-tracker.md` instead. Authorized by CLAUDE.md (setup wires IDs; binding is
  in-plugin).
- **P3 — unfiled-request filing paragraph** (§Invocation, appended). Product requests
  arrive unfiled ("we want to work on X" in a session), so the paragraph adds the
  file-first act — a `needs-triage` issue carrying the problem statement and nothing
  else — and the problem-not-solution discipline, naming `/draft-prd` as the owner of
  solutions one state later. Mirrors tos v2's unfiled-report amendment to the same
  skill (#812). Authorized by CLAUDE.md (roster: triage creates Backlog PRDs with
  problem statement only). **Amended 2026-08-06** after the first dry run filed a PRD
  before any human saw its name: filing now goes behind the tracker doc's
  confirmation line ("no write without a yes") — the original patch front-ran MP's
  own Recommend-then-wait discipline.
- **P4 — Fold outcome** (§Apply the outcome, one bullet). A third disposition found in
  the first dry run: a live issue covers the area and the request adds a real
  nuance — comment the nuance onto it, file nothing. Upstream has no counterpart
  bullet; recorded in changelog.md (2026-08-06, `product:triage-prd`).
- **P5 — `disable-model-invocation` removed** (frontmatter, 2026-08-06). Upstream
  ships the flag because MP's router advises; this plugin's `/ask-prd-ai` dispatches, and
  the harness blocks the Skill tool on flagged skills (proven in a dry run). The
  flag's job is superseded by the stronger write-layer gate — no write without a
  yes. Changelog: "the router may dispatch".
- **P6 — the voice preamble** (body, after `# Triage`). See R3 above; recorded
  2026-08-12 after the pre-push audit found it undocumented.

### Drift records — `refine-prd`

Vendored from MP's wayfinder; the diff against the fetched upstream file shows exactly
these patches and nothing else.

- **P1 — provenance comment** (line 7). Same shape as triage's.
- **P2 — frontmatter `name: refine`.** The roster names the skill for what it does to
  the PRD; the description stays MP's, verbatim.
- **P3 — tracker pointer** (§The Map). Upstream: "run `/setup-matt-pocock-skills` if
  not … If no tracker has been provided, default to the local-markdown tracker." Here
  the binding ships in-plugin and there is exactly one tracker, so the sentence points
  at `issue-tracker.md` and the fallback clause is dropped. Same rationale as triage P2.
- **P4 — chart-entry paragraph** (§Chart the map, after the mode line). The loose idea
  arrives as a drafted issue (`/triage-prd` → `/draft-prd` shaped it); charting maps onto that
  issue and flips it to `In Refinement` under the tracker doc's status rules. Authorized by
  CLAUDE.md (roster: refine charts the map, flips to In Refinement). Amended 2026-08-06 when
  the machine adopted the prod board's labels (changelog: status-machine rework).
- **P5 — Ticket budget section** (after §Ticket Types). 3 research · 3 grilling ·
  1 prototype, fold by theme, overflow to fog. Supersedes one-ticket-one-decision for
  grilling tickets: a themed session resolves a folded set, and the resolution comment
  records each decision individually. Authorized by CLAUDE.md (ticket budget per PRD).
  **Amended 2026-08-06** (adversarial-review finding): an already-sharp inbound-note
  decision never parks in fog — fold it into the nearest theme even imperfectly; the
  fog fallback's "not sharp enough" rationale is false for that input class.
- **P6 — Checkpoint mode** (§Invocation, third mode). Mid-road re-evaluation of the
  map — fold-back verification, hole-surfacing, fog graduation, out-of-scope ruling —
  gated behind substance; a plain "what's next" is a frontier read. Mirrors tos v2's
  checkpoint amendment to the same skill (#810/#812). Map QA only: document QA belongs
  to `/send-prd-to-dev` (the refine-vs-review boundary in the workflow design).
- **P7 — `disable-model-invocation` removed** (frontmatter, 2026-08-06). Same
  rationale as triage P5: the dispatching router needs Skill-tool access; the
  no-write-without-a-yes gate carries the safety the flag provided.
- **P8 — research findings lose the git branch** (§Chart the map, step 5, 2026-08-09).
  Upstream fires research subagents "capturing its findings on a throwaway
  `research/<name>` branch with a context pointer from the ticket" — a git destination, in
  the skill a product manager runs. It survived this long because the tracker doc
  overrides where findings land, and refining always has the tracker doc loaded; the text
  itself was still instructing a session to make branches. Replaced by a pointer: findings
  land where the tracker doc says, and the subagent is handed that binding rather than
  choosing. Same defect and same repair as `shared`'s C1, found by review on the extraction
  diff — the third destination this week that was correct only by the accident of what the
  caller had already read.

- **P9 — the settled test** (§Fog of war, after the fog-or-ticket bullets; one paragraph
  appended to §Ticket budget, which is already ours via P5). Upstream's only gate on
  ticket creation is sharpness — "whether you can state the question precisely now" —
  which admits questions whose answer is obvious the moment the options are stated. On
  MP's maps that costs little: the dev charting is the one who will answer. Here charting
  is agent-led and budgeted, and the budget read as a quota — a full session was spent on
  "Is one check at T-2h enough for small tables?", a ticket whose entire transcript was
  one recommendation and two "ok"s. Additive patch, the fog test stands: a sharp question
  is put to the human in one line with a recommended answer, their reaction sorts it — a
  nod folds the answer into the destination (never into Decisions so far, which indexes
  closed tickets; outliving decisions go to the decision record), a hesitation is the
  ticket. The budget becomes a ceiling, not a quota. PO-directed 2026-08-10, including
  the ask-don't-classify mechanism. Candidate for tos v2's refine when it lands.

- **P10 — the lookup sort** (§Fog of war, one line immediately above P9). P9 sorts by the
  human's reaction, and that is exactly why it mis-sorts a *factual* question: "is the photo
  already stored full-size?" has no side to take and no owner in the room, so a product
  manager's honest "I don't know" is indistinguishable from the hesitation P9 treats as a
  ticket. The rule we added on 2026-08-10 was therefore manufacturing the code-research
  tickets the PO reported on 2026-08-12 — and, worse, the grilling tickets filed beside them
  were unsharp because their answers waited on those facts. One line upstream of P9: a
  current-behaviour fact is established by the session itself, per the tracker doc's
  creating-a-ticket act, before anything is put to the human. The mechanics — delegated
  reads, product-language findings, the three carve-outs (a survey, a data question, no code
  route) and the proportionality limit — stay in the binding, so this patch adds a sort and
  no procedure. PO-directed 2026-08-12, after the binding-only version was judged to
  intercept too late: the write-layer rule catches the ticket, but only after the PO has
  been asked something they cannot know.

- **P12 — the three literals the binding overrides** (§The Map first line; §Chart the map
  step 3; §Work through the map step 4). Upstream names concrete tracker forms — the map is
  its own issue labelled `wayfinder:map`, and a resolution is a *comment* on a *closed*
  issue plus an index line appended to Decisions-so-far. On this tracker all four are
  wrong: the PRD **is** the map (the phase plays the label's part), the resolution goes in
  the ticket **body**, `Resolved` is the state, and the index is a view that is never
  appended to. The tracker doc has said so since the resolve act was rebound on
  2026-08-07, and §The Map already points at it — but a session reading these sentences
  cold follows them, and two of the writes they describe are exactly the two the binding
  forbids. Patch defers rather than restates: each line now says the tracker doc differs
  and wins, without moving the mechanics into skill text. Same defect and repair as P8,
  `design-prd`'s P2 and `shared`'s C1 — correct only when the caller had already loaded
  the binding. Found by the pre-push review, 2026-08-12.

- **P11 — the voice preamble** (body, after the two opening paragraphs). See R3 above;
  recorded 2026-08-12 after the pre-push audit found it undocumented.

### Drift records — `design-prd`

- **P1 — design-artifact branch** (§Pick a branch, third bullet). Upstream knows two
  prototype forms, both code. Product prototypes are usually design artifacts (Figma
  file or generated design output) reacted to without a codebase at hand, and the
  ticket's folded review prompts are answered against the artifact — per the ticket
  budget's one-prototype rule (refine P5). Capture overridden in `issue-tracker.md`
  (Artifact property + resolution comment, In Refinement ⇄ In Design round-trip).
  **Amended 2026-08-07**: the medium/ritual/capture binding moved to its own doc,
  `design-tool.md` (third binding surface after issue-tracker and code-repository);
  the patch now points there.
  Authorized by CLAUDE.md (roster: prototype resolver; workflow design: Figma or
  Claude design output). **Amended 2026-08-06** after the konami dry run: MP's
  "throwaway from day one" mis-carried onto the design branch — on this tracker the
  *takes* are throwaway, the *chosen* design is durable (attached to the PRD, part of
  the tech handoff). The patch and the capture override now say so.
  **Amended 2026-08-09**, PO-directed: the round-trip (`In Design` ⇄ `In Refinement` on
  claim/resolve) becomes a one-way flip (`In Design` stays put on resolve), and the
  prototype ticket gains a hard ordering rule — it is always blocked by every research
  and grilling ticket on the same PRD, so it is always the map's last ticket. Reasoning:
  since the prototype ticket can now never be anything but the last one resolved,
  resolving it already means the PRD is product-side complete — bouncing back to
  `In Refinement` just to re-check an already-empty frontier added a step with nothing left to
  do at it. `In Design` is now the map's terminal pre-handoff status, same rank as an
  empty-frontier `In Refinement`. Mechanism lives in `issue-tracker.md` (the prototype-ticket
  bullets, the `Creating a ticket` blocking clause) and `design-tool.md` (the resolve-act
  package); the skill's `description:` line updated to carry the new lifecycle (same
  R2 rules); authorized by CLAUDE.md's status-machine line. Changelog: "design becomes a
  one-way stop".
  **Amended 2026-08-09 (second)**: `design-tool.md`'s two-media table replaced by a
  Claude-design-default rule — Figma only when the human names it or the deliverable
  must live in Figma. PO-directed, from the Ops Notifications dry run (the "artifact is
  the handoff" row routed a session to Figma; the PO redirected it). Changelog: "Claude
  design is the default medium".

- **P2 — the binding pointer** (before "A prototype is throwaway code…", plus one clause
  appended to rule 6, 2026-08-12). Upstream's prototype skill moves nothing and lives in a
  repo; ours moves the PRD and often has no repo at all. The skill said neither: it named
  `design-tool.md` for the medium and stopped, so a cold invocation — which its own
  `description:` invites — designed happily without claiming the ticket, without the phase
  flip, and with rule 6 still telling a product manager to commit to a throwaway branch.
  Every other state-affecting skill in this plugin already carried the pointer; this one
  was correct only when refining had loaded the binding first. Two sentences: load
  `issue-tracker.md` and the Workflow Contract before anything (stop if the contract is
  unreachable), and where there is no repo the capture is the tracker doc's, not git's.
  Same defect and same repair as refine's P8 and `shared`'s C1.

- **P3 — the voice preamble** (body, after `# Prototype`). See R3 above; recorded
  2026-08-12 after the pre-push audit found it undocumented.
- **P4 — provenance comment** (line 6, added 2026-08-12). Same shape as triage's P1 and
  refine's P1. This file was the one adapted vendored skill shipping with no in-file
  attribution — an inconsistency, not a decision: the audit that found R3 found this too.

No in-file provenance comments on verbatim skills — the files stay byte-identical to
upstream; this lock is the attribution.
