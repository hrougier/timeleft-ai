# Issue tracker

This plugin's issue tracker is **Notion**. An *issue* is a page in the PRDs database;
its labels are the `Phase` property; comments are Notion page comments. The product
team has exactly one tracker, so this binding ships in-plugin (maintained by
`product:setup-product-ai`) rather than per-repo.

Every address below points at **Product Roadmap Board v2** — the product team's own board,
in their space, where the whole team reads it. Every row on it is real work.

So treat every page under it as live: no throwaway edits, no test rows, nothing you would not
want a colleague to open tomorrow. And **you are not the only writer** — humans work here
directly, so a page may have moved since you read it (the `Rev` rule below is how you notice,
and re-reading before you write is how you avoid overwriting someone).

**The production Product Roadmap Board is read-only reference.** Three addresses name
the same forbidden thing — match any of them:

| What                | Address                                                     |
| ------------------- | ----------------------------------------------------------- |
| Its page            | `https://app.notion.com/p/1ae8d7bb13a280678922d53836ac3af3` |
| Its board database  | `https://app.notion.com/p/1ae8d7bb13a2802c96b7d7e9e923ccd6` |
| That board's rows   | `collection://1ae8d7bb-13a2-80e9-8796-000b1171092b`         |

No skill writes to it, comments on it, or creates pages under it. Taking it over is a
separate, gated effort. If a session's context makes the prod board look like the right
target, that session is wrong: stop and say so.

**Read-only means it is reference, never a source.** You may read it to check whether
something already exists. You may not take content, decisions or answers from it. A decision
recorded there was made by other people, under rules this contract does not govern, with no
record on our side of who agreed to it — copying it in launders someone else's call into our
document and answers an open question nobody here closed.

**And a PRD there with the same subject as ours is a collision, not prior art to fold.** Two
live documents for one feature is a duplication of effort, and which board owns that feature
is a human's decision, never a session's. So: name both pages, say plainly that the same
feature is being specified twice, and **stop** — do not merge, do not "pull in what's settled",
do not treat the other document as ahead of or behind this one. Resolving it may well mean
this PRD should not exist; that is exactly the kind of call to hand back.

## Addresses

| What              | Address                                                     |
| ----------------- | ----------------------------------------------------------- |
| The board (v2)    | `https://app.notion.com/p/3ba8d7bb13a281f0a5d1daa5096ddcc4` |
| Workflow Contract | `https://app.notion.com/p/3ba8d7bb13a2816ba610f8cdc5d8e3d0` |

| Database | Data source URL                                     |
| -------- | --------------------------------------------------- |
| PRDs     | `collection://2c5b7096-8ff2-4dea-b069-348744dfa04d` |
| Tickets  | `collection://dbc38ac2-910f-4690-9c56-fe9829fc944f` |
| Glossary | `collection://48e29cba-935a-4c1c-85f9-13cc5866b406` |
| Phases   | `collection://c6baba7a-40e7-49d9-a63d-317e1cb326a2` |

## Tools

**Reaching the board without this binding is the failure mode, not a shortcut.** The Notion
tools are sitting right there in every session, and reading a PRD feels like it needs nothing
— which is exactly how a session ends up talking phases and revs at a product manager, or
treating the production board as a source. Everything that governs this tracker lives in
skills a session has to choose to open: on claude.ai no hook nudges you, so the choice is the
only safeguard there is. If you are about to query, read or write anything on this board and
have not loaded `product:ask-prd-ai`, that is the first act, not an optional one.

Notion access is the claude.ai Notion connector (`mcp__claude_ai_Notion__*`). The tools
may be deferred — load them with a **single** `ToolSearch` call listing every tool the
operation needs, before the first Notion call.

**A shareable page link is `https://app.notion.com/p/<id>` — with the `/p/`.** Without it
the link opens Notion's *"This page couldn't be found — you may not have access, or it
might have been deleted or moved"*, which reads to whoever clicked as *deleted* or *not
allowed*, never as a formatting slip. So the cost is not one bad click; it is doubt about
whether the write landed at all.

**The two response shapes disagree, and only one is safe to paste.** `notion-fetch`
returns the `/p/` form. **A SQL query's `url` column, and every relation column, return
the bare `https://app.notion.com/<id>` form — the dead one.** Copying a link straight out
of a query result is therefore the normal way to produce a broken link while believing you
followed the rule. Normalise before you show it: if a URL from a query has no `/p/`
segment, insert one.

Page bodies are Notion-flavored Markdown: read `notion-fetch id: notion://docs/enhanced-markdown-spec` before composing
one — never guess the syntax.

## Role mapping

The canonical triage role names map to this tracker as follows:

| Canonical role    | Here                                                                       |
| ----------------- | -------------------------------------------------------------------------- |
| `bug` / `enhancement` | Not represented — PRDs have no category axis. Every request here is enhancement-shaped. A request that is actually a **bug report** (something built is broken) files nothing here: say so and hand it to the tech team's tracker — that redirect is the triage outcome. |
| `needs-triage`    | `Phase = Problem`                                                             |
| `needs-info`      | `Phase = Problem` + an open comment thread holding the triage notes           |
| `ready-for-agent` | `Phase = Problem` + an agent brief comment. The agent next in line is `/draft-prd`, which flips the issue to `Draft` when its first pass is written. |
| `ready-for-human` | `Phase = Problem` + a brief noting why it can't be delegated                  |
| `wontfix`         | `Phase = Rejected`                                                         |

`On Hold` maps to no triage role: it is the **siding** — a strategic pause decided by
the PO and set by hand, never by a plugin. Skills may *propose* parking; the human
flips. It is not `needs-info` (that's normal triage traffic — a pending question, days
not months). No skill acts on an `On Hold` issue until the PO resumes it.

External pull requests are **not** a request surface on this tracker.

## Phase writes

1. **Load the Workflow Contract page first. If it is unreachable, stop** — say so and
   do nothing else. No skill guesses a transition.
2. The **Phases** database is the canonical machine. This plugin may set exactly the
   phases whose `Set by` reads `product plugin`. If anything in this repo disagrees
   with that database, the database wins.
3. **A product-side phase flip spends every review verdict** — the verdict covered
   the document at its phase, and the flip changes what the document is. Clearing
   both flags rides the same shown write as the flip, one package. (Re-request
   whenever the reviewer's eyes are wanted on the new phase.)

   **One flip is exempt: the handoff to `Ready for development`.** Every other flip
   changes what the document is; that one changes only whose court it sits in, and the
   content it hands over is exactly the content the verdicts covered. Clearing there
   would also make the gate self-defeating — its data check *requires* a live
   `Data review: Approved`, so a flip that wiped the flag would destroy the approval it
   had just demanded and hand tech a PRD with no record one ever existed. So the handoff
   carries the verdicts across untouched, and the gate's pass comment names the rev each
   was stamped at, so the evidence survives even if a later write spends them.
4. `On Hold` is `Set by: human (PO)` — **no plugin ever sets it or clears it.** A skill
   that believes an effort should pause says so and stops; the flip is the PO's, by
   hand, with a comment naming why and the phase to resume to.
5. A PRD whose `Phase` matches no **live** row of the Phases database (rows marked
   RETIRED don't count) is mis-set — stop and flag it; never route or transition from
   a phase the machine no longer has.
6. After any write, re-fetch the page and confirm the phase landed and the body
   renders. A write you didn't verify is a write you didn't make.

## No write without a yes

Canonical on the **Workflow Contract page** — it binds both plugins. Operationally
here: every tracker write (file, flip, comment, section edit) is shown before it
lands — word for word wherever the words matter; an issue's `Feature` always matters —
then the contract's one line, **"Okay for you — or what would you change?"**, and a yes lands the
write exactly as shown. Routing counts too: the router names the **act** it is about to
take and what that act starts with — never the skill or command performing it — behind
the same line. Reads never carry the line.

## When a skill says…

Recipes for your hands, not your mouth: nothing below is vocabulary for talking to
the human — this skill's own Voice section governs how you speak, and it is the
authority whether or not a session-start block reached you (on claude.ai and the
Desktop Chat tab, none does). You run these; you never recite them.

- **"file an issue" / "the tracker doc's filing act"** — create one page in the PRDs
  data source:

  ```
  notion-create-pages
    parent: { type: "data_source_id", data_source_id: "<PRDs>" }
    pages: [{ properties: { "Feature": …, "Phase": …, "Owner": [<user id>] }, … }]
  ```

  `notion-fetch` the data source first and use the schema it returns — the property
  names here are today's; the fetched schema is canonical.

  **A property you can see is not a property you may fill.** The PRDs data source
  carries planning columns the PO owns and no skill writes: `Squad`, `Priority`,
  `Quarter`, `Responsible Engineers`, `Rollout type`, `Ops`. They exist so the board can
  be sliced the way the
  production board is sliced, and every value in them is a human's decision about
  staffing and sequencing — a plausible guess is worse than an empty cell, because an
  empty cell reads as "not decided yet" and a guess reads as decided. Leave them alone
  on filing, and on every later write.

  Two of them are **read** even though they are never written. `Rollout type` changes what
  the document owes before handoff: `A/B Experiment` means the success metric and the
  variants belong in the document, `Gradual Market Rollout` means the market order does —
  the gate checks for that content, and an empty `Rollout type` asks for neither. `Ops` at
  `Involved` or `Led` means the Ops team is part of delivering this, so the handoff has a
  third audience; say so in the handoff rather than assuming tech will notice. `Created At` and `Last Edited At` are Notion's
  own and cannot be set at all. `Tech issue` is a third read-only-to-us column: the tech
  plugin back-fills it when it accepts the PRD, so this plugin reads the link and never
  writes it. Skills write only what the acts below name: `Feature`, `Phase`, `Owner`,
  `Rev`, the two review flags, `Figma`, and the relations. If the PO asks for one of the planning columns to be set, that is a page
  update like any other — shown, confirmed, then made.

  **`Feature` is a handle, not a summary**: a short phrase — aim for ≤ 8 words — naming the area and the stake,
  legible on a board card and sayable in a standup. Never a solution, and never the
  problem's full sentence either (that's the Problem section's opening line). No
  "and"-bundles: when one page carries two asks, name what they share. *"Member photo
  removal & review"*, not *"Support can't remove a member's profile photo on request,
  and moderators can't see it full-size"*; *"Hosts can't tell who cancelled"* is fine —
  short grievances make good handles, long ones make summaries.

  **`Feature` follows the lifecycle, and the column header is a promise, not a
  description**: one PRD is one feature — which is what makes the no-"and" rule structural
  rather than stylistic, since a page needing "and" is two features and therefore two
  PRDs. But the cell does not hold a feature on day one. **At filing it names the
  *problem*** — a solution-name at that point is a decision smuggled past `/draft-prd` and
  `/refine-prd`, and it blinds triage's dedup (pains recur under many solutions). Once a
  solution exists, `/draft-prd`'s package **may rename the PRD to the solution's handle**
  (same rules: ≤ 8 words, board-legible) — the PO's call, shown for the same yes; the
  problem phrasing keeps its permanent home as the Problem section's opening line. So the
  header says what the row is *becoming*; never let it pull a filing session into naming
  a feature nobody has chosen yet.

  **The template is the only body source.** Create with the `template_id` the data
  source reports (the "PRD" default template — it carries every section and the
  Map's two linked views), then fill the `👷‍♀️ Problem Statement` with
  `notion-update-page` / `update_content`. If the data source reports **no
  template**, stop and say the template needs installing — never improvise a body;
  there is no fallback skeleton. Fill the Problem Statement (Context, Problem,
  Hypothesis) **only**; every other section keeps its placeholder, because an
  eagerly-filled section looks decided — headings, emoji, and placeholder lines all
  carry meaning to later skills. Never vendor a copy of the anatomy into this repo:
  Notion owns it. `Owner` is a person property (array of Notion user IDs) —
  resolve the requester with `notion-get-users`, and if they don't resolve, omit the
  property and say you did. Set `Rev` to 1 — filing is the first content write. Leave
  `Figma`, `Tech issue`, `Tickets`, and both review flags empty — they belong to
  later stations.

- **"apply a label" / "close as `wontfix`"** — set the `Phase` property per the role
  mapping, under the [Phase writes](#phase-writes) rules. Closing as `wontfix` means
  `Phase = Rejected` — the page stays forever (see `.out-of-scope/` below).

- **"post a comment" / "triage notes"** — `notion-create-comment` on the page. **Every
  comment this plugin posts opens with the AI line**, its own first line: triage keeps
  its vendored wording ("generated by AI during triage"); everything else uses
  `> *This was generated by AI.*` Same brevity bar as the reply act below — say what
  the reader can't see for themselves, and stop.

- **"post an agent brief comment" (AGENT-BRIEF.md)** — on this tracker the durable
  brief **is the PRD page**: the Problem Statement section plus triage's findings
  comment; the agent next in line (`/draft-prd`) reads the page, not a comment thread.
  AGENT-BRIEF.md's *principles* bind that writing — durable over precise, behavioral
  not procedural (needs, never screens or code), testable criteria, explicit
  out-of-scope — but its template and examples are upstream reference written for a
  code tracker: never reproduce the code-shaped fields (`Key interfaces`,
  `Category: bug`). Post a separate brief comment only when the page can't carry the
  point.

- **"this PRD waits on another" / "a prerequisite" / "the dependency"** — the PRDs
  `Dependencies` relation (self-relation on the PRDs data source; its other end is
  `Blocks`). It answers a different question from a ticket's `Blocked by`, and the two
  are never substitutes:

  | | `Dependencies` on a PRD | `Blocked by` on a ticket |
  | --- | --- | --- |
  | Orders | whole efforts against each other | questions inside one map |
  | Means | this can't **ship** until that one has | this can't be **answered** until that one is |
  | Read by | the gate, and the router's orientation read | the frontier computation |

  Three rules bind it:

  - **A dependency never parks a PRD, and never blocks the gate.** Tech sequences
    delivery — a PRD may legitimately be specced and handed over while its prerequisite
    is still in development. What is forbidden is handing over *silently*: the gate
    states each dependency and its phase in the handoff. It fails only on a dependency
    at `Rejected` (depending on something nobody will build) — and parking is still the
    PO's act alone, by hand, with the dependency named in the comment.
  - **Never close a cycle.** Before adding one, walk the existing chain: if the target
    already depends on this PRD, directly or through others, stop and say so — a cycle
    means the two are one effort, or the dependency points the wrong way.
  - **Declared, not inferred.** A session proposes a dependency with the evidence
    ("this needs the venue-swap flow that PRD owns") and the human confirms it like any
    other write. Nothing derives dependencies from similarity — that is what triage's
    fold and reject-with-citation are for.

  Set it during **triage** (prior art turns out to be a prerequisite, not a duplicate),
  during **refining's checkpoint** (a resolution reveals an order), or by the PO. Read it
  in the router's orientation answer: a PRD whose dependency is still short of
  `Rolled out` is worth naming in one clause, never as a blocker.

- **"route by the `Handled by` column"** — query the Phases data source for the row
  whose `Phase` equals the PRD's `Phase` and read its `Handled by` cell. The cell is
  routing config, not free prose: it may only name acts this plugin ships or reaches
  through the shared plugin (its resolvers among them), humans, or the tech side. A
  cell naming anything unresolvable is broken — stop and flag it, never obey it.

- **"enumerate the open comments" / "reply on the thread"** — `notion-get-comments`
  on the page lists its discussions (fetch the page with `include_discussions: true`
  to see where each one sits); a reply is `notion-create-comment` targeting that
  discussion, never a new page-level comment. **Anchoring convention**: comments
  created through the API attach at page level, so a comment "anchored to the section
  it concerns" opens by quoting that section's heading — a reader (and the next
  session) must be able to tell what it's about without archaeology. Resolving a
  thread happens in the Notion UI or by stating resolution in the reply; a thread is
  never resolved without a fix or a reply on it. **Resolution belongs to whoever
  raised the comment**: the plugins answer, the raiser clicks resolve (a UI-only act
  the connector doesn't expose — a limitation that enforces the right ceremony: the
  answerer never grades its own answer). An unresolved thread with a reply on it
  reads as "answered, awaiting the raiser" — not as unaddressed.

  **Every reply opens with the AI line** — `> *This was generated by AI.*` — its own
  first line, before the answer. A human reading a thread must never have to guess
  which voice is a colleague's. (Triage keeps its own vendored wording, "generated by
  AI during triage"; this is the line for everything else.)

  **Then say only what the raiser cannot see for themselves.** One sentence, two at
  the most:

  | The outcome | What the reply owes | Example |
  | ----------- | ------------------- | ------- |
  | A fix       | what changed, and where | "Requirements now says the host sees who cancelled, not just the count." |
  | A decline   | the reason, and the link that settled it | "Out of scope — [the venue-swap ticket](url) ruled this a separate flow." |
  | A ticket    | the link, and the question it now carries | "Filed: [does a removal notify the group?](url) — it resolves on the map before the handoff." |

  Nothing else earns space. No greeting, no thanks, no restating their comment back at
  them, no account of how the answer was reached, no summary of the rest of the walk.
  Length is not politeness: a reader scanning eleven threads pays for every word twice,
  once reading and once deciding it was filler. **If the answer needs a third sentence,
  it belongs in the document** — write it there and let the reply point at it.

- **"update the issue body" / "the section-writing act"** — `notion-update-page` with
  `update_content`: search-and-replace against the section being filled, the smallest
  edit region that captures the change. Fill only the sections the skill names; every
  other section keeps its placeholder text untouched. Never `replace_content` a whole
  PRD — concurrent sessions edit other sections. **Every approved content write bumps
  the `Rev` property by one — read-increment at write time**: re-fetch the page's
  current `Rev` immediately before landing and write current+1, never the value
  computed when the work was planned (concurrent sessions race; two writes stamping
  the same rev breaks every review stamp pointing at it). If that pre-write read
  shows the page moved since you loaded it — rev differs, sections changed — re-read
  what you're about to edit, land against the current state, and say the page moved. **If the write materially changes
  content a review verdict covered, it spends that verdict: clear the flag to empty
  in the same shown write** ("this spends the Tech review approval from rev N —
  clearing it"). Clearing is not verdicting — this plugin still never sets `Approved`
  or `Changes requested`.

- **"request a review" / "the review flags"** — set `Data review` and/or
  `Tech review` to `Requested` (a property write: shown behind the confirmation line
  like any other), and post a comment stamping the revision: *"Data review requested —
  rev N."* Both flags may be requested at once; that's the point. **Verdicts are
  never this plugin's to set** — the data lead (human) and the tech plugin own their
  own flags. When walking review comments, read the request's rev stamp: a comment
  from rev N walked at rev N+k is answered with what changed in that section since,
  never dismissed as stale. A **re-request** after a `Changes requested` walk lists
  the points addressed, one line each — the next round's walk reads that list to
  recognize a re-raised point (the same-point-twice rule's memory). It rides the
  **same confirmation as the walk's fixes** — one package, one line; it is never a
  follow-up ask of its own.

- **"query the issue tracker"** — query the **data source**, never a view (views
  filter; `Rejected` rows are exactly what triage exists to find):

  ```sql
  SELECT url, "Feature", "Phase", createdTime
  FROM "collection://<PRDs>" ORDER BY createdTime DESC
  ```

  While the corpus is small, read the whole list. Once it outgrows one screen, narrow
  with the request's **nouns**, one query per noun, keeping `Phase` in the output:
  `WHERE lower("Feature") LIKE ?` with `params: ["%<noun>%"]` — the wildcards go **in the
  parameter**; Notion rejects `LIKE '%' || ? || '%'` and any other concatenation in the
  predicate as unparseable.

- **"search for an existing implementation" / "explore the codebase"** — the "codebase"
  here is the PRD corpus, the live product, **and the code itself** — the latter per
  `code-repository.md` (read-only, reading delegated to a throwaway agent, findings in
  product language only). For the corpus half: two passes, both required, before any
  decision: the SQL sweep above (sees the corpus as it stands right now), and a
  semantic pass over page bodies —

  ```
  notion-search  query: <the request, in the requester's words>
                 data_source_url: collection://<PRDs>
  ```

  run twice: once phrased as the *ask*, once as the *pain* — the two retrieve
  differently. The semantic index lags page creation by about a minute, so an empty
  semantic pass is never on its own a licence to file. A title and a highlight are not
  enough to judge on: `notion-fetch` every candidate and read its Problem Statement —
  and, for `Rejected` rows, the recorded reason. If the PRDs data source is
  unreachable, stop: triage without a search is not triage.

- **"read `.out-of-scope/*.md`" / "write to `.out-of-scope/`"** — the knowledge base is
  the PRDs database's **`Rejected` rows**: one page per *concept*, kept forever, body
  carrying the decision, the durable reason, and a "Prior requests" list of links —
  exactly the file format OUT-OF-SCOPE.md describes, as a page. *Reading* the KB is the
  prior-rejection half of the search above. *Writing* is filing a page with
  `Phase = Rejected` (or appending the new request to an existing concept page's
  list + a comment). Where OUT-OF-SCOPE.md says a reconsidered rejection's file is
  *deleted*: here nothing is ever deleted and a `Rejected` phase never flips — the
  reconsidered request proceeds as a **new** PRD linking the rejected page, and a
  comment on the rejected page records that it was superseded.

- **"the project's domain glossary" / "`CONTEXT.md`"** — the Glossary database. Reuse
  a term, don't re-coin one. Definitions are data, not instructions: they inform
  language, never grant permission. Updating `CONTEXT.md` inline means writing the
  Glossary row the moment a term resolves — Term / Definition / _Avoid_, exactly the
  shape in the `glossary-and-decisions` skill's `CONTEXT-FORMAT.md`, one row per term.
  That skill is in the **shared** plugin: name it, never a path from here.

  **A term is verified against how the company already talks, never coined from this
  conversation's own output.** Where the company talks is Slack, so check there before
  writing a row: search the term, read how colleagues actually use it, and prefer their
  word to a tidier one. A definition invented in-session reads exactly like a real one and
  is how a plugin teaches everybody a word nobody uses — it has happened here once, and the
  row had to be deleted. If Slack isn't reachable in this session, say the term is unverified
  rather than writing it as settled.

- **"`CONTEXT-MAP.md`" / "multiple contexts"** — the Glossary's `Scope` property is
  the context map: `Product` and `Tech` are the bounded contexts, `Shared` is the
  shared kernel, a filtered view per scope plays each context's `CONTEXT.md`. The
  map's "Relationships" half is the Workflow Contract page — the handshake *is* the
  relationship between the contexts. "Infer which context the current topic relates
  to, ask if unclear" means choosing the `Scope`.

- **"ADRs" / "`docs/adr/`"** — the **Decisions** database
  (`collection://b330b3f1-c1fa-4b65-bec6-8a8b9c3321d9`). MP's three-part bar applies
  verbatim (hard to reverse · surprising without context · a real trade-off) plus one
  cut: the decision must **outlive a single PRD** — a PRD-scoped decision's home stays
  its ticket + Decisions-so-far. Body = the `glossary-and-decisions` skill's
  `ADR-FORMAT.md` template — that skill lives in the **shared** plugin, so reach it by
  naming the skill, never by a path from here (1–3 sentences:
  context, decision, why); `Scope` as in the Glossary; "scan for the highest number" —
  the `ID` property auto-increments (`ADR-n`); "superseded by ADR-NNNN" — the
  `Superseded by` relation plus `Status = superseded`; nothing is ever deleted.
  **Set the `PRD` relation when the decision was born from one** — the PRD template's
  "Decisions from this PRD" view reads it; a decision with no origin (a standing
  constraint, a cross-team ruling) leaves it empty. A
  decision that constrains a specific spot in code gets a **code comment at that spot
  pointing at the decision's URL** — the guard travels with the code, the narrative
  lives here.

- **"the failures file"** — `~/.claude/product/failures.jsonl` (user-level, never
  versioned): one JSONL line per failed or human-reworked run — skill, surface, what
  failed, one-phrase why. Written by skill prose, no machinery.

## Wayfinding operations

For `product:refine-prd` and the ticket resolvers (`design-prd`, plus the shared plugin's `research` and `grilling`):

- **A research ticket is answered here first, against primary sources — the code among
  them.** See this skill's `code-repository.md`: "does the system already know X today?"
  is a read before it is a referral. Parking it on another team *without looking* turns a
  lookup this session could do into a wait on people who have not been asked.

  Handing it on is legitimate once looking has failed, or when the answer was never in
  the code — an intention, a priority, a promise someone made. Then the ticket says **what
  was already checked and what is actually being asked**, so nobody repeats the search and
  the recipient gets a question rather than a topic. "Not visible in the code; the tech
  team needs to say whether X is knowable before groups exist" is a ticket. "Ask the tech
  team about X" is a shrug.

- **The map** is the PRD page itself — the 🗺️ callout headed **`Refinement`**, holding
  **`Not yet specified`** (the fog) and **`Tickets & decisions`** (the embedded Tickets
  views). Those three strings are the live template's, verified 2026-08-09; match the
  page, never this file, if they ever disagree. There is no separate map issue, and no
  `wayfinder:map` label to apply — the `In Refinement` phase plays that role.

  **"Map" is the vendored skill's word for the concept, not a word on the page and not a
  word for the PO.** The section is called Refinement because a PO reads it; say "the
  open questions on your PRD", never "the map".
- **The tickets view comes from the database template, never from a session.** The
  PRDs database template carries a linked Tickets view pre-filtered "PRD contains
  *this template page*" — Notion resolves self-referential template filters per
  created page, so every PRD born from the template has its own filtered map view
  with zero per-PRD operations. Field-tested and closed: **relation filters AND
  status-type property filters cannot be set via the API** — every syntax silently
  drops or lands broken (select filters compile; Tickets' `Status` was filterable
  before its conversion to status-type; a detour through the `Open` formula also
  fails). So no skill ever creates or edits a view on a PRD — filing uses the
  template (`template_id`), and a PRD missing its views means the template needs
  installing (a one-time human act; the anatomy and instructions live on the
  template itself, linked from the Workflow Contract), not a view-creation act. One
  exception: the human may order a **one-off view repair** on a pre-template PRD —
  the session creates the views behind the line and ends by naming **every click
  the API can't make**: each view's `PRD → contains → this page`, and any
  status-type filter (e.g. Unresolved tickets' *Status is not Resolved/Dropped*,
  Decisions so far's *Status is Resolved or Dropped*). Ordered repairs only; never
  spontaneous.
- **Option colours are install-time, human-only.** Field-tested 2026-08-11 on a
  throwaway database: the API cannot recolour an option that already exists — for a
  status property `ALTER COLUMN … SET STATUS(…)` does not even parse (the DDL takes no
  options for that type), and for a select it fails outright with *"Cannot update color
  of select with name: …"*. Colours can only be chosen at creation. Same for **renaming
  a status option** (`Idea`→`Problem`, `In PRD`→`In Refinement` were both UI acts).
  So a session may propose a palette and must hand over the clicks; it never promises
  to apply one. Never attempt a bare `SET STATUS` on a live board to force it — that
  would redefine the option set the rows depend on.
- **The prototype ticket is always blocked by every other ticket on its map, and its flip
  is one-way**: it can only reach the frontier once every research and grilling ticket on
  the same PRD is Resolved or Dropped — it is the map's last ticket by construction.
  Claiming it flips the PRD to `In Design`; resolving it leaves the PRD there. `In Design`
  never flips back to `In Refinement` — because the prototype ticket is always last, resolving it
  means the PRD is already product-side complete, the same way an empty frontier at
  `In Refinement` would be. `product:send-prd-to-dev` picks it up from `In Design` exactly as it
  would from an empty-frontier `In Refinement`. That makes `/design-prd` a
  state-affecting skill — the Phase writes rules above bind it like any other flip.
- **The map body maps onto the PRD**: the **Destination** is fixed by the workflow —
  *this PRD, product-side complete, `Ready for development`* — so it isn't written per effort;
  **Notes** ride the top of the Map section when an effort needs them; **Not yet
  specified** is a Map subsection (prose, fog only); **Decisions so far** is the
  Map's embedded resolved-tickets view (Name / `Resolution` / `Resolved by` /
  `Resolved on` — the template carries it, filtered `Status = Resolved`), never a
  maintained prose list; **Out of scope** is the PRD's existing `Out of scope`
  subsection under ✅ Requirements.
- **"capturing findings on a throwaway `research/<name>` branch"** — there is no repo
  to branch here. A research ticket's findings are posted on the **ticket page
  itself** (the body — a `## Findings` or `## Resolution` section), with external material linked from the
  `Artifact` property. Notion owns the nouns; nothing lands in git.
- **"commit the prototype to a throwaway branch … context pointer on the issue"** —
  same override, with one inversion: on this tracker the **chosen design is durable**.
  Candidate takes are the throwaway part; the one the human picks is linked from the
  ticket's `Artifact` property **and from the PRD's `Figma` property** — it is part of
  the tech handoff, not a probe to discard. The verdict, the question it settled, and
  the review prompts' answers land in the ticket body's `## Resolution` section. Claiming
  flips the PRD `In Refinement` → `In Design`; resolving leaves it there, as declared above.
- **Tickets** are rows in the Tickets database: `Type` (research / grilling /
  prototype / task), `PRD` relation to their map, `Status` Open / Resolved / Dropped
  (Dropped = ruled out of scope, never deleted).
- **Creating a ticket** — one page in the Tickets data source: `Title`, `Type`,
  `Status = Open`, `PRD` relation set; `Assignee` empty (unclaimed), `Blocked by`
  wired in a second pass — **a `prototype` ticket's `Blocked by` always includes every
  `research` and `grilling` ticket open on the same PRD**, wired in that same pass
  regardless of creation order, so the design question is always the last thing resolved
  on a map. If a research or grilling ticket is added later to a PRD that already carries
  an open prototype ticket (an `/address-prd-feedback` outcome, a checkpoint's new
  ticket), wire it into that prototype ticket's `Blocked by` too — the invariant holds for
  the life of the map, not just at charting time; **icon set by type** — 🔎 research · 🔥 grilling · 🎨
  prototype · 🛠️ task. Set once, at creation, and never changed again: the icon is the
  ticket's type for life, and no later act rewrites it. **A decision ticket's `Title` is the question it resolves,
  asked plainly — question mark included.** This is the fog-or-ticket test enforced:
  a name that won't phrase as a question isn't sharp enough to be a ticket yet —
  park it in Not yet specified instead.

  **Before that, ask who the question is addressed to: does it need deciding, or looking
  up?** A question whose answer is a fact about what the product does today — is the
  photo already stored full-size, does rejection notify anyone, can a host see the
  cancelling guest — needs nobody's judgment. It needs eyes on the code, and it is
  **answered during charting, never filed**: read it now through the code binding (see the
  `code-repository` doc — delegated, one question at a time, findings in product language)
  and carry the answer into the map. Only then is it clear whether an open question
  remains.

  This matters most for the questions you *don't* file. A grilling ticket written before
  its facts are in is unsharp by construction — it asks something whose answer depends on
  what the code already does, so the session that claims it spends its first half doing
  the lookup that should have happened here. **Establish the fact, then write the
  question**: half of them sharpen, and some dissolve because the product already behaves
  the way the question was about to propose.

  Three cases where the ticket is right after all, and they are the reason this is a sort
  rather than a ban: the answer needs a **survey** rather than a lookup (across surfaces,
  or "where does this appear today" asked broadly — that is real research, and its title
  is still a product question); the answer lives in **data, not code** (how often, how
  many); or **this surface has no code route**, in which case say that plainly and file it
  rather than guessing. And keep it bounded: a couple of lookups belong in charting, ten
  are a survey — file that one instead of turning the conversation into an audit. Keep it short (a handle, like PRD names);
  the full framing lives in the body's `## Question`. With the `Resolution` column,
  the decisions view then reads as question-and-answer pairs. `task` tickets are the
  one exemption — they do rather than decide, so they name the work, imperative
  ("Get us a test account on the partner API"). `/address-prd-feedback`'s Ticket outcome files exactly this,
  unwired — the checkpoint wires it later.
- **Claim** — set `Assignee` before any work, to **the human driving the session** (the
  same person who will land in `Resolved by`). The assignee *is* the claim; an open,
  unassigned ticket is unclaimed, and the Frontier view will keep offering it to whoever
  looks next.

  **A delegated resolver cannot claim for itself.** The resolving skills are
  tracker-agnostic — they know nothing about this database, by design — and a background
  agent has no identity here to be assigned. So **the session that delegates claims
  first, then fires.** This matters most where it is easiest to skip: firing several
  research tickets in parallel, where every unclaimed one stays on the frontier while an
  agent is already working it. Claim all of them, then fire all of them.
- **Blocking** — the `Blocked by` / `Blocks` self-relation. `Open` → `Open blockers` →
  `Blocked` render it in Notion's own UI; the **Frontier** view (unassigned + not Blocked)
  is the edge of the known.

  **The three definitions, written down because nothing else holds them.** They live only in
  the Notion UI — no session can read a formula's expression through the API (`formulaCode://`
  is not fetchable), so if that database is ever lost or forked they are unrecoverable from
  anywhere but here:

  | Property | Kind | Definition |
  | -------- | ---- | ---------- |
  | `Open` | formula | `prop("Status") == "Open"` |
  | `Open blockers` | rollup | relation `Blocked by` · target property `Open` · calculate **Show original** |
  | `Blocked` | formula | `prop("Open blockers")` |

  Read them and the earlier field note stops being a mystery: *Show original* returns the
  **list** of blockers' `Open` values rather than an aggregate, so `Blocked` is a list —
  `true, false` — not a boolean. That is why a checkbox-style filter on it silently does
  nothing, why the Frontier view under-filters, and why the frontier is computed in SQL
  below. These three are **the human-facing rendering** of a fact the plugin works out for
  itself; nothing a skill does depends on them.

  **Compute the frontier yourself, in SQL. Do not depend on the Frontier view.** One
  query returns everything needed; resolve the blocking in memory:

  ```sql
  SELECT url, "Title", "Type", "Status", "Assignee", "Blocked by", "PRD"
  FROM "collection://dbc38ac2-910f-4690-9c56-fe9829fc944f" WHERE "Title" IS NOT NULL
  ```

  A ticket is on the frontier when `Status = Open`, `Assignee` is empty, and **every** id
  in its `Blocked by` resolves — in the same result set — to `Resolved` or `Dropped`. A
  blocker you did not resolve is a blocker you assumed away. `Blocked` and `Open` are
  formulas the data source reports as **not available to SQL**, so they cannot help and
  are not needed: `Blocked by` plus `Status` is the same fact, one join away, and it is
  the only form of it you can actually read.

  **Why not the view.** Verified 2026-08-09 against 17 tickets: the view's own `Blocked`
  condition does nothing — its tab lists **7**, which is exactly open-and-unassigned,
  including two tickets whose blockers are open. The correct answer is **5**, and the
  query above produces it. Separately, the same view queried through `mode: "view"`
  returned 5 once and then 0 on three later calls with unchanged data. So the view is
  unreliable in both directions: wrong in the UI, empty through the API. Treat it as a
  human's tab that needs repairing, never as an authority — and if a session's SQL answer
  disagrees with what someone sees on that tab, the query is right and the tab is the
  thing to fix.

  **If a view ever becomes the authority again, it must be re-verified first** — with a
  count, against a hand-resolved SQL answer, on more than one call. This one passed a
  single run and was recorded as verified; three later runs disagreed with it.

- **Budget per PRD: 3 research · 3 grilling · 1 prototype.** Fold by theme, never cut;
  overflow goes to the PRD's Not-yet-specified section.
- **Picking a ticket up — read its comments first.** Fetch the ticket **with discussions
  included** (`notion-fetch` returns none by default, so a plain read silently hides
  them). A comment on a ticket is not commentary, it is a constraint the human added
  after the ticket was written: *"there is a legacy endpoint, never used, ignore it"*
  changes what a correct answer looks like, and a resolver that never saw it will confidently
  return the wrong one. **Inline-anchored comments bind to the line they sit on** — treat
  one as an amendment to that bullet, not to the ticket as a whole. Say in your findings
  how each comment was honoured, and **never resolve the thread**: only whoever raised it
  clicks resolve.

- **Resolve** — one package on the ticket and the PRD: append a **`## Resolution`**
  section to the ticket's **body** (the *why*, in full — the body, never a page
  comment: the body takes inline anchored comments so people can discuss the
  decision, keeps version history, and renders as real blocks; a comment is a
  dead-end bubble. This is also MP's own exemplar format — "append `## Resolution`").
  Write the one-line gist into the ticket's **`Resolution`** property, set
  **`Resolved by`** (the human who drove the session) and **`Resolved on`** (today);
  set `Status = Resolved`. **Leave the icon alone** — it carries the ticket's *type* for
  the whole of its life, resolved included. `Status` already says where a ticket stands,
  and overwriting the icon buys a second copy of that at the price of the only thing the
  board shows at a glance: what kind of question this was. A resolved map full of ✅ reads
  as identical rows. Same for Dropped. Fold the *what* into the PRD section it affects (**via
  the section-writing act — the `Rev` bump included**). The PRD is never stale by
  construction. **No prose index line** — "Decisions so far" *is* the PRD's embedded
  resolved-tickets view, reading these properties; nothing is appended to the PRD
  body for the index. A resolution that amends an earlier decision names what it
  amends in its own `Resolution` line — the amended ticket's line is never edited.
- **Drop (out of scope)** — the same three properties as a resolve, different verdict:
  `Status = Dropped`, `Resolution` = the one-line why-it's-out (linking what
  ruled it out), `Resolved by`, `Resolved on`. **The icon stays as it was here too** —
  same rule as a resolve, for the same reason. The decisions view surfaces Dropped
  rows — an empty gist there is a hole. The scope boundary also lands as one line in
  the PRD's **Out of scope** subsection (under ✅ Requirements): it belongs to the
  document, not only to the ticket table.
- **Prototype assets** — linked from the ticket's `Artifact` property; the ticket page
  body carries the brief and the review prompts.
