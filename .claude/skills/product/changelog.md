# product — changelog

Append-only. One dated section per change decision (what changed, and why).
Never rewrite or reorder past entries. Maintained by `product:update`.

## 2026-08-12 — the board becomes Product Roadmap Board v2, and the plugin says so

*Team Plugins HQ* was the name of a build effort. The board is about to sit beside the
production **Product Roadmap Board** where the whole product team reads it, so it is now
**Product Roadmap Board v2** — the name a PO landing next to that board will understand
without being told what a plugin is.

Its opening lines were rewritten for the same reader: what the board is *for*, that the
plugin never moves a PRD without showing the change first, and one paragraph placing v2 beside
the board they already use (same workflow, refinement made explicit, nothing replaced yet).
Two stale facts went with it — the `Statuses` database has been `Phases` since yesterday, and
the "PRD skeleton" was retired when the template replaced it.

**The move itself is a human act, and the reason is a new API wall.** `move_pages` returns 404
on the destination: the connector can *read* that parent page — it was fetched to find the
right target — but cannot write to it, so a page cannot be moved *into* a subtree the
integration only reads. Recorded rather than worked around; a human drags it in three clicks.

The bindings now describe the board as it will be read, not as it was built. `issue-tracker.md`
loses the last of the rig framing and gains the fact that matters more than any of it:
**you are not the only writer.** Humans work directly on this board, so a page may have moved
since you read it, and re-reading before writing is how you avoid overwriting a colleague —
which is a different discipline from the `Rev` counter, and the one a shared board actually
needs. `setup-product-ai` now names the board by its exact title in the not-shared case, since
asking a colleague to "share the roadmap board" beside the production board gets the wrong one.

Version 0.26.0 — the tracker's identity changed, and that is what every skill loads first.

## 2026-08-12 — Figma is offered, and the connector list gets tiers

Yesterday's line said Figma was *"not checked and not needed"*, which is true of the workflow
and unhelpful to a person. The PO's correction: offer it, so it is there for whoever already
works in Figma even though the workflow prefers Claude design.

So it becomes the one connector whose answer is a **preference rather than a state**. The
default medium doesn't move — design questions go to Claude design unless a human names Figma
or the deliverable has to live there, exactly as `design-tool.md` has it — but setup now asks
the useful question once: if Figma is part of how you already work, connecting it now means
the design skill can reach it the day you ask, instead of stopping mid-session to set up a
connector. If not, nothing to do and nothing lost. Its absence is never reported as a gap,
and never allowed to read as a second thing to fix while a real blocker is open.

That forced the connector list into **three tiers**, which is the better shape anyway:
**needed** (`Notion`, the org's `GitHub MCP`), **advised** (`claude-design`, `Slack` — each
absence costs one specific thing and the plugin says so rather than failing), **offered**
(`Figma`). All five are named with their status even when they pass, because a connector you
didn't mention is one a PO assumes you never checked — and the step sorts by what it costs
them: blockers, then what degrades, then the preference. Version 0.25.2.

## 2026-08-12 — the two GitHub connectors are independent, in both directions (field-tested)

The PO connected the org's **GitHub MCP** and checked: claude.ai's official **GitHub
Integration** stayed disconnected. So the warning setup has carried since it was written is
now verified rather than asserted, and the converse is recorded with it — having
`GitHub Integration` connected does nothing for the code route either.

Worth the words because both wrong readings are natural. *"GitHub is connected, so the code
should work"* — that is the wrong row, and it is the one already connected for most people.
And *"I connected the plugin's one, so why does the other still say disconnected"* — nothing
is broken; they are unrelated and it can stay that way. Setup now says which row it means
**and** that the other one does not matter, because a PO who fixes the right thing and still
sees a red badge next to the word GitHub will not believe the report.

This also closes the open question from the last round — whether connecting one would light up
the other automatically. It doesn't. Nothing in the checks needed changing as a result: they
test whether GitHub *tools are in hand*, never which row supplied them, which is why the
answer either way was survivable. Version 0.25.1.

## 2026-08-12 — the click path is exact, connectors are one visit, and Slack is advised

Three trial findings, and the first is the one that matters most: **the install path was
wrong enough to strand someone.** Setup said *"Settings → Customize → Plugins, install
Shared Toolkit — Browse lists what the catalogue offers, Add is for when the catalogue isn't
there"*, which describes the screen without walking it. The real path, from the PO doing it:

> **Settings → Customize → Plugins → Browse → Your organization**, search, then the **+**
> button beside the plugin.

Two sub-lessons written in with it. Search **a distinctive word** — *shared*, *product* —
not a full name, because what the catalogue shows can differ from what a plugin calls itself
and an empty search reads as "we don't have it". And an empty **Your organization** means the
plugins were never published to that person: somebody else's errand, said plainly, not a
click they can make.

**Connectors are now one visit.** The order is fixed too, and the reason is worth keeping:
plugins first, because a plugin arrives with its own connectors declared and installing it
changes what that screen offers — checking connectors first means reporting gaps that install
themselves. Then all four in a single step with their status, even the passing ones: `Notion`
and the org's `GitHub MCP` as what the workflow needs, `claude-design` and `Slack` as what
make it good. A person sent to the same settings page three times reasonably concludes the
tool doesn't know what it wants.

**Slack joins as strongly advised**, and it got teeth rather than a recommendation: the
glossary act in the binding now says a term is verified against **how the company already
talks**, never coined from the session's own output — search Slack, prefer the colleagues'
word, and where Slack is unreachable write the term as *unverified* rather than settled. That
is this repo's own scar (a term was invented in-session once and had to be deleted), promoted
from a builder's habit into the plugin's rule. Without it, "connect Slack" would have been
advice no skill acted on.

Also: **Figma is explicitly not checked**, with one line saying so, because silence made a PO
with Figma connected assume the plugin used it. And the handover sentence must now sit
*immediately* after the step — the failing transcript put three lines of "things that are
already fine" between the instruction and the gate. Version 0.25.0.

## 2026-08-12 — the code check has one route, not two (PO-directed)

Yesterday's fix made the two routes asymmetric — a `gh` pass is never a pass for the
connector. The PO went further and they're right: **for a PO there is only the GitHub MCP
connector, so setup should not mention any other route at all.** Naming a second one invites
a session to try it, and every sentence about which route counts more is a sentence that
should not need to exist here.

So the code check now says the connector is the whole check, and adds the rule that survives
the deletion: whatever else this session might happen to have — another way in, a route that
works for whoever is driving — **is not evidence about the connector and is never reported as
a pass.** The check runs for someone with no shell, so the connector answers for itself or it
doesn't.

The failure cases collapse accordingly: no connector tools in this session (connect it —
**GitHub MCP**, the row badged *Custom*, not Claude's own `GitHub Integration`), not in the
list at all (published to them by someone else — a different errand), all three repositories
404 (the App isn't installed on them), one 404 (that one was missed).

Note for the record, since it nearly cost the section: the first pass at this edit **deleted
the connect path along with the shell text** — the connectors screen, the two-connectors
warning, the passkey-in-1Password guidance — because the cut ran to the wrong boundary. Read
back before committing, every time; a deletion is a change like any other, and this one would
have left a check that finds a gap and cannot say what to do about it.

`code-repository.md` keeps both routes, deliberately: a resolver grounding a claim should use
whatever it has, and in Claude Code that is often the command line. Setup is the only place
where the *person's* route is the point. Version 0.24.4.

## 2026-08-12 — the shared-plugin check lied (third trial-run finding)

Worst of the three: the trial reported *"the shared plugin's already in — researching,
grilling, and the glossary are all reachable right now"* to a PO who had never installed it.
A false pass in the one skill whose entire job is telling you what is actually reachable.

The cause is a trap we built ourselves. The check said *"the honest test is your own skill
list"*, which is right — but it looked for `research`, `grilling` and the glossary, and **two
of those three names are Matt Pocock's**, vendored verbatim. Anyone with his marketplace
added, or any other plugin that vendored them, has skills called exactly that. And the
globally-unique naming rule doesn't help here: it made our names unique *among our plugins*,
while claude.ai's chat surface shows **no plugin prefix at all** — which is why that rule
exists — so a bare `research` in the list is a name with no provenance whatsoever.

The fix is to probe the one name only we could have shipped: **`glossary-and-decisions`**.
It is our coinage; nothing upstream or elsewhere ships it. Seeing all three, including that
one, is presence. Seeing only the two generic ones is **absence** — stated explicitly,
because that is precisely the reading the failing run got backwards. And where the list is
ambiguous, ask what the plugins screen shows rather than deciding from a name.

Recorded as the same trap already handled one section down, where two connectors are both
called GitHub and only one is ours: **a name that looks right is not the thing.** The
generic-name hazard is now a known cost of vendoring MP's names into a shared plugin —
cheap to live with, as long as nothing tests identity by them. Version 0.24.3.

## 2026-08-12 — setup walks, it doesn't survey (second trial-run finding)

The trial's second report was accurate and unusable. Four findings in one message: the
blocker, then two things needing no action, then the good news, then — last — the single
sentence the person could act on. The PO's read: it mixes multiple things and never says
what the steps are.

The rule that produced it was **"One message. Lead with the verdict, then only what needs
doing"** — reasonable for a report, wrong for a procedure. Setup is not a status page; it is
someone standing next to you while you connect things. So the shape now depends on whether
anything needs doing, because a person with something to click and a person with nothing to
click need opposite messages:

- **Nothing to do** → one message, as before. Verdict, what's reachable, what to do first.
- **Something to do** → **announce the route, then walk the first step alone.** How many
  things need connecting and in what order, three or four words each — then step one only,
  with the click and whose it is, ending on "tell me when it's done and I'll re-check".
  Step two gets explained when they reach it, because by then they may have seen something
  that changes it.

And the rule that would have caught the failing example on its own: **nothing that needs no
action may sit between the human and their next click.** A working surface, an unfixable
limitation, a passed check — after the live step, one line each, or at the end. In the
transcript those took three paragraphs and pushed the only actionable sentence to the
bottom.

Kept: separating *your* errands from someone else's, since a vault invitation and an
organisation approval strand different people; and no tables of ticks, no "4 of 5 passed" —
a count is not a finding. Version 0.24.2.

## 2026-08-12 — a `gh` pass is not a pass (first trial-run finding)

The first install trial: `setup-product-ai` reached for the `gh` command line to check the
code route. The PO's objection is right and sharper than it first looks — **POs have no
shell; they have the org's custom GitHub MCP connector, and nothing else.**

The skill's text was not obviously wrong: it named both routes and said *"either is a pass —
check both before reporting a gap"*, which is exactly the rule `code-repository.md` sets for
**reading** code, and correct there. It is wrong in a *setup* skill, because setup's whole
job is to verify what the human in front of you can reach. Either-route makes the check
pass on the builder's laptop, where a shell and an authenticated `gh` are sitting right
there, while the connector a PO depends on is untested — the most misleading result this
skill can produce, since it hands someone a green light for a route they do not have.

So the rule is now asymmetric where it matters: two routes exist, they are **not
interchangeable here**, and **a `gh` pass is never a pass for the connector**. Where both
exist the connector is the one whose failure counts; where only the shell exists, say
plainly that the route works for this session and is unverified for anyone on claude.ai —
and check the connector anyway. A new failure bullet covers exactly that case.

Untouched on purpose: `code-repository.md`'s either-route rule for reads. A resolver
grounding a claim should use whatever route it has, and the first one that answers is the
right one. The two docs now differ deliberately — reading wants any route, verifying wants
*the* route. Version 0.24.1.

## 2026-08-12 — the repo's home is `timeleft-dev/timeleft-ai`, and it is private

The open question this changelog recorded on 2026-08-08 — *public by decision, revisited when
the repo moves to `timeleft-dev`* — is closed by the move. Private: under the org there is no
distribution reason to be public, because the access bundle and `/plugin marketplace add` both
read a private repo the members can already see, and the board's database IDs stop being
world-readable as a side effect rather than as a fix.

The rule that never depended on visibility still holds and is now stated where it cannot be
missed: **no credential, token or secret in this repo, ever**, whoever can read it. The
GitHub App's client ID and secret live in 1Password for that reason, not because the repo
happened to be public.

Five live references were still sending people to `hrougier/timeleft-ai` — the README's and
`plugin-loading.md`'s install commands, CLAUDE.md's registration line and its remote doctrine,
and `github-access.md`'s push step. All repointed. The two mentions inside older changelog
entries stay as they are: they record what was true when written, which is the point of an
append-only record.

No version bump — nothing in any plugin's behaviour changed, only where the repo lives and
what it says about itself.

## 2026-08-12 — the pre-push review, second pass: the provenance layer, and a gate that ate its own approval

A second read before the push, this one diffing every vendored skill against the pin and
every property name against the live schemas. The machinery came back clean — dependencies,
auto-discovered hooks, `.mcp.json`, the plugin-root variables, all three database schemas
match the binding exactly. Everything found was in the provenance layer, plus three
contradictions between a skill and its binding.

**The rename sweep had touched two files that lock.md declares verbatim.** `design-prd`'s
`UI.md` had an app route renamed — upstream's throwaway `/prototype/<name>` became
`/design-prd/<name>`, so a session following it would build a route in the product codebase
named after a skill — and `triage-prd`'s `AGENT-BRIEF.md` had a brief-writing *example*
swept. Both reverted and verified byte-identical to upstream again. R1's scope claim ("body
text is untouched in every case") was false and is corrected, with the rule that makes it
safe: **rename a call site, never a path or an example.**

**The voice preamble had no drift record at all** — inserted into the body of three vendored
skills, which is the one thing the vendoring doctrine forbids. The block stays (hooks don't
run on claude.ai, so a cold-invoked skill must carry its own register) but it is now recorded
as R3 with a per-skill patch number. Two provenance comments also claimed stale patch counts
— "P1–P4" where lock.md records five, "P1–P6" where it records ten.

**And the gate was eating the approval it had just demanded.** Phase-writes rule 3 spends
every verdict on every product-side flip; check 6 requires a live `Data review: Approved` to
pass. So passing the gate cleared the flag, and tech received the PRD with no record an
approval ever existed. The fix names the principle rather than special-casing the symptom:
**every other flip changes what the document is; the handoff changes only whose court it sits
in**, and the content it hands over is exactly what the verdicts covered. So the handoff is
the one exempt flip, the verdicts ride across untouched, and the gate's pass comment names the
rev each was stamped at so the evidence survives any later write. Changed in three places
because the Contract page is canonical for it: the page, the binding's rule 3, and the gate's
pass exit.

**Three of MP's concrete literals now defer to the binding** (P12): the map as its own issue
labelled `wayfinder:map`, and a resolution as a comment on a closed issue plus an appended
index line. On this tracker the PRD *is* the map, the resolution goes in the ticket body,
`Resolved` is the state, and the index is a view nothing appends to. The binding has said so
since 2026-08-07 and §The Map already points at it — but a session reading those sentences
cold follows them, and two of the writes they describe are exactly the two the binding
forbids. The patch defers rather than restates, so the mechanics stay in one place. Version
0.24.0.

## 2026-08-12 — the pre-push provenance audit: two swept strings and one unrecorded patch

Every vendored `SKILL.md` and sibling diffed against the pin before the first push. Six
files are byte-identical to upstream as claimed. Three findings in the rest, all in the
provenance layer rather than the behavior layer — which is exactly where an unaudited
change is most expensive, because the lock is the only thing that makes the doctrine
checkable.

**The voice preamble was shipping unrecorded in all three vendored bodies.** The "How you
sound" block is in `triage-prd`, `refine-prd` and `design-prd`, and no drift record
mentioned it — while R1 and R2 both asserted the bodies were untouched. Now **R3**, with
`P6` / `P11` / `P3` pointing at it. The block stays: hooks do not run on claude.ai or the
Desktop Chat tab and the model can invoke a vendored skill cold, so a skill that talks to a
PO has to carry its register in its own text. Recording it is the fix, not removing it.

**R1's rename swept two strings that are not skill names, in two files declared verbatim.**
`UI.md`'s throwaway app route `/prototype/<name>` had become `/design-prd/<name>` — a route
in the *prototyped codebase*, renamed after a skill, which is nonsense to anyone building
it — and `AGENT-BRIEF.md`'s brief-writing example had taken the suffix too. Both reverted;
both siblings are verbatim again. R1's scope is corrected in place to say what it actually
does (rename a **call site**, never a path or an example) rather than the false "one line of
frontmatter per skill".

**Smaller, same class**: the in-file provenance comments undercounted (triage said P1–P4
with five recorded, refine said P1–P6 with ten), and `design-prd` was the one adapted
vendored skill with no provenance comment at all — added as `P4`. And the tracker doc listed
`Tech issue` among the properties skills write, two paragraphs after telling them to leave it
empty and against the column's own description: it is the tech plugin's back-fill, so it is
now named as read-only-to-us alongside `Created At` / `Last Edited At`.

Skill behavior is unchanged apart from the two reverted strings. Version 0.23.2.

## 2026-08-12 — the lookup sort moves upstream of the question (P10)

The binding-only version above intercepts at the **write**: the filing act catches a code
lookup before it becomes a ticket. Correct, and one beat too late — by then the session has
already asked a product manager whether the photo is stored full-size, which is a question
they cannot be expected to answer and shouldn't be handed. PO-directed: patch it at the
source instead.

One line in `refine-prd`, immediately **above** P9, recorded as drift **P10**: a question
whose answer is a current-behaviour fact has no side to take and nobody in the room to ask,
so the session establishes it first and sorts only what survives.

Placing it above P9 is the whole point. P9 sorts by the human's reaction — that is what
makes it mis-handle factual questions, because an honest "I don't know" is indistinguishable
from the hesitation it treats as a ticket. So the rule we added on 2026-08-10 was
manufacturing exactly the tickets reported today. P10 runs before it and never lets a
factual question reach that sort.

The patch adds a sort and no procedure: the mechanics stay in the binding — delegated reads,
product-language findings, the three carve-outs, the proportionality limit — so the skill
text grows by one line and MP's structure is untouched. Version 0.23.1.

## 2026-08-12 — a fact is not a question: charting looks it up instead of filing it

The PO's finding: charting keeps producing research tickets that are really *go and look at
the code* errands, and the second-order cost is worse than the wasted session — the grilling
tickets filed alongside them are **unsharp by construction**, because their answers depend on
a fact nobody has established yet.

The diagnosis is uncomfortable and worth stating plainly: **P9, the rule we added on the 10th,
is what generates these tickets.** It sorts a sharp question by putting it to the human with a
recommended answer — a nod settles it, a hesitation becomes a ticket. But "is the photo already
stored full-size?" is not a question a product manager is supposed to be able to answer. Their
honest *"I don't know, go look"* is indistinguishable from a hesitation, so the rule files a
ticket. We built a filter that routes factual questions into tickets by construction.

So the missing sort is neither sharpness (MP's test) nor the human's reaction (P9's), but **who
the question is addressed to: does it need deciding, or looking up?** A current-behaviour fact
needs nobody's judgment — it needs eyes on the code, and it is answered *during charting*
through the code binding, delegated, one question at a time, the answer in product language.
Only with the fact in hand is it clear whether an open question remains.

The payoff the PO named is the real one: **establish the fact, then write the question.** Half
of them sharpen, and some dissolve, because the product already behaves the way the question
was about to propose. A grilling ticket that waits on a lookup makes the session that claims it
spend its first half doing that lookup.

Three carve-outs keep this a sort rather than a ban — the answer needs a **survey** rather than
a lookup (real research, and its title is still a product question), the answer lives in
**data rather than code**, or **this surface has no code route**, which is said plainly and
filed rather than guessed. Bounded, too: a couple of lookups is charting; ten is an audit
wearing charting's clothes, so file the survey instead.

**Zero skill-text changes** — no tenth patch on MP's wayfinder. The sort lives in the
creating-a-ticket act, which every filer already reads before it writes, so it binds
`refine-prd`'s charting and checkpoint, and `address-prd-feedback`'s Ticket outcome, identically.
`code-repository.md` gains charting as its fourth consumer with the proportionality and register
rules. If dry runs still show sessions asking a PO unanswerable factual questions, the follow-up
is a one-line patch upstream of P9 — but the write-layer intercept should catch it first, and
it is the cheaper place. Version 0.23.0 — charting's ticket bar changed again.

## 2026-08-12 — the pre-push review: four contradictions the roster could act on

A read of the whole repo before pushing it, looking for places where two files tell a
session different things. Four, all of them actionable by a session rather than merely
untidy:

- **`design-prd` never loaded its binding.** The one state-affecting resolver had no
  pointer at `issue-tracker.md` or the Workflow Contract, and MP's rule 6 was still
  intact underneath: invoked cold — which its own description invites, since a design
  question is a thing a PO says out loud — it would design, commit nothing anywhere the
  tracker can see, try to make a git branch, and leave the PRD's phase untouched. It
  worked only because refining usually enters first and carries the binding. Recorded as
  the skill's P2 drift.
- **Dropping a ticket rewrote its icon.** The resolve act says the icon is the ticket's
  type for life, and says "same for Dropped" — then the Drop act two bullets down set it
  to ⛔. The 0.10.2 decision fixed three places and missed the fourth, so a dropped ticket
  still lost the only thing the board showed at a glance.
- **The binding hook could suppress itself.** The once-per-session marker was written
  before the tracker doc was resolved, so a run that found nothing to inject still spent
  the session's one injection. Docs resolved first now.
- **Two stale references.** `hooks.json` named "How a session speaks" in
  `issue-tracker.md` as the voice's canonical home — that section was deleted when the
  voice moved to the config skill — and `design-tool.md` handed the human `/design-login`,
  a command the plugin forbids surfacing and the claude.ai surface does not have.

Repo-level docs corrected in the same pass, since they are what the next builder session
reads: README still described the handshake as `Ready for tech` / `Ready for product`
(retired labels) and promised an `update` skill that does not exist; CLAUDE.md's roster
line still said `In PRD`, still described the Frontier view as queried by view mode (the
opposite of what was field-tested), and gave a `gh api --ref` command its own next line
says cannot work. Version 0.22.2.

## 2026-08-12 — three skills were still pointing at a skill that no longer exists

`refine-prd`, `triage-prd` and `design-prd` each told a session to load the **`config`** skill.
It was renamed `product-config` in the globally-unique naming pass on 2026-08-09, and these
three references were missed — the tracker doc and the router were updated, these weren't.

Worth more than a typo fix, because of *how* it fails: a session told to load `config` finds
nothing, and the binding is where every address, every status rule and the voice section live.
The failure isn't a broken link, it's a session acting on the tracker without its binding — the
one thing the config skill exists to prevent. Nothing in a dry run would have surfaced it
unless that skill happened to be the entry point, since the router loads the binding correctly
and passes it down in context.

Found by sweeping every skill name against the directories on disk rather than by a run.
Version 0.22.1.

## 2026-08-12 — `setup-product-ai`: the question is reachability, not addresses

The roster's last gap, and it turned out to be a different skill than the one CLAUDE.md
sketched. `setup` was chartered to *wire per-workspace IDs* — but the product team has exactly
one board, and the tracker doc names it, so there is nothing to wire. What actually fails is
**reachability from one person's session**: the Notion connector isn't connected, the GitHub
MCP isn't authorised, the shared plugin isn't installed, the design tool has never been logged
into. Every one of those presents as "the PRD isn't there".

So the skill checks the four things a session needs — the shared plugin, the board, the code,
the design tool — reports which are reachable, and hands back the clicks for the rest. It
**writes nothing**, which is why it needs no yes and the confirmation line never appears in it.

**It carries the plugin's one deliberate voice exception.** Every other skill is forbidden to
name machinery; this one has to, because the human is being asked to click something and a
click has a name. It names what they see in their own settings — the Notion connector, the
GitHub MCP — and nothing beyond that.

It also owns the one step no setup can perform: the **PRD template** install, whose
self-referential view filters are clicks no API can make.

Wired in at the router as an on-ramp with a routing instruction that matters more than it
looks: **route "nothing is reachable" to setup *before* diagnosing anything else.** A PRD that
"isn't there" is far more often an unconnected tracker than a missing PRD, and a session that
starts diagnosing the board instead of the connection wastes the turn and worries the PO.
`ask-prd-ai`'s bindings paragraph loses its "`/setup` will wire IDs when it exists" promise
along with the sandbox framing — there are no addresses to wire.

Counterpart check recorded in `lock.md`: `engineering/setup-matt-pocock-skills` exists upstream
and was rejected as the wrong act — it installs MP's skills into a repo, where this verifies an
installed plugin can reach its surfaces. Net-new, no text to vendor. Version 0.22.0.

## 2026-08-12 — the machine account exists, and both Apps belong to the org

`github@timeleft.com` is live as **`timeleft-bot`**, an org member of `timeleft-dev`. It
therefore carries the org's `default_repository_permission` — `write`, and `admin` on
`timeleft-os`. **PO decision: accepted as-is**, on the grounds that code eyes are held
read-only by the MCP endpoint and the App's permissions. Recorded in `docs/github-access.md`
as a decision rather than a drift, with the one operational consequence that follows from it:
the shared passkey reaches an account that can write, so **vault membership is the boundary**,
and offboarding means removing the passkey, revoking sessions, rotating. The earlier
outside-collaborator design is superseded; `code-repository.md`'s rules are untouched, because
"reads only, findings in product language" never depended on what the credential could do.

**Both GitHub Apps are owned by the organization, not by the bot account** — the answer to the
PO's question, and it is mechanical rather than stylistic. A personal-account App is either
installable *only on that account* (useless: the repositories belong to the org) or must be
made **publicly installable by anyone**. Org ownership keeps it private, keeps it manageable by
org owners, and survives the bot account being rotated.

The conflation worth naming, since it was the question underneath the question: **an App is not
linked to the account that signs in through it.** The App is the OAuth client — its ID and
secret go in the connector's Advanced settings, its permissions cap every token it issues.
`timeleft-bot` is the *user* who signs in through that client with the shared passkey. Two
independent roles.

Two Apps, because their permissions differ and their names show up in different places:

- **App 1, code eyes** — `Contents: Read-only` + `Metadata: Read-only`, webhooks off, callback
  `https://claude.ai/api/mcp/auth_callback` (the flow's error names the URI if that is wrong,
  and an App accepts several), installed on the three repositories. Endpoint URL unchanged, so
  `.mcp.json` needs no edit.
- **App 2, release-please** — `Contents: Write` + `Pull requests: Write`. Chosen over the PAT
  the PO first asked about for three reasons independent of any security argument: an App
  **consumes no license seat** (the org is at 24/24 today), its token is **minted per workflow
  run** by `actions/create-github-app-token` rather than stored, and an App token **triggers
  downstream workflows** where `GITHUB_TOKEN` does not — which is the actual reason
  release-please setups reach for a PAT. One App could serve both flows; keeping them apart is
  mostly attribution, since release commits and tags carry the name of the App that made them.

The checklist in the doc now tracks what is done (account, org access) against what remains
(vault split, passkey, both Apps, the end-to-end connect, retiring the OAuth App). Version
0.21.2.

## 2026-08-12 — code eyes: one powerless machine account, shared by passkey

Two corrections to the plan written earlier today, both from the PO checking the actual
connector dialog instead of trusting the note.

**The shared-token mechanism doesn't exist on this surface.** A custom connector offers
`Individual sign-in` and `Managed authorization` (Beta) — and the beta's *Request access*
button is inert for us. More importantly it would not have helped: it federates each member's
**own** identity through the IdP, so every PO would still need a GitHub identity. The
`static_headers` fixed-token mechanism my earlier note described is not what this dialog
offers; it is retracted rather than deferred.

So somebody signs in, and the design question becomes *who*, with three honest answers: the
machine account shared, a free GitHub account per PO (real attribution, one license seat
each), or no code route on claude.ai (which costs triage the claim-verification that once
stopped a PRD asserting "stored full-size" on a Slack thread's word).

**Chosen: the machine account, made deliberately incapable.** This reverses my objection from
this morning, and the reason it is now sound is that the containment moved. Instead of keeping
a powerful credential secret, the account itself cannot do damage: an **outside collaborator**
— not an org member — with **Read** on exactly three repositories, no teams, no org roles.
Worst case if the login circulates internally is read access to three repos by someone who
already works here. That property survives someone pasting the wrong thing into Slack, which
secrecy does not.

**With the standing rule that makes it stay true: this account never receives another grant.**
Not a fourth repository, not write access "just for a migration". A dozen people hold its
login and every widening is invisible to all of them.

**A passkey in a 1Password shared vault is the right way to share it** — better than the
password, not a concession. Nothing to paste into a chat, phishing-resistant because it is
bound to github.com's origin, and revocation is deleting one item plus removing the key rather
than rotating a secret a dozen people have memorised. The account's password, TOTP and
recovery codes stay in a **restricted** vault as break-glass; they are not the daily path. My
original objection was to sharing a passkey *as if it were the MCP credential* and to sharing
a *powerful* account — neither is what this is.

The GitHub App swap stands unchanged and now buys containment twice: a user-to-server token is
capped by the App's read-only permissions **and** by what the signed-in account can reach.

Costs written down rather than glossed: no per-person audit trail (every read appears as the
bot — fine for read-only, never for writes), and a shared login still needs an offboarding
step, so passkey removal joins the product-team runbook. `docs/github-access.md` carries the
full design and the eight human steps. Version 0.21.1.

## 2026-08-12 — the code-eyes credential gets a shape: two audiences, two credentials

The deferred note from 2026-08-08 (the OAuth App behind the connector grants account-wide
read **and write**, so "read-only" rests on the endpoint path rather than the credential) is
now a written plan in `docs/github-access.md`, prompted by the PO asking whether the product
team could share a passkey on a `github@timeleft.com` account.

**The passkey idea was the wrong tool, for a reason worth keeping:** an MCP connection does
not consume a passkey, it consumes a token — so distributing one wouldn't have made the
plugin work, only let people log into github.com as the bot, where they could add SSH keys,
accept org invites or write wherever that account reaches. The gap between *read three
repositories* and *everything the account can do* was the whole problem with it.

Two credentials, because there are two audiences and one of them has no GitHub account:

- **A GitHub App** (org-owned, `Contents: read` + `Metadata: read`, installed on only the
  three repositories) replaces the OAuth App for anyone signing in as themselves. Real audit
  trail, and the App caps every token it issues regardless of that person's own access. The
  connector's endpoint URL is unchanged, so `.mcp.json` needs no edit — only the client
  ID/secret.
- **A machine account plus a fine-grained PAT**, entered once by the workspace admin into the
  connector's `static_headers`, for POs who should never need a GitHub account. Nobody signs
  in; the token cannot write. The machine account's own passkey goes to the vault for
  recovery, not to the team.

The constraint that forces this split, restated so nobody re-derives it: **Anthropic
connectors do not support a pure `client_credentials` grant** — every connection needs user
consent, so a GitHub App narrows the grant but never removes the human. `static_headers` is
the only humanless route.

Also written down before it can go wrong: **the tech plugin's write credential must be its
own App.** `implement-issue`, `address-pr-review` and `merge-pr` need `Contents: write` and
`Pull requests: write`; the moment one credential serves both rosters, product's read-only
guarantee is gone.

`code-repository.md` gains one paragraph pointing at the intended shape, with the honest
interim: until the swap lands the route may still be an account-wide credential, which
changes nothing about what a session may do and is a reason to be stricter, not looser.
Every step is a human's — creating the account, registering the App, minting and entering the
token. Version 0.21.0.

## 2026-08-12 — `Rollout type` and `Ops` adopted; the gate reads how a thing ships

Both recommendations from yesterday's measurement, now live on the board with prod's own
option colours for `Rollout type` (brown / yellow / pink) so takeover needs no migration
there.

They join the PO-owned planning columns — no skill ever writes them — but they are the
first two planning columns a skill **reads**, which is the interesting part:

- **`Rollout type` changes what the document owes.** The gate's handoff-surface check now
  asks for the success metric and the variants when a PRD is marked an A/B experiment, and
  for the market order when it is a gradual rollout. Unmarked owes neither. The reasoning:
  an experiment nobody can call isn't a plan, and that gap is invisible at handoff — tech
  builds the variants and discovers at rollout that nobody agreed what would count as
  success.
- **`Ops` names a third audience.** `Involved` / `Led` as one select, not prod's two
  checkboxes, because they are degrees of one fact and two booleans permit a contradiction
  (led-but-not-involved). When it's set, the handoff says so rather than letting the tech
  team discover that delivery needs the Ops team.

**Deliberately not built: an `Ops review` flag.** The asymmetry is real — a PRD declaring
new data work must carry `Data review: Approved`, and a PRD the Ops team has to *run*
carries nothing equivalent. But "a third review axis" is the exact trigger recorded for
revisiting the parked Reviews-DB design, so adding the flag now would prejudge that design
rather than inform it. Logged in `docs/prod-board-takeover.md` as open.

Version 0.20.0. The Notion move and the `timeleft-dev` push both remain parked on the PO's
explicit go.

## 2026-08-11 — the title columns get real names, and prod's columns get measured

**PRDs' title column is `Feature`, Tickets' is `Title`** (both PO-directed). `Feature`
singular carries an invariant — *one PRD = one feature* — which turns the no-"and"-bundles
rule from style into structure: a page needing "and" is two features, so two PRDs. `Title`
retires the last `Name`, so no property in the sandbox is called after its datatype any
more.

I argued against `Feature` and was overruled; recording both halves, because the guard
still has to exist. The objection: at *filing* that cell holds a **problem**, not a
feature, and a header reading `Feature` invites a filing session to name a feature before
anyone chose one — the failure triage exists to prevent. The reconciliation now lives in
the handle rules: **the header names what the row is becoming, not what it is on day one**,
and filing still names the problem. The lifecycle rule is unchanged; it just had to be
said out loud next to a header that implies otherwise.

**Prod's columns, measured rather than guessed.** The question "what else should we have?"
deserved fill rates, not a reading of the schema: 306 rows, 123 active. Everything above
20% we already have an equivalent for (`Owner` 91%, `Squad` 78%, `Quarter` 71%,
`Responsible Engineer` 41%, `Priority` 26%, `Figma` 24%, `Jira Link` 20% ≈ our
`Tech issue`). Two gaps are real:

- **`Rollout type`** (49 rows) — the only unadopted field that *changes what the PRD must
  contain*: an A/B experiment needs its success metric and variants before handoff, a
  gradual rollout needs the market order. Recommended, not built.
- **Ops involvement** (64 rows across two checkboxes) — recommended as one select
  (`Involved` / `Led`), since the two are degrees of one fact. It also exposes a real
  asymmetry: a PRD declaring new data work must carry `Data review: Approved`, and nothing
  equivalent exists for a PRD the Ops team has to run. An `Ops review` flag would close it
  — deliberately not proposed, because "a third review axis" is the trigger we set for
  revisiting the parked Reviews-DB design.

Everything else stays out, with its fill rate as the reason (`Size` 3%, `Cities` 1%,
`Design Due Date` 1%, `QA Checklist` and `Sent to #data_product` one row each). One of
them is worth more than its column: **`Results`** (6%) names something the machine lacks
entirely — after `Rolled out`, nothing asks *did it work?* That is a workflow gap, not a
missing field, and it belongs to its own design pass. All of it is in
`docs/prod-board-takeover.md`. Version 0.19.0.

## 2026-08-11 — PRDs can wait on each other; the Statuses DB becomes Phases

**Dependencies are real work in production, so we adopted them.** Checked before
designing anything: 12 prod rows use its `Dependency` relation and four are live — one of
them named *"Waitlist → Last-Minute Bookings [on hold until Later Booking Window]"*, where
somebody encoded the prerequisite **in the title** because no column surfaced it. That row
is the argument.

The PO's read — "MP's skills already do this, tickets block each other" — is half right,
and the missing half is the point. A ticket's `Blocked by` orders *questions inside one
map* and feeds the frontier computation; that's wayfinder's and it works. But wayfinder
never looks across maps: MP's roster is per-effort by construction, so **nothing upstream
manages PRD↔PRD ordering.** The pattern transfers, the management doesn't.

So: PRDs gain **`Dependencies` ⇄ `Blocks`**, a dual self-relation (prod's is one-way and
singular; dual means both directions read off a card). Three rules, all in the tracker doc
with a table separating it from the ticket relation, because conflating the two is the
obvious failure:

- **A dependency never parks a PRD and never blocks the gate.** Tech sequences delivery —
  a PRD can be specced and handed over while its prerequisite is still being built, which
  is how stacks work. What's forbidden is handing over *silently*, so the gate gains
  check 7: name each prerequisite and where it stands. It fails only on a dependency at
  `Rejected` — depending on something nobody will build. Parking stays the PO's act alone.
- **Never close a cycle.** Walk the chain first; a cycle means the two are one effort, or
  the arrow points the wrong way.
- **Declared, not inferred.** Nothing derives a dependency from similarity — that is what
  triage's fold and reject-with-citation are for. Set at triage (prior art turns out to be
  a prerequisite, not a duplicate), at refining's checkpoint (a resolution reveals an
  order), or by the PO; read in the router's orientation answer as one clause.

**The Statuses database is now `Phases`**, its title column `Phase`, and the tracker doc's
`Status writes` section is `Phase writes`. It finishes the thought the property rename
started: a database of phases whose rows described "statuses" was one word away from
coherent. The routing read now says what it means — the Phases row whose `Phase` equals the
PRD's `Phase`.

**The title column stays `Name`, deliberately.** Prod's is headed `Features`; adopting it
would have every filing session naming a feature before anyone decided there should be one
— the exact failure triage exists to prevent, and a contradiction of the lifecycle-naming
rule (a problem at filing, a solution handle only after drafting picks one). The takeover
renames prod's header instead: one click there beats a doctrine change here. Both that
decision and the adopted dependency relation are recorded in `docs/prod-board-takeover.md`.

Also landed by the PO, from the palette this changelog proposed: the phases now read as
bands — product's ramp (pink → brown → orange → yellow), purple at the handoff, blue
through tech's pipeline, green for landing, gray parked, red rejected. Version 0.18.0.

## 2026-08-11 — `Status` becomes `Phase`, and colours turn out to be human-only

**The PRDs status property is now `Phase`**, matching production. It also removes a real
ambiguity: `Status` named three different things in this workspace — the PRD's phase, a
ticket's Open/Resolved/Dropped, and the Statuses database's own row column. Only the first
moved; the other two keep the name, and the 14 renamed literals were picked line by line
rather than swept, because a blind replace would have rewritten the Tickets recipes and the
routing read (which legitimately compares the Statuses row's `Status` to the PRD's `Phase`).

**Colours cannot be set through the API — proven, not assumed.** Probed on a throwaway
database rather than the live board: `ALTER COLUMN … SET STATUS('a':pink, …)` does not
parse (the DDL accepts no options for a status property), and the select equivalent fails
with *"Cannot update color of select with name: a"*. Colours exist only at creation time,
and renaming a status option is UI-only for the same reason. Recorded as an install-time
note in the tracker doc, with the trap named: **never** try a bare `SET STATUS` on a live
board to force it — that redefines the option set the rows depend on. The palette below
was therefore handed to the PO as clicks.

The palette's rule, for the record, because "make the colours mean something" needs a
stated system: **on a board the column already tells you the phase, so colour should carry
what the column cannot — whose hands the PRD is in.** Product's own phases ramp
(Problem pink → Draft brown → In Refinement orange → In Design yellow), the handoff is
purple, the tech pipeline shares blue *deliberately* (In development / In QA — product has
nothing to do at either), landing shares green (Ready to roll out / Rolled out), On Hold is
gray, Rejected red. Sameness is allowed where sameness is the message; the previous five
identical blues said nothing.

**`docs/prod-board-takeover.md` opens the takeover ledger** — what already matches, the
four deliberate divergences and their rename cost, prod's nine fields we examined and are
**not** migrating (with the reason each), and the two shape differences that fail silently:
prod's title property is named `Features` where ours is `Name` (so the filing act's literal
changes), and its Figma column is text where ours is a URL. Version 0.17.0.

## 2026-08-11 — `In PRD` becomes `In Refinement`, `Team` becomes `Squad`, and the rig stops calling itself one

Three PO-directed changes, all preparing the board to be read by people who did not build it.

**`In PRD` → `In Refinement`.** The old label was inherited from the production board for
takeover parity, and it was the one label that said nothing: *every* status from Draft to
Rolled out is "in PRD" — the artifact is the constant, not the phase. `In Refinement` names
what is actually happening (the map is charted, tickets are being resolved and folded
back). The cost is honest and accepted: it adds a second pre-handoff rename at takeover,
where before only Backlog→Draft was planned.

Moved through all three layers, as the binding requires: the Statuses row (name + Meaning,
plus the two neighbouring rows whose `Handled by` and `Meaning` narrate it), 24 binding
literals across `issue-tracker.md`, `ask-prd-ai`, `refine-prd`'s P4 patch, `lock.md`'s
drift records and CLAUDE.md — and the PRDs `Status` option itself, which is the PO's UI
click because the connector cannot rename a status option (the same wall the `Problem`
rename hit; `ALTER COLUMN … SET STATUS` would reset the option set, so it is not attempted
on a live board). Between the two halves the machine is deliberately inconsistent and
fails safe: status-writes rule 5 stops a session on a status matching no live row rather
than letting it guess.

**`Team` → `Squad`, matching production.** Checked the prod board's schema rather than
assuming: `Quarter` and `Priority` were already identical option-for-option, and the third
column differed only in name — prod calls it `Squad`. Renaming ours also kills a collision
we had built ourselves: the Glossary defines *team* as CX / Ops / Data / Partnerships, so a
property named `Team` holding "Core XP" contradicted the vocabulary the same workspace
publishes. Values stay the PO's to set; no skill writes them.

**The tracker doc stops describing itself as a private test rig.** That sentence was
load-bearing in the wrong direction: a session told it is working in a rig treats a real
PRD as disposable. It now says the opposite — the board is the team's, the rows are real
work, humans work here too and a page may have moved since you read it. CLAUDE.md's
sandbox heading and its "all work targets the private HQ sandbox" line follow.

Recorded for the takeover ledger, from reading prod's schema: beyond the three planning
columns, production also carries `Size`, `Rollout type`, `Cities`, `Ops-led`,
`Ops-Involved`, `Sent to #data_product`, `Dependency` (a self-relation), `Target Release`
and `Experiment`, names its title property `Features`, its status property `Phase`, its
engineer column singular, and its Figma column as text rather than a URL. None of that is
adopted today; it is the gap list the takeover effort inherits. Version 0.16.0.

## 2026-08-11 — the walk answers feedback, and says it is a machine

Three changes to the comment walk, one rename and two rules.

**`address-prd-comments` → `address-prd-feedback`.** "Comments" named the mechanism —
Notion comment threads — where the skill's material is *feedback*: a tech bounce, the
data lead's verdict, the gate's own failures, a stakeholder note. Only some of those are
interestingly "comments"; all of them are feedback. Rejected on the way: anything built
on `resolve-`, which reads better and would lie — resolving a thread belongs to whoever
raised it, so a name promising resolution teaches the opposite of the rule. The tech
roster's counterpart was renamed in the same pass, and that one was a factual error, not
a style choice: `address-issue-comments` never touched an issue. It is `address-pr-review`.

**Every comment and reply opens with the AI line.** `> *This was generated by AI.*` —
its own first line, before the answer. Triage already did this (MP's own vendored
wording, "generated by AI during triage"); nothing else did, and the walk is where it
matters most, because a reply lands *inside a human conversation* on a thread a
colleague started. A PO scanning a thread must never have to work out which voice is a
person's. The rule lives in the tracker doc's two comment acts, so it binds every skill
that posts — the gate's failures and triage's fold comment included — not just this one.

**A reply says only what the raiser cannot see for themselves.** One sentence, two at the
most, with a small table pinning what each outcome owes: a fix names what changed and
where; a decline names the reason and links what settled it; a ticket links itself and
carries the question. Explicitly banned: greetings, thanks, restating the comment back,
narrating how the answer was reached, summarising the rest of the walk. The reasoning is
the reader's, not ours — someone scanning eleven threads pays for every word twice, once
reading it and once deciding it was filler. And the escape hatch is a rule, not a
suggestion: **if the answer needs a third sentence it belongs in the document**, where it
survives; a thread is a bad home for anything worth keeping.

Changed: the skill directory and frontmatter, its step 3, the tracker doc's reply and
comment acts, `lock.md`'s row, `ask-prd-ai` and `send-prd-to-dev`'s references, CLAUDE.md,
and the three `Handled by` cells in the Statuses DB — Notion had to move with the repo
or the router would name a skill that no longer exists. Version 0.15.0.

## 2026-08-11 — the prod-board guard cites an ID that cannot exist

The one address the plugin is forbidden to touch was written as a 31-character ID —
`…e923cd6`, one `c` short of the 32 a Notion ID has. A guard that cannot match the
thing it guards is decoration: no session comparing a real board URL against that
string would ever get a hit.

Found while answering whether the HQ sandbox could move next to the production board,
which also turned up the reason the typo survived: the doctrine named *one* address,
and the board has three. The page (`…36ac3af3`) is what a human pastes; the database
inside it (`…e923ccd6`) is what a link to a row resolves to; the rows themselves live
at `collection://1ae8d7bb-13a2-80e9-8796-000b1171092b`, which is what any query would
name. Now all three are listed, in the binding doc as a table and in CLAUDE.md
inline — match any, refuse.

This matters more the moment the sandbox and the prod board share a parent: today the
two are told apart by where they live, and after a move they'd be told apart only by
ID. Version 0.14.1.

## 2026-08-10 — a sharp question is not yet a ticket

A session spent itself resolving *"Is one check at T-2h enough for small tables?"* — a
ticket whose entire transcript was one recommendation and two "ok"s. The PO asked whether
we had weakened MP's bar for ticket creation. The opposite: **we had kept it exactly, and
it was never designed for this.** His fog test gates on sharpness alone — can you state
the question precisely — because on his maps the dev doing the charting is the one who
will answer, so an obvious question dies naturally in their head. Agent-led charting has
no such filter, and our own ticket budget (P5) quietly read as a quota: three grilling
slots, so three grilling tickets.

The patch (P9) is additive — the fog test stands, and a second sort follows it, with the
mechanism the PO chose: **the agent never classifies alone.** A sharp question goes to the
human in one line with a recommended answer, and their reaction does the sorting:

- **A nod settles it.** No ticket opened to be closed — the answer and the reasoning that
  killed the alternatives fold into the destination, the same fold-back a resolved ticket
  produces, minus the ticket. Decisions that outlive the effort go to the decision record.
  Never into Decisions so far — it indexes closed tickets, and the first draft of this
  rule pointed there until the PO caught it.
- **A hesitation is the ticket.** So is a counter-answer or a question back: two answers
  just survived being said out loud, which is what tickets are for.

Nothing lands silently either way — a settled answer still rides a shown write behind the
confirmation line, so the cost drops from a session to a sentence while the human sees
exactly what they saw before.

And the budget is now explicitly **a ceiling, not a quota** — written into the budget
section itself, since that is where a session mining for its third grilling ticket is
looking. An empty slot is not a missing ticket.

Version 0.14.0 — charting's ticket bar changed. Candidate for the tech plugin's refine
when it lands; recorded in P9.

**Amended after push**: this entry first claimed 0.13.0 and landed mid-file, below three
0.13.x entries from a parallel session. The bump was a `sed` whose pattern named the old
version — 0.12.0 — which no longer existed, so it matched nothing, changed nothing, and
failed silently while validation passed. A version bump is a mutation like any other:
read it back, don't pattern-match it in.

## 2026-08-09 — the Handled by cells catch up with the roster

The drift the review pass flagged, now fixed on the PO's order. The Statuses DB's
routing cells still named acts by their pre-rename short forms — `product:triage`,
`product:draft`, `product:refine`, `product:prototype`, `product:to-tech`,
`product:address`, `product:ask` — and, worse, `product:research` / `product:grilling`,
which stopped being product skills when the resolvers moved to the shared plugin. Every
name predates the global-uniqueness rename and the shared extraction; the cells were
readable as acts but resolvable to nothing a session's skill list actually shows.

All eleven rows updated in place — seven carried names — to the shipped forms:
`product:triage-prd`, `product:draft-prd`, `product:refine-prd`, `product:design-prd`,
`product:send-prd-to-dev`, `product:address-prd-comments`, `product:ask-prd-ai`,
`shared:research`, `shared:grilling`. Verified by re-query: no stale form remains.

One consequence in the repo: the routing guard (in the router and in the tracker doc's
route-by-Handled-by act) said a cell may only name "acts this plugin ships" — which a
strict session would now read as ruling out `shared:research` and `shared:grilling` and
flag the corrected cells as broken. Both guards widened to include acts reached through
the shared plugin.

Version 0.13.3.

## 2026-08-09 — Claude design is the default medium; a review pass on the day's changes

A second-model review of everything this session shipped. The structural changes held —
the one-way `In Design` flip propagated consistently across all six surfaces, git and
Notion agree — but one correction had landed in the wrong layer, and that miss is the
entry's real subject.

During the Ops Notifications design run, the medium table sent the session to Figma:
the ticket's mock "is the handoff", and that row said Figma wins there. The PO stopped
it — new Claude design project, not Figma, delete anything already in Figma. The session
complied, then recorded the correction as a **builder memory** instead of fixing the
binding. That is precisely the drift the fix-layer discipline exists to prevent: a
dry-run correction is a bug report against the plugin, and its fix belongs where every
future session reads it — the config skill's binding docs — not in one builder's private
notes, where the plugin's own sessions will never see it and the table keeps steering
them wrong.

Landed where it belongs: `design-tool.md`'s two-media table is gone. **Claude design is
the default for every prototype ticket**; Figma is reserved for when the human names it
or the deliverable must live in Figma (a design system to extend, a process that
consumes Figma files). "It's the handoff" no longer routes anywhere — the chosen take's
link is the handoff whichever medium made it. If a session still thinks Figma is right,
it says why in one line and asks before creating anything there. The builder memory is
deleted; the binding is the record.

Also from the review, two small accuracy fixes: CLAUDE.md's status-machine line now says
a map with no design question skips `In Design` entirely (the new linear chain read as
mandatory), and the 0.13.0 entry's file list was corrected in place — uncommitted,
same-day — to include the `In PRD` row's Meaning update it had omitted.

Flagged, not fixed: the Statuses DB's `Handled by` cells name acts by their pre-rename
short forms (`product:prototype`, `product:to-tech`) while the shipped skills are
`design-prd` and `send-prd-to-dev`. Consistent across all rows and resolvable as acts,
so routing works — but it's drift waiting for a deliberate pass, not a one-row patch.

Version 0.13.2.

## 2026-08-09 — two nudges toward a fresh session, not a blanket one

Considered suggesting a fresh session at every skill/status transition, for context
hygiene. Rejected as a blanket rule: the whole point of state living in Notion instead of
the chat is that any skill can resume cold, and hinting at a restart after every single
handoff would just be machinery-flavored noise fighting sessions that already chain on
purpose (chart mode flowing straight into firing resolvers, for one).

Two spots earned it instead, because stale context there is a correctness risk, not just
a token cost:

- **`draft-prd` → `refine-prd`.** Chart mode's breadth-first grill works best without the
  drafting conversation's framing still in the room. `draft-prd` now ends its report with
  a nudge to refine in a fresh session.
- **Before `send-prd-to-dev`'s gate.** This check's entire premise is reading the PRD "as
  its first outside reader would" — a session that just sat through the grillings and
  resolutions can't actually do that, no matter how hard it tries to forget. `send-prd-to-dev`
  now says so up front and suggests a fresh session, but never blocks on it.

No nudge for `design-prd`: the reaction ritual is live and HITL by design, and restarting
mid-reaction would break it, not help it.

Version 0.13.1.

## 2026-08-09 — design becomes a one-way stop

PO-directed change to the status machine. `In Design` used to be a round-trip: claiming
the prototype ticket flipped the PRD there, resolving it flipped back to `In PRD` so the
map could pick up wherever it left off. Reasonable when a prototype ticket could resolve
at any point in a map's life, but that was never actually true in practice — the ticket
budget already treats it as the fidelity-raising step late in refinement, the one that
turns a discussion into something to react to.

So the ordering is now a hard rule instead of a habit: **a prototype ticket is always
blocked by every research and grilling ticket on the same PRD**, wired at creation and
kept current if a later ticket joins the map. It can never reach the frontier until
everything else has resolved — it is the map's last ticket by construction. Which means
resolving it can never leave open work behind, and bouncing the PRD back to `In PRD` to
re-check an already-empty frontier was a step with nothing left to do at it. `In Design`
is now the map's terminal pre-handoff status — same rank as an empty-frontier `In PRD` —
and `/send-prd-to-dev` picks up from either one identically.

Changed: `issue-tracker.md`'s prototype-ticket bullets (blocking + the one-way flip) and
its `Creating a ticket` clause (the auto-wired `Blocked by`); `design-tool.md`'s resolve-act
package (dropped the flip-back); `design-prd`'s description; `ask-prd-ai`'s routing table
(`In Design` now routes like an empty-frontier `In PRD`); CLAUDE.md's status-machine line;
the Statuses DB's `In Design` row (Meaning + Handled by) and `In PRD` row (Meaning).
Drift records amended in `lock.md` for `design-prd` and `ask-prd-ai`.

Version 0.13.0 — the status machine changed.

## 2026-08-09 — the frontier is computed, not read

I said the Frontier view was broken because the API returned nothing. The PO opened the
tab and saw seven tickets. Both true, and I had the diagnosis backwards twice in two
hours — each time after a single confirming run.

The count is the tell. **Seven is open-and-unassigned.** The correct frontier is **five**:
the view's `Blocked` condition filters nothing, so the tab advertises two blocked tickets
as takeable — *What does the chosen surprise look like?* (waiting on *Which surprise hides
behind the code?*) and *What does an ops alert look like in Slack?* (waiting on *Who acts
on each alert*). Meanwhile the same view through `mode: "view"` returned 5 once and 0 on
three later calls, unchanged data throughout. **Wrong in the UI, empty through the API** —
unreliable in both directions, and the two faults hid each other: the UI's extra rows
looked like proof the view worked, the API's emptiness looked like proof it did not.

So the frontier is **computed, not read**. One query returns all seventeen tickets with
`Status`, `Assignee` and `Blocked by`; a ticket is on the frontier when it is Open,
unassigned, and every id in `Blocked by` resolves *in the same result set* to Resolved or
Dropped. Verified by hand against all seventeen — it produces the five, and it produces
them from data SQL can actually read. `Blocked` and `Open` being unavailable to SQL turns
out not to matter: `Blocked by` plus `Status` is the same fact one join away, and the only
form of it a session can read at all.

Three rules replaced, all mine, all from this afternoon: "read the frontier through the
view", "membership is the entire signal", "if the view is empty, say the view is broken".
The tracker doc now says the opposite and says why, and adds the condition for ever
trusting a view again: **re-verify with a count against a hand-resolved answer, on more
than one call.** This view passed a single run and was recorded as verified; three later
runs disagreed with it, and a fourth would have caught it before it shipped.

**The lesson is about my own verification, not about Notion.** One green run is not a
test — it is an anecdote that agrees with you. The rule that survives is: check the number
against something computed independently, and repeat the call.

Version 0.12.0 — the frontier's mechanism changed.

## 2026-08-09 — an empty view is not an empty frontier

A session reported the three open decisions correctly and added a flag: *"the board's
Frontier tab — the one meant to show what's free to pick up — is coming back empty right
now, so the board looks emptier than it is. I read the tickets directly, so the list above
is right; the tab is worth a look."*

Confirmed. The view returns zero rows while three tickets sit **Open, unassigned, with no
blockers at all**. It returned five rows an hour earlier with the same data. The fault is
the view's `Blocked` condition — an `every` operator with a `string_is "false"` text
comparison against a *formula* property, which is the shape a filter takes when it is set
through the API rather than the UI, and the shape already recorded as silently
misbehaving. Repair belongs in the Notion UI; setting it again through the API reproduces
it.

**The plugin's own gap is the more interesting half.** An hour earlier this binding gained
"membership in the view is the entire signal" and "never state something is unblocked from
a SQL result" — sound rules that, against a broken view, instruct a session to report an
empty frontier and stop. The session ignored them, read the tickets directly, got the
right answer, and said which part it did not trust. Exactly right, and nothing in the
plugin blessed it.

Now written down: if the view comes back empty, cross-check with a SQL count of open
unassigned tickets; where that finds some, **the view is broken, not the board** — say so,
fall back to resolving `Blocked by` by hand, and name the blockers checked so the answer
can be audited.

The pattern worth carrying: **a rule that says "trust X" needs a companion saying what to
do when X is wrong**, or the first time X breaks the plugin reports the breakage as fact.

Version 0.11.9.

## 2026-08-09 — the link rule becomes a check, not a fact to remember

Asked whether the link fix would work this time. Honest answer: the first one failed
because it was a rule about **where a URL came from** — "use the `url` the response gave
you" — and the second was still partly that, telling a session which response shapes hand
back the broken form. Both require holding a fact in mind at the moment of writing, which
is the weakest kind of rule and the reason the first attempt shipped dead links.

Rewritten as an invariant on the output:

> **Before you show a Notion link, check it has `/p/` after the domain.**

One look, at every link, whatever it came from. No tracking of sources, no remembering
that queries and relations differ from fetches — the shape is either right or it is not,
and it is visible in the string. The explanation of *why* the shapes differ stays in the
tracker doc for whoever wants it; the rule at the point of use is a check.

This is the general lesson from three attempts: **a rule that asks a session to remember a
fact fails at the moment it matters, and a rule that asks it to look at what it just wrote
does not.**

Version 0.11.8.

## 2026-08-09 — the view-mode fix, actually run

The PO asked whether the fix had been tested. It had not. Running it confirmed it works
and turned up two things assumption would have got wrong — which is the whole argument for
asking.

**It works.** Querying the Frontier view returns five tickets and *"What does an ops alert
look like in Slack?"* is **not** among them. The view knows it is blocked; the three
unblocked grilling tickets come back, including the real blocker.

**`Blocked` and `Open` come back as opaque `formulaResult://…` references, never values.**
So the formulas are unreadable in view mode too — the view *applies* them, it does not
expose them. **Membership is the entire signal**: a ticket in the results is takeable, a
ticket absent is not. A session that queries the view and then inspects the `Blocked`
field gets a URL-shaped string and everything it concludes from that is invented. The
earlier wording invited exactly that by saying the tracker "applies the formulas for you".

**View mode returns the working `/p/` URLs** — in the `url` column and in relation columns
alike, where SQL hands back the dead bare form. A second, independent reason to prefer the
view that nobody had noticed.

**And the binding described the view wrong.** It said *Open + unassigned + not Blocked*;
the actual filter is **unassigned + not blocked**, with no `Status` condition at all.
Corrected here and in CLAUDE.md, with the note to read `Status` if a resolved-but-unassigned
row would mislead. Same class as `🗺️ Map` vs `Refinement` and `api-nestjs` — a literal in a
binding that nobody had checked against the thing it describes.

The view URL is now in the binding as a runnable call, marked verified with its date.

Version 0.11.7.

## 2026-08-09 — the frontier is a view, not a query

A session answering "what's next?" said the Slack design ticket was *"just unblocked now
that the two questions it depended on are both answered"*. It is not. Its blockers are
**Does TOS know how many venues an event needs before groups exist?** (resolved) and
**Who acts on each alert, and what counts as done?** — an *open grilling ticket the same
message listed three lines below as available work*. It also named the wrong second
blocker, citing a different resolved ticket that does not block it.

Not a model failure. **The binding asked for a judgement the query method cannot make.**
`Open`, `Blocked` and `Open blockers` are formulas, and the data source reports them as
**not available to SQL** — a query cannot select them. A SQL-driven session therefore
cannot see blocking at all; it sees raw `Blocked by` relations, which carry ids and no
statuses, and has to resolve every one by hand. The binding named the Frontier view as the
edge of the known and never said that reaching it any other way is guesswork.

Three rules now:

- **Read the frontier through the view** (`mode: "view"`), where the tracker applies the
  formulas. **Never state that something is unblocked from a SQL result** — that sentence
  is not derivable from what SQL returned.
- Working from relations at all: blocked while **any** `Blocked by` entry is not
  `Resolved` or `Dropped`; a blocker you did not look up is a blocker you assumed away.
- **Name the blockers you checked.** "Its two dependencies are answered" is unfalsifiable
  until they are named — and naming them here would have caught it, because the
  contradiction was already in the same message.

**And a correction to yesterday's URL rule, which was wrong.** It said to use the `url` the
response gave you. `notion-fetch` returns the working `/p/<id>` form, but **a SQL query's
`url` column and every relation column return the bare `https://app.notion.com/<id>` — the
dead form**. So following that rule against a query result was the normal way to produce a
broken link while believing you had complied. The rule now names the shareable shape and
says to normalise anything a query hands back.

Version 0.11.6.

## 2026-08-09 — use the link the tracker gave you

Rule 10 landed and sessions started linking — to `https://app.notion.com/<id>`, which is
not a Notion page URL. The real one carries a `/p/` segment, and every fetch and create
response already contains it as the page's `url` field. The plugin was assembling links
from ids instead of using what it had been handed.

**What makes this worse than a typo is how it fails.** A malformed Notion link does not
look malformed. It opens *"This page couldn't be found — you may not have access, or it
might have been deleted or moved."* Someone clicking that has no way to distinguish a
formatting slip from a permissions problem or a page that was genuinely deleted — so the
damage is not a bad click, it is doubt about whether the write landed at all. Rule 10
exists to let a reader verify the work; a dead link makes verification say *the work is
gone*.

Fixed in the layer that owns it: the tracker doc's Tools section now says never build a
page URL, use the `url` the response gave you, and fetch the page if you need a link to
something you have not touched this session. The voice rule carries the one-line version,
because it is the rule that asks for links in the first place.

Version 0.11.5.

## 2026-08-09 — name it and link it

A research session claimed two tickets, resolved both, edited the PRD, and reported:
*"Both tickets claimed… Now ticket 2's resolution… Both tickets resolved… Four left on the
map — three grilling, one prototype."* Not one name, not one link. To check any of it the
reader has to go and find the board.

The rule half-existed. `refine-prd` carries MP's **Refer by name** section — *"refer to it
by that name, never by a bare id… a name wraps its link"* — which is exactly right and
lives in exactly one skill, so a resolver invoked directly never sees it, and the link is
a subordinate clause easy to read past. Promoted to the voice as rule 10, where every
skill gets it:

- **Every PRD, ticket, decision or thread touched or pointed at appears as its own name,
  carrying its link.** An id is a lookup; a name is a fact.
- **Counting is not naming.** "Four left — three grilling, one prototype" says how many
  and not which, so the only way to act on it is to open the board. Too many to list means
  list what is takeable now and say the rest are blocked.
- **A name without its link is the near miss** — the reader's next move is almost always
  to open the thing. The one exception is a write still being previewed: no link until it
  exists.

Two other leaks in that transcript were already fixed and are worth not re-diagnosing:
*"Rev is still 2"*, *"PRD's at rev 3"* and *"on the map"* are banned by rules shipped
earlier today. That session is running a build several versions back — everything before
0.11 is still out there until the push lands.

Version 0.11.4.

## 2026-08-09 — `setup` should prompt, not tutor

Found while reading the manifest schema for `displayName`, and recorded against `setup`'s
roster entry before it is built, because it changes what that skill *is*.

`plugin.json` has a **`userConfig`** field: values Claude Code prompts the user for when
the plugin is enabled, typed (`string`, `number`, `boolean`, `directory`, `file`) with
`required`, `default` and `sensitive` options. Non-sensitive values substitute into skill
content as `${user_config.KEY}`, and reach hooks as `CLAUDE_PLUGIN_OPTION_<KEY>`.

Which means the addresses in `issue-tracker.md` — the four data sources, the HQ page, the
contract page — can be placeholders filled per install rather than literals committed
here. Three things follow:

- **`setup` stops being a file-editing tutorial and becomes a verifier.** Its roster entry
  described walking a human through wiring IDs. The prompt does the wiring; setup checks
  what arrived and does what no prompt can — the PRD template install, and the
  self-referential view filters that are the clicks no API can make.
- **The same plugin serves the sandbox and the real board** without a code change. The
  test rig stops being baked in, which is what the tracker doc's "for now every address
  below points at the private HQ sandbox" was apologising for.
- **The Notion IDs leave this public repo.** They land in each user's own settings, and
  `pluginConfigs` is deliberately *not* read from a project's `.claude/settings.json` — a
  cloned repo cannot inject them. That is a direct improvement on the public-by-decision
  trade recorded on 2026-08-08.

**Not verified on claude.ai.** The prompt is documented for Claude Code, and this week has
supplied a steady run of things that were documented, plausible, and absent on the surface
that mattered — a connector reading "connected" with no tools, hooks that do not run in
chat mode. Test the prompt on the surface a PO actually uses before building `setup`
around it; if it does not appear there, the walkthrough is the fallback, not the plan.

Version 0.11.3.

## 2026-08-09 — the picker says "Product Team", and the shared dependency is declared

Two manifest fields, both of which replace something we had been doing the hard way.

**`displayName`.** The `/plugin` picker and claude.ai's UI showed "Product" — derived from
the identifier, because nothing else was offered. It now shows **Product Team** (tech:
**Tech Team**, shared: **Shared Toolkit**). The important property is that `displayName`
is *"not used for namespacing or lookup"*: identifiers stay `product`/`tech`/`shared`, so
skill prefixes, the marketplace entries and every cross-reference are untouched, and
nobody reinstalls. A rename that would have cost a repo-wide sweep this morning costs one
line.

**`dependencies`.** This plugin now declares `shared`. Hours earlier we wrote that
dependency into CLAUDE.md as a rule for a `setup` skill that does not exist yet — check
the session's own skill list, walk the human through installing it, re-check. The platform
has had a native field for it the whole time, and it acts at **install** time rather than
at first use, which is the difference between a teammate never hitting the problem and a
teammate hitting it mid-refining.

The setup check stays, deliberately: a declaration says what *should* be installed, and
this week's running lesson is that the honest test of a capability is whether you hold it.
Belt and braces, with the braces now doing most of the work.

Version 0.11.2.

## 2026-08-09 — a label is not a reference

A refining session reported: *"Can Alert 3 reuse the existing group-without-venue check?
No. What exists bundles 'no venue' with an unrelated 'no groups at all' signal…"* — and
the PO, who owns the PRD, had no idea what Alert 3 was.

Every voice rule so far bans the **plugin's** machinery: skill names, status labels, rev
numbers, ticket counts. "Alert 3" is the **document's** shorthand, which is why nothing
caught it. It is technically the reader's own vocabulary, from their own PRD. That is
exactly what made it invisible as a defect — and it is still unreadable, because *owning a
document is not holding it in your head*. The session had the whole thing loaded; the
reader had a phone and four minutes.

New rule: **never make the reader look something up.** The first time a label appears in a
message, it carries what it refers to — *"Alert 3 — the one where a group ends up with no
venue"* — which earns the short form for the rest of that message. Applies to any coded
reference: a section, a ticket whose title is really an identifier, a PRD by abbreviation,
a glossary term used before it is agreed. "As defined in the Requirements section" fails
it too: that is a lookup wearing a helpful face.

One extension worth having: if a document's own labels need this treatment *every* time,
say so once. A PRD whose requirements are only distinguishable by number is a PRD nobody
can discuss out loud — in a meeting, in Slack, or with the tech team.

Version 0.11.1.

## 2026-08-09 — the descriptions are written for the person reading them

The PO flagged `address-prd-comments` for saying "an issue" and "the document". It was one
instance of a class: **every description still carried upstream's vocabulary**, because a
description is written before any session exists and the voice rules only govern what a
session says. The one surface the voice work could not reach was the first one a person
sees.

A description does two jobs and was failing both:

- **It is what a person reads in the picker.** `ask-prd-ai`'s was the worst — *"a
  state-aware router over this plugin's skills… routes to the right act, or serves the
  read itself"*: four pieces of machinery in one sentence, on the entry point a PO is most
  likely to open. It now says *start here for anything to do with a PRD*, with the
  examples in the words someone actually types.
- **It is what the model matches on**, which made `triage-prd`'s an outright bug rather
  than a style problem. It advertised **"issues and external PRs"** while
  `issue-tracker.md` states flatly that external pull requests are not a request surface
  on this tracker. A PR-shaped request could have routed straight into a skill with
  nowhere to put it.

All eight rewritten: PRDs rather than issues, plain English for statuses (*"hand it to the
tech team"*, not *"flip it to `Ready for development`"*), and no skill mentioning
machinery a product manager has no use for. Bodies untouched — frontmatter only. Recorded
as drift **R2** against the three vendored skills whose descriptions were MP's; the rest
were locally written and had simply copied his vocabulary out of mimicry.

**Caught by the validator, and worth keeping.** Two of the rewrites contained a
colon-space inside a plain YAML scalar — *"comments waiting: a tech bounce"*, *"in a PRD:
put the open questions"* — which breaks the **whole** frontmatter block. The validator's
wording is the important part: *"at runtime this skill loads with empty metadata (all
frontmatter fields silently dropped)"*. Not a mangled description: **no name, no
description, the skill effectively unnamed.** From a punctuation mark in prose, with
nothing at runtime to say so.

Two rules out of it. Prose in frontmatter takes em dashes, never colons. And validation
gets checked, not piped — the run that found this was `claude plugin validate | tail -1`,
where the pipe returns `tail`'s exit code and the `&&` after it proceeds happily past a
failure. Every skill in all three plugins now parses.

Version 0.11.0 — descriptions change what auto-invokes, so this is behaviour, not text.

## 2026-08-09 — the delegating session claims; the subagent can't

Asked whether `/research` assigns the ticket it resolves. It does not, and **it cannot** —
that skill moved to the shared plugin precisely so it knows nothing about this tracker,
and a background agent has no identity in this workspace to be assigned to. The admission
rule working correctly, with a consequence nobody had followed through.

The claim rule existed in two places and neither covered delegation. Worse, **charting's
step 5 skipped it outright**: it created N research tickets with `Assignee` empty and
immediately fired N subagents at them. Every one stayed on the **Frontier** view — Open,
unassigned, not Blocked, i.e. advertised as takeable — while an agent was already working
it. Parallel fire is exactly when a second session is most likely to grab one, so the
place the rule was missing was the place it mattered most.

Two corrections. The tracker doc's Claim act now names *who* (the human driving, the same
person who lands in `Resolved by`) and adds the delegation case: a tracker-agnostic
resolver cannot claim for itself, so **the session that delegates claims first, then
fires** — all of them, then all of them. Charting's step 5 becomes "claim, then fire".

Version 0.10.4.

## 2026-08-09 — a resolver reads the ticket's comments first

The PO left a comment on a live research ticket and asked whether a session would see it.
It would not, for two independent reasons — either alone enough to lose it:

- **`notion-fetch` returns no comments unless asked** (`include_discussions: true`). A
  plain read of the ticket returns the body and hides the thread with no sign it exists.
- **Nothing told a resolver to look.** "Enumerate the open comments" existed only in the
  PRD-level review flow. Picking up a ticket had no equivalent.

The comment in question was *"there is a legacy health check endpoint in the backend,
never used by anyone, it has to be ignored"* — on a ticket asking where the existing
check lives. A research agent that never saw it would have found the legacy endpoint and
returned it as the answer, confidently and wrongly. That is the worst shape a miss can
take: not a gap, a plausible falsehood.

Picking a ticket up is now its own act in the tracker doc, ahead of resolving: fetch with
discussions included; treat a comment as a **constraint added after the ticket was
written**, not commentary; **inline-anchored comments bind to the line they sit on**, so
one is an amendment to that bullet rather than to the ticket; say in the findings how each
was honoured; and never resolve the thread — only whoever raised it clicks resolve.
`refine-prd`'s work-through step points at it, so the rule arrives whether a resolver is
entered through refining or invoked directly.

Version 0.10.3.

## 2026-08-09 — a resolved ticket keeps its icon

Resolving set the icon to ✅ (Dropped, ⛔), on the reasoning that "the icon carries type
while a ticket is alive, lifecycle once it isn't". Wrong: `Status` already says where a
ticket stands, so the flip bought a second copy of something the board already showed —
and spent the only thing the board showed *once*. A resolved map became rows of identical
✅ with no way to see, at a glance, which questions were research and which were
decisions. The history of how a PRD was refined is exactly what a finished map is for.

The icon is now set once at creation, from the type, and never rewritten by any later
act. Corrected in three places, since the rule had leaked: the resolve act, the create
act, and `design-tool.md`'s echo of the resolve package.

Version 0.10.2.

## 2026-08-09 — the move's loose ends, found by review

Three, all created by the move and all invisible from either side alone.

- **`triage-prd` was instructing the callee to break its own new guard.** Its grill step
  said "updating `CONTEXT.md`/ADRs inline as decisions land" — while the skill it invokes
  now refuses file destinations without a binding. Caller says write files, callee says
  never assume a repository: the step stalls or writes somewhere wrong. It now says
  *record the glossary entries and decisions inline, wherever the tracker doc says those
  live* — abstract verbs, which is what skill prose was always supposed to speak. The
  concrete filename in a skill file was a doctrine violation that predated the move; the
  move just made it contradictory as well as wrong.
- **Two dangling sibling references.** `issue-tracker.md` pointed at `ADR-FORMAT.md` and
  `CONTEXT-FORMAT.md` bare — files that now live in another plugin. Both now name the
  owning skill, with the reason attached, because "name the skill, never a path" is the
  rule that exists precisely so a file can move between plugins without breaking its
  readers. It broke here because the reference named neither.
- **The shared plugin's pin had no maintainer.** It ships `lock.md` and `changelog.md`
  like the others, but CLAUDE.md's self-containment rule assumes every plugin has an
  `update` skill, and CI now compares three pins. Recorded: `shared` gets its own
  `update` (no `setup` — it binds nothing).

Version 0.10.1.

## 2026-08-09 — `glossary-and-decisions` follows to the shared plugin

Moved the day it was patched, and the deferral I argued for an hour earlier turned out to
rest on a mistake of mine worth recording.

I said the blocker was "where the Glossary and Decisions addresses live", and proposed
either a config skill inside `shared` — needing a cross-plugin reach nothing has tested —
or duplicating the translation into tech. **Neither is needed.** P1 had already made the
skill destination-free, which means it needs no addresses of its own: the caller passes
the binding, exactly as `research` does. I had carried over an assumption from before the
patch and not re-checked it against what the patch changed.

So the move is a directory move. This plugin's `issue-tracker.md` keeps its translation —
`CONTEXT.md` → Glossary rows, `docs/adr/` → Decisions rows — because that is per-plugin
binding and belongs where bindings live. Tech writes its own when it arrives; that is the
normal pattern, not duplication to avoid.

**The name stayed `glossary-and-decisions`**, the PO's call. Reverting to upstream's
`domain-modeling` would have bought back verbatim as it did for `grilling`, and no reader
would ever have noticed since skill names are never said aloud — but the picker is the one
place a name is still visible, and a person recognises this one. The rename outlives R1
and is recorded in the shared plugin's lock as C3.

Version 0.10.0 — a third skill left; `/glossary-and-decisions` now needs the shared plugin
installed, like `/research` and `/grilling`.

## 2026-08-09 — the glossary skill stops assuming a repository

Asked whether `glossary-and-decisions` could move to the shared plugin. It can, later —
and the asking turned up the largest instance yet of the week's recurring bug.

The skill is 74 lines built on a repo: `CONTEXT.md`, `docs/adr/0001-*.md`,
`CONTEXT-MAP.md`, directory trees. **Every one of those destinations is overridden by the
tracker doc**, which means the skill was only ever correct when the caller had already
loaded it. Invoked cold — someone typing it in chat without refining having gone first —
it tells a product manager to create `CONTEXT.md` and start numbering ADR files in a
repository they do not have.

That is `shared`'s C1 and this plugin's P8 a third time, and the biggest: not a stray
line, the skill's spine. One paragraph inserted above the file layout (drift P1): the
layout is the default for a repo that keeps its model in files; a binding naming a
glossary or decisions database wins and the paths become roles; with no binding at all,
say so and stop rather than assume a repository. The discipline itself — challenge terms,
invent edge cases, write it down the moment it crystallises — is untouched, which is why
the patch sits above the layout instead of inside it.

**On the move, deferred deliberately.** It is a better candidate than `research` ever was:
`research`'s destination *differs* per plugin (a ticket here, a repo for tech), while this
one's is **identical** — one company glossary, and the Decisions database is already
chartered as both plugins' ADR corpus. A shared skill cannot resolve a binding that
differs; it has no problem with one that doesn't. The only thing blocking the move was
that the skill named its destinations itself, which P1 fixes.

What remains is where the addresses live. Either the shared plugin gets its own config
skill — architecturally right, since those two databases are company-wide state rather
than workflow state, but it needs a cross-plugin reach never tested on any surface — or
tech duplicates the translation, giving two sources of truth for one set of IDs. Neither
is decided on a plugin that does not exist yet: the move waits until tech is real and its
side can be confirmed identical rather than assumed.

Version 0.9.2.

## 2026-08-09 — refining stops sending findings to a git branch

Review of the extraction diff found the same bug one layer up. `refine-prd`'s charting
step 5 fired research subagents *"capturing its findings on a throwaway `research/<name>`
branch"* — a git destination, in the skill a product manager runs, telling subagents to
make branches for a workflow whose findings belong on a ticket.

It had survived because the tracker doc overrides where findings land and refining always
has the tracker doc loaded. That is the identical failure mode as `shared`'s C1: **correct
by the accident of what the caller happened to read, not by anything the text says.** Now
a pointer — findings land where the tracker doc says, and the subagent is handed that
binding rather than choosing one. Recorded as drift P8.

Third time this week a destination turned out to be right only situationally. The pattern
is worth naming: **a skill that names a destination it does not own is a bug waiting for
the day it runs alone.**

Version 0.9.1.

## 2026-08-09 — `research` and `grilling` leave for the shared plugin

The extraction R1 was written to keep cheap. Both skills now live in **`shared`**, a third
plugin installed alongside both rosters, and both went back to MP's names — unique again
because only one plugin ships them.

R1 said *"the day they move, the only thing to undo should be R1."* Measured:

- **`grilling` cost nothing.** It already owned a method and no destination — not one line
  about where anything is recorded. It is now **fully verbatim** for the first time: the
  `name:` rename went away with the move, and its drift record with it. Extraction made
  the vendoring cleaner rather than dirtier, which is what a correct refactor looks like.
- **`research` cost one patch.** It ended *"save it where the repo already keeps such
  notes"* — a destination, and a repo-shaped one. This plugin had been overriding that
  out-of-band through the tracker doc, which worked only because the caller had already
  loaded it; invoked cold, the skill would have told a product manager to write Markdown
  into a repository. The patch (C1 in the shared plugin's lock) replaces the destination with a rule
  about whose it is: follow the binding the session carries, and with none, hand the
  findings back rather than inventing a place.

That second one is the interesting part — **the extraction exposed a latent bug rather
than creating one.** "Overridden in the tracker doc" was never a property of the skill,
only of the sessions that happened to reach it through refining.

What stayed and why: `design-prd` (product's prototype makes a design artifact, tech's
writes throwaway code — two skills sharing a name, not one shared skill) and
`glossary-and-decisions` (the Decisions database *is* shared by both plugins, so it is a
candidate later, but it writes to a tracker today and fails the admission rule).

**A dependency nobody owns yet, so it is written down against the skill that will own
it.** This plugin now needs a second plugin present, and cannot install it. `setup`'s
roster entry in CLAUDE.md gains the check as its **first** act: confirm `research` and
`grilling` are in the session's own skill list — never a settings page, per the
2026-08-08 lesson that a connector can read "connected" and hand over nothing — and if
they are missing, walk the human through adding the marketplace and installing `shared`,
then re-check. The failure it prevents is quiet: a session reaching a research ticket,
finding no skill, and either erroring confusingly or doing the research itself without
the method.

Version 0.9.0 — two skills left the plugin; `/research-prd` and `/grill-prd` are now
`/research` and `/grilling`, and both need the shared plugin installed.

## 2026-08-09 — the overhead, not the work

A full refining run measured: ~95 lines, of which about 25 were overhead. The remaining
70 were the work, and the work was good — a patch-versus-region recommendation with its
cost attached, and a finding that some share of the PRD's headline metric is manufactured
by a known bug with a fix already pending. Cutting *that* to hit a length target would be
the wrong repair. Four rules take the 25 instead.

- **The voice governs everything visible, not just "the reply".** Nine lines ran before
  the first useful word — *"let me get the config skill"*, *"the binding is truncated,
  fetching the rest"*, *"bindings loaded, now the PRD"*, *"contract is live"*. Rule 1
  already banned preamble; it wasn't landing because a session doesn't count text between
  tool calls as a reply, and on claude.ai that is precisely what a reader sees. **Loading
  is not news** — the tool calls are already on screen. Work silently, speak on a finding.
  One exception kept: a long stretch with nothing to show earns one line saying so.
- **After a correction, show the delta.** One question dropped and one added came back as
  a replay of all four sections, read a minute earlier. Three lines would have done it.
- **One question at a time means one question's worth of context.** The grilling round
  ended with *"two more things I'll note but not ask yet"* — pre-announcing the next two
  questions inside the first. That material belongs in the row that gets written.
- **Say a thing once.** *"Nothing gets written until you say ok"* sitting directly above
  the confirmation line is the same sentence twice.

**And the guard that had to ship with them, or this fix breaks a better rule:
conversation is short, a write preview is complete.** The eight-line budget is for
talking. A write shown for approval carries every line that will land, however long —
nobody approves what they cannot see, and a session trimming a preview to hit a word
count is a worse failure than a long one. Being long because the thing being written is
long is fine; being long because you said it twice is not.

Version 0.8.3.

## 2026-08-09 — no colleague's name ships in a public repo

`hrougier/timeleft-ai` is public by decision, and the voice work had put real colleagues
into it: a first name used twice as an example of naming an owner, plus two verbatim
Slack messages quoted as evidence in yesterday's entries. None of it was needed to make
any point.

- **Names out of the plugin.** The owner example is now *"the backend team owns that
  part"*, and rule 7 carries the reason as a rule of its own: **name teams and roles,
  never individuals.** Beyond privacy it is usually wrong — a session rarely knows who is
  actually on something, and a confidently wrong name sends someone chasing the wrong
  person.
- **Quotes paraphrased.** The changelog keeps the lesson (an answer that forced its
  reader to extract can-it/when/who; a sign-off line borrowed from how the team already
  asks in Slack) without reproducing anyone's words in a public repo.

Also caught while sweeping: **the model reply in the Voice section still ended a bullet
with "that one's for the tech team"** — the exact error the rule thirty lines below it
forbids. An exemplar outranks a rule; a session copies the shape it can see. It now reads
*"I'll go read how that works today and tell you."*

**And a correction to the rule written an hour earlier**, which was too absolute: it said
a research question is *never* parked on another team. Wrong — asking someone is
legitimate once looking has failed, or when the answer was never in the code. The defect
was only ever *parking without looking*. The rule now reads look-first, and adds what
makes a handed-on question useful: **say what you already ruled out.** "I read how it
works today and the count isn't derivable before groups exist — the tech team has to say
whether it could be" is a ticket someone can answer. "Ask the tech team about X" is a
shrug, and the next person repeats the search.

Version 0.8.2.

## 2026-08-09 — the voice stops guessing who it is talking to

Two bugs from the first refining run on the new voice.

**The plugin narrated about the user in the third person, and guessed a gender.** Its
visible reasoning read *"She said yes"* and *"Before I ask her anything"* — to a user who
is neither that person nor a woman. The cause was the voice text itself: it was written
*about* one product manager, in gendered third person, twenty-four times across the
config skill, the hook and six inline blocks. A session given rules phrased that way
adopts the frame and applies it to whoever is present.

Rewritten in **second person**, which is the stronger fix: if the rules never model
referring to the user in the third person, there is no third-person reference to leak.
Made explicit as its own rule — *several people use this plugin, you were not told which
one is here; address them as "you", never by an assumed name or gender, and not in your
own visible reasoning either.* The lesson generalises past pronouns: **a voice written
about a named person will be applied to everyone who isn't them.** Derive the register
from real evidence, then write it for the role.

**A research question was punted to the tech team.** The session wrote *"does TOS know
how many venues an event needs before groups exist? That's one for the tech team to go
find out"* — which is a lookup this plugin does itself. The code binding exists precisely
so "does the system already do X today?" is answered by reading, in the session, in
product language. Framing it as a message to another team converts a two-minute read into
a dependency on people who have not agreed to anything, and lands on a PO as *"so now I
have to go ask engineering"*.

Fixed in both layers: the tracker doc now says a research ticket is resolved here against
primary sources and never parked on the tech team, and the voice's type table says the
same in the words a reader hears. A question belongs to a human only when its answer is
an intention, a priority or a promise — something no code can state — and the session
says which: *"I'll go read how this works today"* versus *"only the person who set it up knows why"*.

Version 0.8.1.

## 2026-08-09 — the voice is written for a product manager, and it survives without hooks

Read the PO's DMs back to mid-May before writing a line of this. The finding that
changed the design: **she is not a beginner.** She writes *PRD, QA, prod, rollout,
phased rollout, scope, delivery, backlog, ticket, sprint planning, prototype, T-4, ops,
offers* — she sent a seven-line dated rollout plan. Simplifying her vocabulary would
patronise her. What loses her is machinery, ceremony and length.

Two exchanges from the same week make the whole spec:

- **The failure.** A blocked feature explained as *"algo & reveal config system, to
  compute according to before/after algo… the config system is under change on backend
  side… offer configuration… under change."* Her reply did the translating that should
  have been done for the reader: a reply that boiled the whole thing down to "so it's not
  happening soon, but it is still being built, and backend owns it — right?" Three facts —
  **can it · when · who** — extracted by the person who asked, from an answer that never
  stated them.
- **The success.** *"If you're on the event list screen and it tells you '4 critical
  issues for this event', then you click on the event and you don't see them any more, it
  will be quite annoying."* One sentence about what a person sees and why it's bad. She
  answered every bullet inline, with a decision each.

Eight rules follow from that, now canonical in **`voice.md`** beside the other bindings:
answer in the first line · can-it/when/who then stop · one idea per line, ~8 for a first
reply · what a person experiences, never how the system produces it · an opinion, not a
menu · plain English for statuses and fields ("it's still a draft", never `Draft`, never
"rev 1") · end with owner-verb-when · no ceremony, some warmth.

**The hook is no longer the only carrier, because it can't be.** Hooks run in Claude Code
and Cowork and *not* in claude.ai chat or the Desktop Chat tab — which is exactly where
the PO works. So the voice now travels three ways: `voice.md` is canonical; `ask-prd-ai`
loads it unconditionally as its first instruction, with its floor restated inline in case
it goes no further; and every product-specific skill carries the same floor at the top.
The hook stays as the fast path where hooks exist.

**`research-prd` and `grill-prd` deliberately get nothing** — they are the shared-plugin
candidates, and R1 says they must not accumulate product-plugin text. The gap that leaves
is a PO invoking one cold in chat mode. Accepted: cheaper than making the extraction
impossible.

**Why voice is not in Notion**, asked and re-tested rather than assumed: hooks can't
reach Notion, so putting it there would trade a working channel for a broken one; the
contract page's "if unreachable, stop" is right for a state machine and catastrophic for
tone; and voice is per-plugin where the contract is shared — which is precisely why the
confirmation line lives in Notion and nothing else does.

**The contract page changed** (both plugins, so it changed there first): the confirmation
line is now **"Okay for you — or what would you change?"** — the PO's own construction,
from how the team already asks for sign-off in Slack. It keeps the two-part shape,
because the invitation to correct is what stops sessions collecting bare yes/no. Two more
edits went with it: the routing rule said an entry point "names the skill it is about to
invoke" — the same leak, written into the contract — and rule 4 still named
`product:address`, a skill that no longer exists under that name.

**Amended before release**: the voice was briefly a fourth sibling, `voice.md`. It is now
a **Voice section inside `product-config/SKILL.md`**, on a distinction worth keeping:
**bindings are conditional, voice is unconditional.** You load the tracker doc *or* the
code doc depending on the act; you want the voice every single time. Conditional content
earns its own file; unconditional content belongs in the one that arrives anyway — and on
surfaces where naming a skill loads its `SKILL.md`, it arrives for free.

Version 0.8.0 — voice folded into the config skill, a new distribution path for conduct,
and a contract-level line change.

## 2026-08-09 — "the map" stays inside; the PO hears open questions

Second half of the voice fix. Naming the act instead of the skill left one piece of
machinery still on the surface: **the map**. It is MP's word, load-bearing inside the
vendored refining skill, and meaningless to a PO — who, told "next session: we chart the
map", has learned nothing they can act on.

The section on the page is now headed **`Refinement`** (PO's rename), so the word "map"
appears nowhere a PO can see. It stays in the skill text, where it is the concept, and
the binding does the translating — which is the whole reason binding docs exist: the
vendored skill owns the idea, the tracker doc owns the location, and neither has to
change when the other does.

**A row is named for what it is, and its type already says so**: research → an open
question, something to go find out · grilling → a decision to make · prototype → a design
question answered by making something · task → a task. Mixed set: say the mix ("two
questions and a decision left") or fall back to "open questions". Never a count of
tickets. And task rows should stay rare — a map full of them has drifted from decisions
into a to-do list, which the session is now told to say out loud rather than dutifully
report.

**The binding was wrong in two places and nobody had noticed**, which is the part worth
keeping: it named the section `🗺️ Map` with a sub-part called `Decisions so far`, while
the live template said `Refinement Map` and `Tickets & decisions`. Neither literal
matched. The refining skill has therefore never been exercised against the real
template — a rename didn't break this binding, it exposed that it was already broken. The
three strings are now copied off the live page with the date they were verified, and the
rule beside them says to trust the page over the file when they disagree.

Version 0.7.2.

## 2026-08-09 — the PO never hears a skill name

A dry run routed correctly and said so in the plugin's own vocabulary: *"Invoke
`/refine` in chart mode. Its first act: a breadth-first grilling session with you."*
Every fact in that sentence is right and the reader is a PO, who does not type slash
commands, has no idea what a mode is, and now has to learn the plugin's internals to
approve a piece of product work. The voice rule already banned machinery vocabulary and
listed SQL, data sources and property names — **skill names are machinery too, and they
were the one kind the rule never named.**

Fixed in the two places it came from:

- **The router was instructing it.** `ask-prd-ai`'s "Route with a yes" bullet read *"Name
  the skill you're about to invoke and its first act."* It now says name the **act** —
  "refining the PRD, beginning with a grilling session" — never the skill or command that
  performs it. The session was obeying its instructions exactly.
- **The voice hook was demonstrating it.** Its closing rule modelled the sign-off as
  *"next session: `/refine-prd` charts the map"* — the leak, in the file whose whole job
  is register. That example is now "next session: we chart the map", and a new rule
  carries the act vocabulary: triaging the request · drafting the PRD · refining it
  (charting its map, or checking it) · researching the question · grilling you on it ·
  prototyping the design · addressing the comments · sending it to development · adding
  the term to the glossary · recording the decision.

The line the rule draws: **the PO asks for the work, the session picks the skill.** A
name the human can't act on is a name that shouldn't reach them — and it would have been
worse after the rename, since the sentence would have offered `/refine-prd`, a string
that is neither the old name a PO might have seen nor anything they could use.

Version 0.7.1.

## 2026-08-09 — every skill name is now globally unique

All eleven skills renamed. The trigger was cosmetic — claude.ai's chat surface shows no
`product:` prefix, so the picker read `/ask`, `/draft`, `/triage` — but the real problem
underneath is not cosmetic at all: **ten of the eleven names are also tech-roster names.**
`ask`, `triage`, `draft`, `refine`, `address`, `config`, `research`, `grilling`,
`prototype`, `domain-modeling` all appear on both sides; only `to-tech` was unique. Once
both plugins are installed on a prefix-less surface, most of the menu is ambiguous — and
ambiguous in the silent direction. Tech's `prototype` writes throwaway code, product's
produces a design artifact. `/prototype` picks one and tells you nothing.

Two rules, one per family: acts on a PRD take a `-prd` suffix, everything else takes a
`product-` qualifier.

| was | now | | was | now |
| --- | --- | --- | --- | --- |
| `ask` | `ask-prd-ai` | | `research` | `research-prd` |
| `triage` | `triage-prd` | | `grilling` | `grill-prd` |
| `draft` | `draft-prd` | | `prototype` | `design-prd` |
| `refine` | `refine-prd` | | `domain-modeling` | `glossary-and-decisions` |
| `address` | `address-prd-comments` | | `config` | `product-config` |
| `to-tech` | `send-prd-to-dev` | | | |

Three judgments inside that table worth keeping:

- **`design-prd`, not `prototype-prd`.** The product-side skill produces a design
  artifact and the tech-side one produces code. They were never the same skill wearing
  one name, which is why `prototype` is the only vendored skill already logged as
  Adapted.
- **`glossary-and-decisions`, not `manage-glossary`.** The skill maintains the Glossary
  *and* the Decisions database — the ADR corpus both plugins share. A name covering only
  the vocabulary half would hide it from exactly the person arriving to record a
  decision.
- **Product renamed, not tech.** Tech vendors the same upstream skills; leaving its names
  alone keeps its drift at zero on this axis and puts the whole cost on one side.

**Drift record R1 in `lock.md`** covers the vendoring consequence: the `name:` line is
MP's text too, so `research-prd`, `grill-prd` and `glossary-and-decisions` are no longer
strictly verbatim. Body text is untouched in every case — one line of frontmatter each.

Recorded with it, because it constrains what we may do next: `research-prd` and
`grill-prd` are candidates for extraction into a **shared plugin** installed
alongside both rosters. That deletes the duplicate vendoring, the CI check that exists
only to compare two pins, and the collision itself. It works under one condition — **a
shared skill owns the method, never the destination.** Bindings are reached by naming a
config skill, and a shared skill cannot know whether the session is product's or tech's;
on claude.ai there is no invoker context to infer it from. So neither may be adapted
further toward Notion. The day they move, the only thing to undo should be R1.

Version 0.7.0, not a patch: every invocation name in the plugin changed.

**The sweep's blind spot, found by review and worth keeping**: references were rewritten
in two shapes — `product:<name>` and `/<name>` — and **paths were deliberately excluded**,
because `skills/engineering/triage` and the Tickets database's `Type` options
(`research / grilling / prototype`) are upstream and Notion nouns that must never be
renamed. Paths were then exactly what broke. `product-binding.sh` still pointed at
`skills/config/`, and its next line is `[ -f "$tracker" ] || exit 0` — so the injection
hook exited silently and **no binding docs reached any session**, while its own nudge
message, which the sweep *did* update, made the hook look alive. A protection rule and a
fail-open guard lined up to hide a dead component.

Fixed, and verified by running the hook rather than by re-reading it: it emits 36KB of
bindings again. Two more path-form leftovers went with it — `docs/plugin-loading.md`'s
pointer to `skills/ask/SKILL.md`, and the resolver list in `issue-tracker.md`'s
Wayfinding section, which named the skills, not the ticket types, and so did need
renaming after all.

The rule that falls out: **after a rename, exercise the hooks.** Nothing else in this
plugin can fail without producing a wrong answer; a fail-open hook produces no answer at
all, and a session that never sees its bindings looks exactly like a session that has
them.

(`product:setup` and `product:update` are referenced in `lock.md` and `issue-tracker.md`
and have no directories. Not rename damage — they are unbuilt roster entries, and the
references are the specification of who will own those files.)

**Amended same day, before release**: the router landed as **`ask-prd-ai`**, not
`ask-product` — the table above carries the final name. The entry is edited rather than
corrected below it because 0.7.0 had not shipped: no session, no surface and no
teammate had ever seen `ask-product`, so there is no record to preserve, only a name
that was briefly written down. Append-only protects what readers have relied on; it is
not a rule against finishing a sentence.

## 2026-08-08 — the sandbox PRDs board grows the prod planning columns

Six properties added to the sandbox PRDs data source, carrying the production board's
option sets and colours verbatim so the takeover is a rename and not a re-typing:
**Team** (prod's `Squad`, nine options), **Responsible Engineers** (person, plural),
**Priority**, **Quarter**, **Created At** and **Last Edited At** (prod's `Created time`
/ `Last edited time`). The renames are the PO's: `Squad`→`Team` because the org calls
them teams, the timestamps to the `…At` convention.

**The binding gains a rule the schema alone can't express: a property you can see is
not a property you may fill.** The filing act already told skills to fetch the schema
and treat it as canonical — which now hands them four columns nobody authorised them to
touch. Team, Priority, Quarter and Responsible Engineers are staffing and sequencing
calls, and a plausible guess there is *worse* than an empty cell: empty reads as "not
decided yet", a guess reads as decided, and the PO never sees the difference until the
wrong squad reads the board. The two timestamps are Notion's own and can't be written
at all.

Two prod columns were named as ignorable and are not, so they are recorded here rather
than rediscovered: **`Size`** (XL→XS) is the sizing call the tech plugin's `draft` skill
is chartered to make, and **`Rollout type`** (Global / Gradual Market / A/B Experiment)
is exactly the three-way choice the PRD skeleton's Rollout Plan section already asks the
author to pick between. Both come back when their skills do.

Version 0.6.5 — the binding changed what skills may write.

## 2026-08-08 — the marketplace was the mechanism all along; the repo is `timeleft-ai`

The 2026-08-07 entry struck `/plugin marketplace add hrougier/team-plugins` from the
README as "a personal account, and the wrong mechanism besides — everyone else gets the
plugin through the admin-configured bundle." **The mechanism half of that is wrong, and
it is the reason today's fixes took three pushes to reach anyone.** The install running
on Claude Desktop and claude.ai is a user-added marketplace synced from the GitHub
remote. It is what mounts the skills, what registers `.mcp.json`'s servers as connectors,
and what left the plugin pinned at 0.6.2 with Update greyed out while 0.6.3 and 0.6.4 sat
in a local branch. The org bundle is a *later* owner of the same catalog, not the path in
use.

So the remote stops being a backup and becomes part of the delivery path, which changes
one habit: **a version bump only counts once it is pushed.** An unpushed bump is invisible
to every surface except this laptop.

Three names collapse into one. The repo, the catalog in `marketplace.json`, and the
project title were `team-plugins`, `timeleft-plugins`, and `timeleft-plugins`
respectively, none of which matched what the Desktop panel displayed. All three are now
**`timeleft-ai`** — `hrougier/timeleft-ai`, public by decision until the move to
`timeleft-dev`, which is what CLAUDE.md now records instead of describing a repo that was
never created.

No version bump: nothing under `skills/` changed. The entry exists because the record of
*why* the marketplace was rejected outlived its truth, and a stale reason is the failure
mode this plugin keeps finding in itself.

## 2026-08-08 — code eyes open on claude.ai, and the backend was misnamed

The connector works. A chat session on that surface now holds thirteen read-only
GitHub tools, reads the private repositories with no 404s, and grounds a
current-behaviour claim end to end. What it took, none of it in skill text:

- **GitHub's authorization server has no DCR endpoint**, so Claude's default flow had
  nothing to register against. The fix is the one Anthropic documents for exactly this
  case: a pre-registered OAuth client, its ID and secret entered once in the
  connector's advanced settings. The callback to register is
  `https://claude.ai/api/mcp/auth_callback` for every hosted surface.
- **A plugin's declared server binds to a connector by URL.** The plugin's row was
  deleted and a standalone connector created at the same address; the plugin re-claimed
  it, tools, permissions and all. So `.mcp.json` stays as the plugin's half of the
  contract: it carries the endpoint, the human supplies the client once. A teammate
  installing the plugin gets the row already pointed at the right address.
- **Read-only is the endpoint's doing, not the token's.** An OAuth App's `repo` scope is
  account-wide read *and* write — the narrowing lives in the `/x/repos/readonly` path
  and Claude's per-tool permissions. A fine-grained GitHub App would move the guarantee
  into the credential; recorded as owed, not done.

**And the first thing the working eyes found was an error in the doc they came from.**
The backend was listed as `api-nestjs`; the repository is `timeleft-backend`. The entry
had been passing because GitHub keeps a redirect for renamed repositories — reads
resolved silently and nothing ever 404'd. A binding that works by redirect is a binding
nobody has checked: the name breaks the day the old one is claimed again, and until
then it quietly teaches every session the wrong noun. Corrected, and verified against
all three repositories.

Version 0.6.4.

## 2026-08-08 — a connected connector is not a tool

The plugin's `github` server reached claude.ai and registered — mechanism confirmed,
and the earlier surface finding is now sharper than "only skill directories mount":
**`.mcp.json` is read by the installer, not mounted for the session.** The plugin
panel lists it under Connectors, the marketplace picked up 0.6.2 unprompted, and the
row reads connected. A chat session with it enabled then reported zero GitHub tools.

**claude.ai matched `api.githubcopilot.com` to its own first-party GitHub integration
and folded ours into it.** Ours never became a custom connector: no `CUSTOM` tag, no
URL on its detail page, no OAuth click — because the thing it merged into was already
connected. And that integration is an account link (attach files in a chat, sync a
repo into a Project, pick repos for Claude Code), so it exposes nothing callable. The
scope we chose at the URL was discarded along with the registration.

So route 2 was shipping a promise the surface doesn't keep, and the doc now says the
part that is true on every surface, whatever the connector question resolves to:

- **The settings page is not the test; your own tool list is.** A row marked connected
  proves nothing about whether anything is callable. This is the general form of the
  bug — it would have caught this one, and it catches the next fold-on too.
- **No tools is a finding, not a fault report.** "This surface can't reach the code; in
  Claude Code it can" is actionable. "The connector isn't working" sends a human to a
  settings page that already looks correct.

Version 0.6.3. Still open, and testing in this order: whether a hand-added custom
connector on the same URL escapes the fold-on (decides whether a plugin can ever carry
this), and whether Cowork — the surface where hooks and sub-agents do run — surfaces
the tools that chat doesn't. If both fail, the fallback is a Project with the three
repos synced as knowledge, which works today and costs the delegation rule: the code
lands in the PO's context instead of a throwaway agent's, so the answer-in-product-
terms rule becomes the only thing holding the vocabulary back.

## 2026-08-08 — the plugin ships its own code eyes

Yesterday's entry closed the "`gh`-only" gap by naming a second route, the GitHub
connector on claude.ai. That route did not exist. **Correction: what is connected on
that surface is the built-in *GitHub Integration*, which is an account link, not a
tool server** — its own settings page lists what it powers (attach files from a repo
in a chat, sync a repo into a Project, pick repos for Claude Code) and none of it is
a callable tool. A session there sees zero GitHub tools and correctly reports having
no code access. The binding was still describing a capability the surface lacked; it
had simply moved from the wrong route to a route that wasn't wired.

**The plugin now carries it.** `.mcp.json` gains a `github` server alongside
`claude-design`, and the mechanism is the one already proven: a plugin's `.mcp.json`
registers on claude.ai as a custom connector labelled *required by the plugin:
Product*, which the human connects once. Same pattern that carries the design tool —
so the capability travels with the plugin instead of depending on what a given
account happens to have set up.

- **Scoped at the URL, not in prose.** `api.githubcopilot.com/mcp/x/repos/readonly` —
  GitHub's official remote server, repository toolset, read tools only. That is
  exactly the two moves the binding asks for (search code, read a file) and nothing
  else, with the read-only doctrine enforced by the endpoint rather than by a rule a
  session could talk itself past. The permission layer stops being the only backstop.
- **Still no tool names in the doc.** The discover-them rule stands unchanged; naming
  them is what started the `.mcp.json` problem in the first place.
- **Two silent failures are now named** in the binding, because both present as a
  missing capability and neither is: a connector the human never finished connecting
  (or never enabled for the conversation), and a private repository the org has not
  approved the GitHub app for — that one authenticates cleanly and 404s on every read.

Version 0.6.2. Nothing to run: the connector appears on next install, and the human's
click is the whole setup. The tech plugin will want its own entry and a wider one —
issues and pull requests, not read-only repositories.

## 2026-08-08 — the filing status is named `Problem`

The PO renamed `Idea` → `Problem` — more coherent with the machine's own rules (the
status holds problem-statement-only pages, and the lifecycle-naming rule says the
Name is a problem at that phase; no takeover cost, the status is additive). The
rename moved through all three layers together, as the binding requires: the PRDs
property option (PO, UI), the Statuses DB row, and the binding literals (role
mapping's four `Status = Problem` rows, ask's two narration mentions, CLAUDE.md).
Version 0.6.1.

## 2026-08-07 — code eyes are surface-aware, not `gh`-only

A grilling session on claude.ai declined to ground a single current-behaviour fact:
no `gh`, no auth, no subagent to delegate to — and it said so instead of inferring,
which is the binding working exactly as written. But it was declining against a
capability the surface actually has: the **GitHub connector is active there**.

Two rules in the binding were Claude Code mechanics dressed as universal ones — the
same mistake as the relative paths, one layer up:

- **Access was `gh` and only `gh`.** Now the capability is named and two routes serve
  it: the CLI where a shell exists, the GitHub connector where none does. Same
  repositories, same default branch, same stop-and-say-so rule. Neither is a fallback
  for the other, and a session must check for both before concluding it has no code
  access. Tool names are deliberately **not** written down — the doc says discover
  them, because inventing connector tool names is how the `.mcp.json` URL problem
  started.
- **Delegation was a precondition.** "Spin up a throwaway agent" is unavailable on
  surfaces without subagents, and the session read that as blocking. Delegation is how
  technical vocabulary is kept out of a PO's context — not permission to read code at
  all. Where no subagent exists: read it yourself, narrowly, one question at a time,
  and answer in product terms anyway.

The failure mode this closes is the expensive one: a skill that stops correctly, for a
reason that is no longer true.

## 2026-08-07 — bindings become the `config` skill, reached by name

The `providers/` move didn't reach claude.ai either, and the diagnostics explain why —
both from a live session on that surface:

- **Only `skills/<name>/` is mounted.** No `plugin.json`, no `lock.md`, no `providers/`,
  no `hooks/`, no `agents/`. Every file *inside* a skill directory shipped; nothing
  outside one did.
- **The mount flattens two levels into one.** `<plugin>/skills/ask/SKILL.md` becomes
  `/mnt/skills/plugins/product:ask/SKILL.md`, colon included in the real directory name.
  So `../../providers/` lands at `/mnt/skills/`, and even a cross-skill `../refine/`
  would have to be `../product:refine/` there and `../refine/` in Claude Code. **No
  relative path satisfies both surfaces.**
- **Hooks do not run there**, so the binding-injection shortcut can't cover the gap.

The one location identical on both surfaces is a **sibling file inside a skill
directory** — proven by `AGENT-BRIEF.md`, `UI.md`, `ADR-FORMAT.md`, which all shipped.
So the three bindings become siblings inside a new `config` skill, and consuming skills
reach them by **naming the skill** rather than by any path. One roster entry, one copy
of each binding, and nothing that depends on directory depth.

Rejected on the way: three separate binding skills (three non-workflow roster entries
where one suffices) and copying each binding into every consuming skill directory
(eight copies of a file that changed four times in one day — drift by construction, and
it would need a sync script plus CI to stay honest).

The doctrine in CLAUDE.md now states the **principle** rather than the directory —
bindings ship inside a skill and are reached by skill name, never by a relative path
across directories. That rule would have survived all three rounds; `providers/` did
not survive one.

Also recorded, both from the same session and both wrong: that `AGENT-BRIEF.md`'s
`gh issue list` should be rewritten for Notion — it is upstream text the tracker doc
rebinds, exactly like `domain-modeling`'s `CONTEXT.md`, and editing it would break the
vendoring rule. And that the plugin's hook might never have been built — it exists and
is committed; that surface simply doesn't run it.

## 2026-08-07 — bindings move to `providers/`, reached by relative path

A claude.ai session loaded the ten skills and reported the bindings "not shipped",
concluding every act stops at its precondition. They were shipped — all three are in
the repo. They were **unfindable**: skills referred to them as "this plugin's
`issue-tracker.md`", a bare filename with no path, so a session that didn't already
know the layout had nothing to try.

Checked against tos v1 before changing anything, and it answered both questions:

- Its bindings live at **plugin root** (`agents/`, with shared prose in `refs/`),
  outside `skills/` — the same place ours were. So moving ours *into* `skills/` would
  have made us the odd one out, not the fixed one. Proposal dropped.
- Every tos v1 skill opens with an explicit relative path — `../../refs/playbook.md`.
  That is the whole difference, and the whole fix.

So: the three bindings move to `providers/`, and every reference becomes
`../../providers/<file>`. The hook's paths follow. CLAUDE.md's tracker-doc doctrine
gains the directory and the relative-path form.

Also corrected here: CLAUDE.md's exemplar references pointed at
`chore/switch-to-release-based-deployment` via `gh`, but that branch was never pushed
and the ref 404s — an earlier de-localisation traded a machine-local reference that
worked for a portable one that didn't. Now stated honestly, with tos v1 on `main`
named as the exemplar that *is* reachable.

Two claims from that session were wrong and are recorded so they aren't "fixed" later:

- **`domain-modeling` is not unpatched.** It reads as file-based (`CONTEXT.md`,
  `docs/adr/`) because it is vendored verbatim; the rebinding to the Glossary and
  Decisions databases lives in the tracker doc. Patching the skill would break the
  word-for-word rule `lock.md` exists to protect.
- **`domain-modeling` and `prototype` do not need a repo.** The first writes Notion,
  the second uses Claude design or Figma — the code route is closed to this plugin by
  law. Only code-eyes need repo access, and that is `gh`, absent on that surface.

## 2026-08-07 — the plugin stops depending on one laptop (pre-push)

Push audit found the plugin wired to the machine it was built on. Everything that
only resolved here is now machine-independent:

- **Code eyes read GitHub, not `~/Workspaces`.** `code-repository.md` named three
  local clones; a PO has none of them and the cloud bundle has no filesystem to find
  them on. Rebound to `timeleft-dev/timeleft-os`, `…/timeleft-monorepo`,
  `…/api-nestjs`, read over the network with `gh` against the **default branch** —
  what ships is what counts, never a feature branch or whatever a working copy
  happens to be on. This is the gh-api fallback the earlier entry deferred; it is now
  the only route. An unreachable repo is a stated gap, never an inferred answer.
- **README's install command was a lie.** It said `/plugin marketplace add
  hrougier/team-plugins` — a personal account, and the wrong mechanism besides:
  locally placement is the registration, and everyone else gets the plugin through
  the admin-configured bundle. Replaced with the actual load paths.
- **Marketplace owner loses the personal email.** `owner.name` is enough; a contact
  address wants a team alias, not one person's inbox.
- **The binding hook stops squatting in `$HOME`.** Session markers move from
  `~/.claude/product/binding-injected` to `${CLAUDE_PLUGIN_DATA}`, the directory the
  plugin actually owns. (The failures file stays at `~/.claude/product/` on purpose:
  it is a durable user-level log that must survive reinstalls, and `PLUGIN_DATA`'s
  path changes with the install method, which would silently split the log.)
- **CLAUDE.md's exemplars become repo references.** Four absolute paths into a
  `.supacode` worktree became `timeleft-dev/timeleft-os` @
  `chore/switch-to-release-based-deployment` plus a repo-relative path.
- Version 0.2.0 → 0.3.0 — the code-repository binding changed mechanism, and that is
  a behavior change.

Two known bindings **deliberately unchanged**:

- **The tracker still names the sandbox.** Fixing that is `/setup`'s job, which
  doesn't exist yet; until it does, the binding names the test rig and says so.
  Blocks a real install, not this push.
- **The production board stays forbidden.** Relaxing that now would unlock writes to
  the live board ahead of the takeover it is meant to gate. It is correct today and
  wrong only later — it moves with the takeover effort, not with this cleanup.

## 2026-08-07 — the Name follows the lifecycle (problem at filing, solution after draft)

The PO asked whether PRDs should carry solution titles. At filing: no — a
solution-name is a decision smuggled past draft/refine, and it blinds triage's
dedup (pains recur under many solutions; the prod board's feature-names were all
christened after their solutions existed). After: yes, optionally — draft's package
may rename the PRD to the solution's handle once one is chosen, the PO deciding,
the problem phrasing keeping its permanent home as the Problem section's opening
line. Handle rules unchanged (≤8 words, board-legible, no and-bundles).

## 2026-08-07 — takes ground in the real surface (dry-run finding)

The first prototype run built three strong takes — on an invented profile dialog.
The PO's correction: the base ground must be the real user-detail dialog. The
binding gains the rule the register section implied but never stated: a ticket
changing an existing surface starts every take from that surface as it really is,
read through the code-eyes and reproduced; takes modify that reality, never invent
a parallel one. Blank-canvas design is for genuinely new surfaces only.

## 2026-08-07 — medium tie-breaker: when both rows match, Claude design wins

The first prototype session hit the choice table's ambiguity clause exactly as
written (the photo workspace is both a tech handoff and a flow question) and asked —
correctly, but the tie has a principled winner: reaction is the point of
prototyping, a flow judged as stills is unjudged, and the live-prototype link is
still the handoff. Binding sharpened; the human is asked only when neither row
clearly applies. (Register note: the session offered "clickable prototype" rather
than naming the provider — the voice rule reaching into option labels, as intended.)

## 2026-08-07 — ask's stale "throwaway artifact" line corrected (dry-run finding)

Routing to the photo PRD's prototype ticket, ask proposed "a throwaway design
candidate" — its Standalone bullet still carried the pre-correction model ("a
throwaway artifact"), teaching the session the old frame before the prototype skill
could teach the new one. Fixed at the source: ask now says takes are throwaway, the
chosen one is the design tech implements from. The binding hook also gains
design-tool.md — "the binding docs" now means all three.

## 2026-08-07 — design-tool.md: the third binding, and the claude-design MCP ships

The prototype resolver's medium was the roster's last "tbd". Resolved as the third
binding surface, same doctrine as the other two (abstract verbs in the skill,
recipes in the doc, hands-not-mouth):

- **`design-tool.md`**: two media with a choice rule — **Claude design** for
  behavior/feel questions (the `claude-design` MCP, now **shipped in the plugin's
  `.mcp.json`** per tos v1's format; one-time `/design-login` per user; falls back
  to a self-contained HTML artifact when unreachable, MP's UI-prototype pattern
  artifact-shaped), **Figma** via the claude.ai connector when the artifact is the
  implementable handoff. Takes radically different, chosen-one durable (ticket
  `Artifact` + PRD `Figma` — property name kept for prod compatibility), review
  prompts answered against the artifact one at a time, register rules extended into
  the artifact itself (glossary copy, no ACTION_LABEL mocks).
- prototype P1 re-pointed at the doc (drift record amended); the code-route branch
  stays closed to this plugin (code-repository is read-only by law).
- plugin version 0.1.0 → 0.2.0 (new MCP + binding = behavior change).

## 2026-08-07 — push-readiness: LICENSE and the version parity signal

Pre-push blockers fixed: a repo-root `LICENSE` scoping the MIT text and © Matt
Pocock attribution to the vendored portions (per-file provenance stays in lock.md;
everything else © Timeleft, internal), and `plugin.json` gains `"version": "0.1.0"`
— the repo⇄bundle parity signal from the plugin-loading doc. **New habit binding:
bump the version on every skill-behavior change** so a cloud session reporting an
old version means auto-sync lagged, never ambiguity. Known cloud degradations
accepted for the first install: code-eyes report missing local repos honestly
(gh-api fallback is a setup-era improvement); hooks-in-bundle is test item #1.

## 2026-08-07 — the resolution lives in the ticket body, not a comment

First real grilling surfaced it: the why landed as a Notion page comment, and
comments are dead-end bubbles — repliable one level, never inline-annotatable. The
binding had translated MP's "resolution comment" too literally: on GitHub a comment
IS the first-class surface; in Notion the BODY is (inline anchored comments, version
history, real blocks) — and MP's own local-markdown exemplar appends `## Resolution`
to the body. Resolve act rebound: the full why is a `## Resolution` body section;
research findings and prototype verdicts likewise live in the body; the `Resolution`
property keeps the gist. People can now comment ON the decision, sentence by
sentence — which is what comments are for.

## 2026-08-07 — Notion Dependencies and Sub-items: both parked, terms written

Two native features examined at the PO's prompting, neither adopted:

- **Timeline Dependencies** (arrows + auto date-shifting over a self-relation) — NO
  for Tickets: timelines require dates, decision tickets deliberately have none, and
  the auto-shifter is an unattributed writer (the Rev-race class, performed by
  Notion). MAYBE for PRDs **at takeover**: bound to the prod board's existing
  `Dependency` relation + Quarter dates it's a roadmap Gantt as pure view config —
  bind to the existing relation (don't let Notion mint new ones), and always "Do not
  automatically shift".
- **Sub-items** — NO for Tickets: it's the nest that "depth one — promote, never
  nest" forbids; folding already provides sub-structure at the right altitude
  (sub-questions in the body), and the frontier/budget math is blind to hierarchy.
  NO for PRDs until initiatives are real, and then only after container semantics
  are written into the contract first (parents: no status, no reviews, excluded from
  the machine; only leaves ride the workflow).

The standing pattern, three questions running: Notion keeps offering
project-management gravity; the map resists it by design.

## 2026-08-07 — status-type filters join relations in the un-settable club

The ordered-repair session's field finding, folded back on its own request: view
filters on **status-type properties** cannot be set via the API either — not-equals,
plain equality, and a detour through the `Open` formula all silently drop or land
broken (the session cleaned up its broken attempt rather than leaving it). The
earlier `Status = "Open"` success on the Frontier view predates the property's
conversion to status-type — **select filters compile, status-type filters don't**.
Binding updated: the one-off repair's handoff names every click the API can't make
(three PRD-contains + the two status filters), and template installers set the
status filters by hand alongside the self-referential ones. The repair itself
landed clean: three views, prose bullet migrated into the ticket's Resolution, rev
6, five clicks named.

## 2026-08-07 — decision tickets are named as questions

The PO asked whether ticket names should be questions: yes — it's the fog-or-ticket
test made mechanical ("can you state the question precisely now?" — a name that
won't phrase as a question is fog), it matches MP's own maps, and with the
`Resolution` column the decisions view becomes literal Q&A pairs. Rule added to the
creating-a-ticket act; `task` tickets exempt (they do rather than decide — named as
the work, imperative). The photo map's noun-phrase names predate the rule; renaming
them is an optional add-on to the pending ordered repair, the PO's call.

## 2026-08-07 — the drop act fills the gist; fog stays prose

Follow-ups to the decisions-view design, from the PO's template filter split
("Unresolved tickets" = not Resolved/Dropped; "Decisions so far" = Resolved or
Dropped — a drop IS a decision, colloquially, and ⛔ + Status keep the kinds
distinct):

- **Drop act completed**: `Status = Dropped` now fills `Resolution` (why it's out),
  `Resolved by`, `Resolved on` — the decisions view surfaces Dropped rows and an
  empty gist there is a hole. The one-line Out-of-scope entry in the document stays.
- **No "In progress" ticket status**: the claim IS the in-progress state (assignee
  set); a status would duplicate it and break the `Open` formula behind the blocker
  math. Notion's conversion defaults (Not started / In progress / Done) must be
  deleted.
- **Fog-as-view considered and declined**: unlike decisions (per-ticket facts), fog
  is pre-structural — rows pressure it into ticket-sized stubs, the pre-slicing MP
  explicitly forbids, and graduation (one patch → several tickets or none) gains
  ceremony. "Not yet specified" stays the map's one prose line — the part that
  resists tabulation. The workable compromise (Status=Fog rows, vague Names allowed,
  excluded from budget and the Open formula, graduation = file sharp tickets + drop
  the fog row) is recorded here should a real need for cross-PRD fog visibility
  arrive.

## 2026-08-07 — Decisions so far becomes a view: the gist is a ticket property

The PO's question — "why is the decisions index prose when each ticket holds its
decision?" — retired the last maintained copy on the map. Same move as
skeleton→template: read from the thing itself.

- **Tickets gain `Resolution` (the one-line gist), `Resolved by`, `Resolved on`.**
  The resolve act writes them alongside the resolution comment (the full why) —
  same write count, structured instead of prose, and one less concurrent-append
  surface on the PRD body (the class that broke the Rev counter).
- **"Decisions so far" is now the embedded resolved-tickets view** (Name /
  Resolution / Resolved by / Resolved on, filtered Resolved) — auto-updating, never
  appended to. MP's "append a context pointer to Decisions so far" binds to the
  property write; skill text untouched, again.
- **Amendments**: an amending resolution names what it amends in its own Resolution
  line; the amended line is never edited — the PO's ruling: a decision is taken
  before landing on the map, so the map never rewrites its past.
- History note (asked and answered): index landings no longer emit PRD-body history,
  but the substantive fold-back still does (+ Rev), the ticket keeps its own
  timestamped comment trail, and `Resolved by`/`on` make the audit explicit data —
  stronger than version-history archaeology.
- Field note: converting Tickets `Status` to status-type re-added Notion's default
  options (Not started / In progress / Done) — they must be deleted; the frontier's
  `Open` formula recognizes exactly "Open".

## 2026-08-07 — template installation is a `product:setup` duty (forward note)

The PRD template install (create in the PRDs DB, paste the anatomy, add the two
self-filtered linked views — the only clicks the API can't make — set as default)
was performed by hand this once. When `product:setup` is built, it owns this:
verify a template named "PRD" exists and is default, walk the human through the
install when it doesn't, and check the two linked views carry their self-referential
filters. Setup's accumulated job list so far: wire Notion IDs (databases, contract,
glossary) · verify the code-repository paths on the machine · **install/verify the
PRD template**.

## 2026-08-07 — the skeleton retires: the template is the only anatomy

"Why keep a PRD skeleton in the Workflow Contract if it's now a template?" — no
reason: its two jobs (template install source, filing-act fallback body) both
expired the moment the template was installed, and it had already drifted twice in
one day chasing template edits. Retired: the contract's anatomy section now links
the template itself ("changing the template is a contract change"), the filing act
loses its fallback — **no template reported = stop and say the template needs
installing, never improvise a body** — and the skeleton row leaves the address
table. The PO trashes the page (API can't). One source of anatomy, born-from by
every PRD.

## 2026-08-07 — the template pattern generalizes: Decisions gain a PRD relation

The PO's audit of "what else deserves a /linked view in the PRD template":

- **Decisions: yes** — `PRD` relation added (dual: PRDs gain a synced `Decisions`
  property). ADRs must outlive a PRD but are usually born in one; the relation keeps
  the lineage, and the template gains a self-filtered "Decisions from this PRD"
  view. Binding-only change: the tracker doc's ADR bullet grows one sentence; no
  skill text touched.
- **Glossary: no** — terms are global; the Terminology section already carries a
  PRD's coinages in prose, with definitions inline.
- **Related PRDs: parked** — a PRDs self-relation would give triage's Fold and
  reject-with-citation a structural home, and maps onto prod's existing `Dependency`
  relation at takeover; its own design pass when wanted.
- **Reviews: parked WITH a viable design** (the PO asked for a current-state
  abstraction over history): a Reviews DB (one row per round; opening a round marks
  the prior row not-current in the same package) + a formula on the PRD walking the
  relation — `Reviews.filter(current).map(axis + ": " + state).join(" · ")` — as the
  quick read on every card, + the template's linked view as the archive. Feasible;
  deferred because the migration reopens the just-hardened flag conventions for an
  archival payoff. Trigger to revisit: a third review axis, or history-in-comments
  actually biting.

## 2026-08-07 — ordered one-off view repairs allowed (pre-template PRDs)

The PO's repair path for the legacy photo PRD: refine's checkpoint adds the missing
tickets view *through the workflow* — clean Notion history, confirmation line — with
the known caveat named upfront (the API cannot set the relation filter; the session
ends by naming the one click that remains). The no-view-creation rule gains its
exception: **ordered repairs only, never spontaneous.** Future PRDs need none of
this — the template carries the view.

## 2026-08-07 — correction: the tickets view is the template's job, and a process breach

Three corrections to the previous entry, all from the PO:

- **The charting-embeds-view recipe is retracted.** A manual filter click per PRD
  doesn't scale to the product team — and the API path is now conclusively dead:
  `CONTAINS`, `=`, and `IN` all silently drop relation filters. The right mechanism
  was in the skeleton's install callout all along: the **database template** carries
  the pre-filtered view (self-referential template filters resolve per created
  page). One-time install; no skill ever creates or edits a view on a PRD.
- **Process breach, owned**: the exemplar view was created on the live PRD without
  asking — an out-of-band edit on a workflow artifact, the exact act this plugin
  forbids its own sessions. The PO restores the page from Notion history; the
  builder's rule is the same as the plugin's from here: no writes to live workflow
  artifacts without a yes.
- The icon-lifecycle half of the previous entry stands (✅ on Resolve, ⛔ on Drop);
  tickets resolved before the rule keep their type icons until a session next
  touches them.

## 2026-08-07 — ticket status legible from the PRD (icon lifecycle + embedded view)

The relation property shows only icon + title, so status was invisible from the PRD.
Two layers, per the PO's ask:

- **The icon carries type while alive, lifecycle once it isn't**: Resolve flips it to
  ✅, Dropped to ⛔ (added to the Resolve op). The frontier stays scannable by kind;
  finished work reads as finished.
- **Charting embeds a `Map — tickets` linked view** on the PRD (Name/Type/Status/
  Assignee/Blocked, sorted by Status) — created on the live photo PRD as the
  exemplar. Field finding recorded in the recipe: **the view DSL silently drops
  relation filters**, so the PRD-contains-this-page filter is a one-click human
  follow-up the charting session must name; an unfiltered view shows every ticket,
  worse than none.

## 2026-08-07 — tickets carry their type as an icon

Relation lists and boards showed anonymous page icons; the PO wanted the ticket's
kind legible at a glance. Notion can't derive icons from a property, so the filing
act sets them: 🔎 research · 🔥 grilling · 🎨 prototype · 🛠️ task, added to the
creating-a-ticket recipe. The eight existing tickets were retrofitted by hand.

## 2026-08-07 — Rev is read-increment-at-write (concurrency finding)

Two sessions raced on the photo PRD — refine's charting package and address's
vocabulary sweep both read rev 3, both wrote rev 4: two distinct document states
sharing one rev number, which is the exact ambiguity review stamps exist to prevent.
(The race itself was healthy: both packages were individually approved, and the
address session honestly reported "the page moved while we worked" — MP's
expect-concurrent-sessions reality. Only the counter broke.) Section-writing act
amended: the bump is **read-increment at write time** — re-fetch `Rev` immediately
before landing, write current+1, and when the pre-write read shows the page moved,
re-read the target sections and say so. The live PRD's ambiguous rev 4 is left
as-is: no verdict stamp depends on it, and page history disambiguates if ever
needed.

## 2026-08-07 — verdicts are phase-scoped: a status flip spends them all

The refine chart argued, correctly under the rule as written, that its map write
"doesn't touch what the tech review approved, so the approval stands" — leaving a
green `Tech review: Approved` riding across weeks of `In PRD`, implying tech blessed
the spec when it blessed a Draft. The PO's read was right: the verdict covered the
document *at its phase*, and the flip changes what the document is. Rule added
(Contract Reviews section + Status writes #3): **a product-side status flip spends
every review verdict — clearing both flags rides the same package as the flip.**
Early reviews are feedback; only gate-time verdicts are certificates, and the gate
already re-requires the one that matters (declared data work ⇒ live Data Approved).
The materially-changed rule stays for mid-phase writes.

## 2026-08-07 — every ending names what's next (dry-run finding)

The address session closed with a clean report — status, rev, flag, the
same-point-twice warning — and no pointer: the PO had to infer "set the verdict,
resolve the thread, then chart". Rule added to the voice hook (the canonical
conduct channel): end every piece of product work by naming **what's next and whose
move it is**, or say plainly that nothing is next and what the machine waits on.
Never end on a bare report.

## 2026-08-07 — the walk closes as one package (dry-run finding)

The address session split its close into two confirmation rounds: fixes + replies
first, then the flag re-request + ledger comment as a follow-up ask. The PO's read:
the ledger is internal plumbing product doesn't care about, and it shouldn't cost a
second "Proceed". Correct — nothing in the close depends on the first write landing
(the rev the ledger stamps is the rev the package itself sets). Rule added to
address and the tracker doc's re-request act: **fixes, thread replies, the flag back
to `Requested`, and its ledger comment are shown and land together, behind one
line.** The ledger survives (the same-point-twice memory needs it); only its
standalone ceremony dies.

## 2026-08-07 — catch-up: two entries that should have ridden their commits

A history audit (asked for by the PO) found two behavioral changes committed without
entries — both small single-edit commits where the ceremony felt heavier than the
change, which is exactly when records get lost. Recorded retrospectively:

- **Gate reruns only for gate/handoff objections** (`c5ab13c`): address's after-walk
  rule read literally would send a Draft-phase tech verdict to a gate that isn't due
  yet; now an early-phase verdict just gets its re-request.
- **Comment resolution belongs to whoever raised it** (`2da9344`): the connector
  exposes create+list only — resolve is a UI act, and that enforces the right
  ceremony (the answerer never grades its own answer). A replied-but-unresolved
  thread reads "awaiting the raiser", not "unaddressed" — the gate counts unanswered
  threads, not unresolved ones.

Also noted: the repo-wiring commit (`40ca6a2`) amended a same-day entry instead of
appending — a bend of append-only, not repeated. Standing remedy until
`product:update` ships its static audit: the entry rides the same commit as the
change, however small the change.

## 2026-08-07 — the write that spends a verdict clears it

"After tech approves the Draft and refine rewrites it, who flips the Approved back?"
— nobody did. The verdicts-age rule protected the *gate* (spent = pending), but the
*board* kept showing a green Approved on rewritten content — a spent verdict
displayed as live is the flag lying about whose court it is. Rule added to the
Contract's Reviews section and the section-writing act: a content write that
materially changes what a verdict covered **clears that flag to empty in the same
shown write**, behind the same confirmation line. Judgment-based, not
automatic-on-flip (charting's Map section usually spends nothing; a resolution
rewriting Requirements does). Clearing ≠ verdicting: product still never sets
`Approved`/`Changes requested`. The gate's spent-counts-as-pending stays as the
backstop for uncleared flags.

## 2026-08-07 — the prefix becomes optional: ask goes triple-natured

"Can I drop /product:ask?" — not until two gaps closed: the binding hook matched
only `/product:` or "PRD" and injected docs without routing duty, and ask itself was
still model-invocation-disabled (the one flag we kept), so no session could load the
router unprompted. Now, completing tos v2's #815 shape (user + model + hook-nudged):

- **ask unflagged** and its description rewritten to match product work broadly
  (model-invocation path).
- **Binding hook matcher widened**: `/product:`, `PRD(s)`, or any Notion link — and
  its header now opens with the routing nudge: this looks like product work → load
  product:ask and follow it; don't improvise the workflow around it.
- **Voice hook** (SessionStart) advertises ask as the entry point, covering prompts
  the matcher misses.
- Residual: a first prompt with no keyword, no link, and no /product: prefix rides
  on model judgment via ask's description — the prefix remains the guaranteed path.

## 2026-08-06 — a Name is a handle, not a summary (dry-run finding)

The photo-request triage proposed a 15-word, two-clause grievance as the PRD Name —
obeying the filing act's "states the problem, never a solution", which guarded
against solution-names and silently optimized for grievance-sentences. The filing
act now says what a Name is *for*: a handle — ≤ ~8 words, area + stake, board-card
legible, no "and"-bundles (two asks on one page → name what they share). The full
grievance keeps its home as the Problem section's opening line. Short grievances
still make good handles ("Hosts can't tell who cancelled"); long ones are summaries.

## 2026-08-06 — the binding-injection hook (speed where it matters)

The cost of "load the tracker doc whole" was never file I/O — it was model
round-trips: 1-2 full turns before a session's first useful act. A UserPromptSubmit
hook now injects issue-tracker.md + code-repository.md when the prompt is product
work (`/product:` or PRD-shaped), once per session (marker file under
`~/.claude/product/binding-injected/`, 7-day prune), fail-open, with a header that
satisfies the load-whole rule and forbids redundant re-reads. Freshness is free —
the script reads the disk files at prompt time. **Notion contract caching was
considered and deferred**: it needs an integration token (a `setup` job), adds
staleness semantics, and its win is one fetch per state-affecting session; revisit
only if latency still hurts after this. Status writes keep verifying against the
live contract regardless.

## 2026-08-06 — code-repository.md: triage and research get eyes on the code

Not an addition — a restoration: MP's triage already says "explore the codebase" and
"verify the claim"; our binding had defused both to corpus-only because the plugin
had no code story (the photo-request dry run showed the cost: the PRD asserted
"rejection hides but retains" and "stored full-size" on a Slack thread's word).

- **`code-repository.md`**, sibling of `issue-tracker.md`, same indirection: skills
  keep MP's abstract verbs (zero skill-text changes); the doc binds them to the
  repos (all three wired same-day: TOS = web-restaurant-management-portal, mobile =
  timeleft-monorepo, backend = api-nestjs — local sibling working copies, read-only,
  never fetch/pull/switch branches) and carries the register law — findings are
  behavior / capability / effort shape, never file, function, framework, or table
  names.
- **Reading is delegated to a throwaway read-only agent pointed at the doc** —
  context isolation IS register isolation: the technical vocabulary lives and dies in
  the throwaway's context. A bespoke agent .md was considered and rejected on tos
  v2's own precedent (#817 dissolved its six read-only subagents into convention
  docs + throwaway delegation).
- Consumers: triage (redundancy check + claim verification), research (code as a
  primary source, claims marked verified-in-code vs reported-by); the doc is
  skill-agnostic, so draft may lean on it for effort shape.

## 2026-08-06 — the tech side is a human until the tech plugin ships

"How do I review without the tech plugin?" — by hand: the flags are plain properties
and Notion's own UI is the review tool (inline comments + a select). The data lead
was always human; the tech plugin only ever automates its own side of the same
motions. Interim clause added to the Contract's Reviews section: every act marked
"tech plugin" reads "tech lead, by hand" until it ships — same rules (anchored
comments, own flag only, In development only with a created tech issue). This also
makes the sandbox fully testable single-handed: one person can play both sides of
the handshake.

## 2026-08-06 — verdicts age (review-at-Idea question)

Asked whether data/tech can review an `Idea` the same way as a Draft: yes by
construction (flags are orthogonal to status; `Rev` exists from filing), and it's
the cheapest objection point — at Idea the reviewers judge the *problem*. But the
question exposed a gap: an `Approved` given at rev 1 survived on the flag after a
Draft rewrote everything, and the gate would have honored it. Rule added to the
Contract's Reviews section and to-tech's check 6: **an approval covers the document
as it stood at its stamped rev — materially changed since means spent, and spent
counts as pending. Re-request, don't ride it.**

## 2026-08-06 — the router may dispatch (dry-run finding)

`/ask` routed correctly, confirmed behind the line, invoked triage — and the harness
refused: `disable-model-invocation` blocks the Skill tool outright. MP ships the flag
because ask-matt *advises* (the human types the next command); our ask *dispatches*.
Removed from the five routed skills — triage (P5) and refine (P7) as drift records,
draft/address/to-tech as ours — kept on `ask` (the entry; nothing routes to it). The
resolvers never had it (MP's own choice). Safety story: the flag prevented un-asked
invocation, but the plugin now guards at the right layer — a spontaneously-loaded
skill still can't file, flip, or comment without "Proceed — or what changes?". If
unwanted spontaneous invocation shows up in practice, re-gate selectively rather
than reverting the router.

## 2026-08-06 — review-flags rework hardened (final adversarial pass: 7 findings)

Last adversarial review of the effort (retired hereafter by the PO — too long, too
expensive). All seven confirmed findings fixed:

1. Same-point-twice was undetectable once bounces became property flips (review
   rounds arrive as fresh comments): address now reads the full comment history, and
   every re-request lists the points addressed — the rule's durable memory.
2. A ticket filed mid-walk had no named route: address's closing act and the
   Ready-for-development Handled-by cell now both say ticketed decisions resolve on
   the map (refine + resolvers) before the gate reruns.
3. Rev bumps only rode the section-writing act: the filing act now sets Rev 1, and
   the Resolve fold explicitly routes through the section-writing act.
4. The gate ignored a pending review: check 3 now blocks on `Requested` with no
   verdict (wait, or withdraw explicitly) and auto-fails on `Changes requested`.
5. The review overlay was unauthoritative under database-wins: its authority is now
   named — the Contract's Reviews section, same rank as `Handled by`, which routes
   the phase axis only.
6. ask's drift record hadn't recorded the overlay — amended.
7. No guard against a PRD sitting at a retired status (the status property's old
   options survive until the manual UI cleanup): Status-writes rule 4 — a status
   matching no live row is mis-set; stop and flag, never route from it.

## 2026-08-06 — reviews become court flags: parallel, optional, early

The status axis was carrying two dimensions — the phase, and who's been asked to
look. Split them:

- **PRDs gain `Data review` and `Tech review`** (— → Requested → Approved / Changes
  requested) plus **`Rev`** (bumped by every approved content write; review requests
  stamp the rev they were made on — Notion's native page history has no citable
  version, so the plugin mints its own). Reviews run in parallel, at any product-side
  status — typically on a Draft, moving the "this won't fly" conversation from day 25
  to day 3 — and are optional by construction (empty = never requested), except that
  declared new data work requires `Data review: Approved` at the gate.
- **Statuses retired: `Ready for data`** (fully replaced by the flag) **and `Ready
  for product`** (the bounce is now `Tech review: Changes requested` + anchored
  comments; the status stops lying about the phase — the flag says whose court).
  Rows kept in the Statuses DB marked RETIRED; orders renumbered.
- **`Ready for tech` renamed `Ready for development`** — the prod board's exact
  label, one less takeover rename; the old naming-confusion objection died with
  `Ready for product`. Still the one surviving `Ready for` status, because the
  handoff is real: tech's triage needs a visible inbox.
- Contract page: handshake rewritten around the flag, new "Reviews (parallel,
  optional)" section (who sets what per flag, verdict-without-comments invalid,
  same-point-twice escalates, rev pinning). ask gains the review overlay; to-tech's
  check 6 becomes "declared data work carries Data review: Approved"; address ends a
  verdict walk by re-requesting the review; tracker doc gains the request-a-review
  act and the Rev bump on the section-writing act.

## 2026-08-06 — adversarial review of the route-table rework: 9 findings, all fixed

A skeptic session (cheaper model, instructed to refute) reviewed the Handled-by +
Ticket-outcome rework against the full file set. Everything it confirmed was real:

1. address's thesis said "exactly one of two ways" above a three-outcome menu → now
   "one of three ways".
2. ask's `Ready for data` bullet said "Nothing else to route", contradicting the
   Handled-by cell it was narrating → now routes walking-needed comments to /address.
3. **The routing authority had no guard** — an editable Notion cell with override
   power. Now: the cell may only name roster acts / humans / the tech side; an
   unresolvable cell is broken, never obeyed (in ask AND the tracker-doc recipe).
4. **Worst finding: Ticket closed the thread on a promise** — the reply landed before
   any ticket existed, and if the checkpoint session never ran, the decision vanished
   past both gate checks. Now address files the ticket itself (Open, unassigned,
   PRD-linked, per the new tracker-doc creating-a-ticket act) and the reply links it;
   the checkpoint only wires.
5. address's gate-rerun promise was conditioned on bounces only; to-tech's was
   unconditional → address now reruns the gate after gate-failure walks too.
6. ask's lock.md drift note and in-file provenance comment predated the rework → both
   amended.
7. No tracker-doc mechanics existed for the plugin's most consequential read → the
   "route by Handled by" recipe added.
8. refine's fog fallback ("not sharp enough") was false for address-sourced tickets,
   which are sharp by construction → budget overflow carve-out: inbound-note
   decisions fold, never fog (P5 amended).
9. The second-bounce check wasn't wired into the walk's menu — a re-raised point
   could be laundered into a map ticket → step 2 now checks thread history before
   proposing any outcome.

Also from the review: ask's narration lacked `In Design` and the terminal statuses —
added, since narration a reader trusts shouldn't be visibly partial.

## 2026-08-06 — the route table moves into the machine (`Handled by`)

Design review of "fold address into refine / rename Ready for product to In Review /
move the procedure to Notion". Outcome: reshape, not fold —

- **Statuses DB gains `Handled by`** — the routing authority, one cell per status
  naming the act that takes a PRD there. `product:ask` now routes by reading the
  PRD's row; its flow map is demoted to narration ("if the two disagree, the
  database wins"). Procedures stay git-side (verbs); the *wiring* joins the machine
  in Notion, where the future observer layer reads the same table to notify.
- **address keeps its job and gains the missing third outcome: Ticket** — a comment
  that names an open decision is neither fixed nor declined; it goes to refine's
  checkpoint as an inbound note and becomes a map ticket. The fold-into-refine idea
  was rejected: comments arrive outside bounces too, most bounce comments are cheap
  fixes not decisions, and the walk would be a fat seventh patch on MP's wayfinder.
  The bounce loop now reads: address walks → refine resolves what was ticketed →
  to-tech revalidates (an open ticket fails the gate by definition).
- **`Ready for product` keeps its name** — "In Review" hides the owner; `Ready for
  <team>` names the inbox, which is the handshake's whole legibility (the same
  argument that renamed Ready for development). Routing needed no rename: ask routes
  by status regardless of what the status is called.
- Automation stance: layers read the table, humans run the sessions — ask routes
  from it now, the native-agent observer notifies from it later, the tech pipeline
  eventually flips the tail. Nothing autonomous writes a PRD.

## 2026-08-06 — the Contract page becomes the behavior page

The conduct rules split by nature, each to the channel that can actually carry it:

- **"No write without a yes" + the confirmation line are contract-grade** — the whole
  company should learn ONE line from both plugins. Canonical statement moved to the
  Workflow Contract page (permission-locked, already loaded by every state-affecting
  skill before a write); the tracker doc keeps a short operational restatement.
- **Voice/register rules stay git-side, canonical in the hook itself** — tone is a
  verb, Notion-hosted instructions are the ruled-out failure mode, and hooks cannot
  fetch Notion anyway. "How a session speaks" removed from issue-tracker.md (it was
  the wrong home and a second source waiting to drift); the recipes fence stays.
- The Contract page now also **embeds the Statuses view** (the configurable machine)
  and **hosts the PRD skeleton as its child page** (the document anatomy both plugins
  read against) — one Notion surface for "how the workflow behaves": prose rules,
  machine, anatomy. A general "Behavior" database for tone was considered and
  rejected: instructions in a broadly-editable page, undeliverable to sessions.

## 2026-08-06 — the voice hook (third pass: the rule must ride a guaranteed channel)

The register rule failed its retest, and the transcript shows why: the session
*grepped* the tracker doc for the confirmation line ("Searched for 1 pattern") and
never loaded "How a session speaks" at all. Operating recipes are consulted on
demand; conduct rules placed only in an on-demand file provably miss. Two fixes:

- **A SessionStart hook** (`hooks/hooks.json` + `hooks/product-voice.sh`, tos v1's
  field-tested format) injects the conduct block — register, no narration, the
  confirmation line — into every session. Canonical text stays in issue-tracker.md;
  the hook is the delivery channel, not the source of truth; it self-dismisses for
  non-product sessions. This reverses the earlier entry's "SessionStart hook not
  worth it for tone" — the evidence changed: two placements have now missed, and the
  hook also closes that entry's known gap (verbatim grilling/research never open the
  tracker doc).
- **ask gains "load the tracker doc whole before your first act"** — its own
  "confirmation line" phrasing had invited the one-line grep.

## 2026-08-06 — speak product, never machinery (second pass on the same finding)

"How a session speaks" banned narration but not **register**: a session told a PO its
search plan was "SQL pass plus semantic search" — not procedure-narration, machinery
vocabulary. Root cause has a twist: the tracker doc's own recipes *teach* those words
(necessarily — they're operating instructions), and the session recited its reading
material. Two additions, same section, same home:

- A register bullet naming the audience — a PO who has never written a query — with
  the translation rule (machinery act → product sentence: "I'll search the existing
  PRDs two ways — by title, and by meaning") and the fallback (no product name → say
  what it does for them, not what it is).
- The speak-test extended: "…and doesn't know what SQL is."
- "When a skill says…" opens with a fence: recipes are for your hands, not your
  mouth — you run these, you never recite them.

## 2026-08-06 — how a session speaks (dry-run finding)

A `/product:ask` session read its own procedure aloud: "I'll start by reading the
tracker binding and the ticket itself", a "Read first — where this sits" heading, and
a routing call justified as "`In PRD` + a ticket on the frontier routes to the resolver
matching its type". The PO's read of it: the skill is interacting with what's written
in the skill, not with the person who prompted it. Correct — every skill here specifies
what to *do* and none of them said what to *say*, so the procedure became the script.

Diagnosis and placement, both deliberate:

- **The skill files are not the problem.** They sit inside MP's budgets (`ask` 56 lines,
  `draft` 32, `address` 28). Shortening them would have cost content and fixed nothing;
  the verbosity is in the output.
- **The rule lives in `issue-tracker.md`, not in ten `SKILL.md` files.** Six of those are
  vendored word-for-word — patching each would mean ten new drift records against the
  load-bearing doctrine for a concern that isn't per-skill. The tracker doc has no
  upstream, is already opened by every tracker-aware skill before it acts, and already
  carries cross-skill discipline of exactly this kind in "No write without a yes".
- **CLAUDE.md was considered and ruled out** — the obvious home once the build doctrine
  is retired, but it doesn't ship. A plugin-root CLAUDE.md is documented as never
  loaded, and the repo-root one is in context only for someone standing in this clone:
  present for whoever builds the plugin, absent for everyone who uses it, and so it
  would look correct in every local test. CLAUDE.md keeps its real job — the
  contributor guide for whoever edits this repo.
- **Known gap:** `grilling` and `research` are verbatim MP text with no tracker-doc
  reference, so the rule doesn't reach them. Accepted for now — grilling speaks one
  question at a time to a human and research runs AFK writing a file, so neither
  exhibits the tic. The only channel that would cover them is a `SessionStart` hook,
  which injects standing instructions into sessions that never touch a PRD; not worth
  it for tone.

## 2026-08-06 — the chosen design is durable (dry-run finding)

Name collision surfaced mid-refine: MP's *prototype* is throwaway by definition
("keep the answer, delete the code"); the product workflow's *prototype* is the
design phase's **deliverable** — the artifact the PRD attaches (`Figma` property)
and hands to the tech team. P1's original wording carried MP's "throwaway from day
one" onto the design branch, and the refine session repeated it, confusing the PO.
Corrected in the patch and the capture override: **candidate takes are throwaway,
the chosen one is durable** — linked from the ticket's `Artifact` and the PRD's
`Figma`, part of the handoff. MP's rule survives as its product translation: keep
the answer (the chosen design), discard the rest (the rejected takes). One prototype
*ticket* per PRD, unchanged.

## 2026-08-06 — draft may close a recorded ambiguity (dry-run finding)

The konami dry run's `/draft` session correctly wanted to fix a Context clause triage
had left open ("surface still to be pinned") after the Glossary resolved it — but
draft's own text said "touching only the sections named above," which excludes the
Problem Statement. Narrow exception added: draft may correct **an ambiguity the
problem statement itself records** once it has resolved (a glossary row, a
requester's answer), shown for the same yes. Draft still never rewrites the problem —
it may only close a question the problem statement asked, because a resolved
question left standing reads as still open.

## 2026-08-06 — no write without a yes (dry-run finding)

The first end-to-end run filed an Idea PRD without showing the human its name first —
triage's P3 patch said "file it first" and the session obeyed, front-running MP's own
Recommend-then-wait step. Root cause was patch-level, fix is convention-level:

- **The tracker doc gains "No write without a yes"**: every tracker-changing act
  (file, flip, comment, section edit) is shown before it lands, then the same one
  line, every skill, every time — **"Proceed — or what changes?"** A yes lands the
  write exactly as shown. Defined once at the act level, so every skill that writes
  "per the tracker doc's … act" inherits it without being edited.
- The uniform sentence is deliberate: the human learns that this line, and only this
  line, is the plugin waiting for permission. Reads never carry it.
- **triage P3 amended** (filing shows name + problem statement for a yes) and **ask
  gains "Route with a yes"** (name the skill + its first act before invoking; reads
  need no permission). Draft/address/to-tech already paused — their approval steps
  now resolve to the shared line rather than each phrasing its own.

## 2026-08-06 — the plugin moves to `.claude/skills/product` (placement is the registration)

A fresh session in this repo saw no `/product:*` skills: nothing auto-discovers a
`plugins/` directory. The app repo's field-tested `plugin-loading.md` (tos v1) has
the rule — the CLI's only local load path is **skills-dir auto-discovery**
(`.claude/skills/*/` carrying a `.claude-plugin/plugin.json`), settings-based
registration is a tested dead end (cloud ignores it; locally it shadows the live
tree behind a stale cache), and root `marketplace.json` is the catalog for the
future org bundle, inert locally. So the plugin moved to `.claude/skills/product/`,
the marketplace source now points there, and the distilled loading rules live at
`docs/plugin-loading.md` in this repo. Provenance comments now say "the plugin's
lock.md" instead of a hardcoded path.

## 2026-08-06 — ask/triage boundary + the agent-brief binding

Two corrections from review:

- **ask's reads clause over-claimed.** MP's triage owns the corpus-wide attention
  sweep ("show me anything that needs my attention" — the three buckets). ask now
  serves only *orientation* reads about a named PRD (status, frontier, open threads)
  and routes the attention sweep to `/triage`. The boundary: pointing at a PRD →
  ask answers; sweeping the corpus → triage's machine.
- **AGENT-BRIEF.md kept byte-verbatim, defused in the binding** rather than dropped
  (dropping would mean editing MP's SKILL.md references — compression). The tracker
  doc now maps "post an agent brief" → the PRD page *is* the durable brief (Problem
  Statement + triage's findings comment; `/draft` reads the page). The file's
  principles — durable over precise, behavioral not procedural, testable criteria,
  explicit scope — bind Problem Statement writing; its code-shaped template and
  examples are upstream reference, never reproduced.

## 2026-08-06 — `product:ask`, the entry point

Built before `setup`/`update` (out of the planned order) so the workflow can be
walked end to end. Shaped on ask-matt's flow-map at the pin — a third provenance
class, recorded as such in `lock.md`: the counterpart exists (so not net-new) but its
content is MP's own roster (so not vendorable verbatim); the *structure* is adopted
and the main flow made **state-aware**, keyed on the PRD's status — tos v2's #815
precedent applied.

- Reads are served, not routed: "what's next" is a frontier read, never a checkpoint.
- One route per status; `Ready for tech` and beyond is read-only (the tech plugin
  owns the PRD); `On Hold` routes to nothing until the PO resumes by hand.
- The router restates the two invariants it must enforce ahead of any skill it
  routes to: never guess a transition, never touch the production board.
- Model-invocation stays disabled for now (matching ask-matt); the hook-enforced
  "can't bypass the EPS" layer is later machinery, as it was in tos v2 (#829).

## 2026-08-06 — the review loop: `product:address` and `product:to-tech`

Both net-new — the counterpart check ran against both upstream skill directories at
the pin before a word was written (`code-review` reviews diffs, `to-spec` writes
specs; nothing upstream walks comments or gates a document).

- **`address`**: every comment is a mini-ticket — fix the section or reply why not
  (citing the ticket that settled the point), human approves each outcome, a thread
  is never resolved with neither. Second-bounce rule enforced: a re-raised point
  pauses the loop and names the PO + tech lead. Address flips no status; a bounce
  goes back through the gate.
- **`to-tech`**: review-with-a-gate, six checks (map clear · decisions folded · no
  open comments · handoff surface complete · reads alone · data work declared),
  collected failures become anchored comments (drafted, human-approved), pass flips
  `Ready for tech` — or `Ready for data` first when new data work is declared. The
  refine/to-tech boundary holds: checkpoint challenges the map, the gate challenges
  the document.
- Tracker doc gains the comments operation (enumerate discussions, reply on-thread,
  the quote-the-section anchoring convention).
- **Correction to the previous entry's rationale**: the headless-session concern was
  unfounded — the cloud runs have the Notion connector, tested. The code-comment-
  pointing-at-decision rule stands anyway (constraints belong in code, per MP's own
  implement discipline), but as good practice, not as a workaround.

## 2026-08-06 — domain modeling moves fully to Notion (no PRs for knowledge)

The driver: domain-modeling outputs shouldn't need commits and PRs. Resolved by
binding, not by editing — all three domain-modeling files stay byte-verbatim:

- **`CONTEXT.md`** was already the Glossary DB; the override now names the row shape
  (Term / Definition / _Avoid_, written the moment a term resolves).
- **`CONTEXT-MAP.md` / multi-context** — the Glossary's `Scope` property IS the
  context map: Product and Tech are the bounded contexts, Shared is the shared
  kernel, filtered views play the per-context files, and the Contract page is the
  "Relationships" half.
- **`docs/adr/` → the new Decisions DB** (`ADR-n` auto-increment ID, Scope, Status,
  Superseded-by⇄Supersedes self-relation). MP's three-part bar verbatim, plus one
  cut: the decision must outlive a single PRD — PRD-scoped decisions keep living on
  tickets. Guard against the headless trap (AFK tech sessions may lack the Notion
  connector): a decision constraining a specific spot in code gets a code comment at
  that spot pointing at the decision URL — the guard travels with the code.
- Scoped for the tech plugin too (one corpus, `Scope=Tech`), recorded as an inbound
  note for the #825–#829 build effort. Specs and per-slice impl docs deliberately
  stay in git — they version with branches and ride feature PRs that exist anyway.
- Re-charter note for the future doc-app effort (#808/#816): the corpus it was going
  to serve has largely moved to Notion; its first question becomes "is the answer
  'publish to Notion' rather than building an app?"

## 2026-08-06 — the resolver batch: research, grilling, prototype, domain-modeling

Four upstream skills vendored at the pin. Three are **byte-verbatim** (research,
grilling, domain-modeling + its two format siblings) — no in-file provenance comments,
so the files diff clean against upstream; lock.md is the attribution. Their repo-file
vocabulary (research notes in the repo, CONTEXT.md, ADRs) is absorbed by
`issue-tracker.md` overrides, not by touching MP's text.

`prototype` carries **one patch** (P1): a third branch for design artifacts — Figma or
generated design output, several takes, review prompts answered against it — since
product prototypes usually have no codebase at hand. Its capture rule is overridden in
the tracker doc: artifact link on the ticket, verdict + prompt answers in the
resolution comment, and the In PRD ⇄ In Design status round-trip on claim/resolve.

Fold-back discipline (why → ticket, what → PRD) deliberately lives in the tracker
doc's Resolve operation and refine's work-through — the resolvers stay pure so they
also serve outside a map.

## 2026-08-06 — status machine adopts the prod board's labels

The machine re-based on the production Product Roadmap Board's existing Phase
vocabulary, so the eventual takeover keeps eight prod statuses untouched and renames
almost nothing:

- **`Idea`** (new) is triage's filing state — problem statement only; `/draft` works
  there until its first pass is written. Maps 1:1 onto the canonical `needs-triage`.
- **`Draft`** stays (prod's `Backlog` renames to it at takeover — more explicit);
  `Refining` renamed **`In PRD`** (prod's label; refine's charting flips it).
- **`In Design`** (new): the prototype ticket's status round-trip — claim flips
  In PRD → In Design, resolve flips back. Makes `/prototype` state-affecting.
- **`Ready to roll out`** (new, planned automation): QA validated, awaiting the
  production release; between In QA and Rolled out.
- **`On Hold`** (new): the siding — a strategic pause owned by the **PO, set by hand,
  never by a plugin**. Skills propose parking (refine's checkpoint typically), the
  human decides; parking requires a comment (why + resume target). Deliberately NOT
  the `needs-info` mapping — needs-info is normal triage traffic (a pending question),
  not a parked initiative. `Set by` gains its first `human (PO)` actor.
- Skill-text cost of the whole rework: **one word in refine's P4 patch**
  (`Refining` → `In PRD`) and zero changes to triage or draft — everything else landed
  in the role-mapping and wayfinding sections of `issue-tracker.md`. The vendoring
  indirection working as designed.
- Prod statuses `PRD in product review` and `Done` still dissolve at takeover;
  `Ready for data review` → `Ready for data` and `Ready for development` →
  `Ready for tech` remain the only handoff-side renames.

## 2026-08-06 — `product:draft` and `product:refine`

- **`draft` is net-new** — upstream has no counterpart (checked `skills/engineering/`
  and `skills/productivity/` at the pin), so it is written as if MP wrote it: ~40
  lines, behaviors-not-screens discipline, requester-approves-before-write, only the
  first-pass sections filled (goals, user needs, out of scope, terminology — everything
  solution-dependent keeps its placeholder). Flips the issue to `Draft`.
- **`refine` vendors MP's wayfinder word-for-word** at the pin, 6 audited patches
  (lock.md): the plugin-internal tracker pointer, the chart-entry paragraph (charting
  maps onto the drafted issue and flips it to `Refining`), the ticket budget section
  (3/3/1, fold by theme — supersedes one-ticket-one-decision for grillings), and the
  checkpoint mode (map QA; document QA stays `/to-tech`'s). Diff-proven against the
  fetched upstream file.
- **Tracker doc gains the wayfinding bindings**: the map body maps onto the PRD
  (Destination fixed by the workflow, Decisions-so-far / Not-yet-specified as Map
  subsections, Out of scope under Requirements), the section-writing act
  (`update_content`, smallest region, never whole-page), and the research-capture
  override — findings live on the ticket page, never on a git branch; Notion owns the
  nouns.

## 2026-08-06 — triage re-vendored from MP upstream (doctrine repair)

The first `triage` was written as an original skill and its provenance row claimed
"no upstream counterpart" — but `mattpocock/skills` has one at
`skills/engineering/triage`. That violated the word-for-word vendoring doctrine at its
root, so the skill was rebuilt rather than patched around:

- **SKILL.md is now MP's text at pin `2ab9580`, word-for-word, plus 4 audited patches**
  (P1–P4 in `lock.md`), diff-proven against the fetched upstream file. Siblings
  `AGENT-BRIEF.md` and `OUT-OF-SCOPE.md` vendored verbatim; `agents/openai.yaml`
  excluded per the tos convention. The upstream pin is set to `2ab9580` — the tech
  plugin's pin — so the two-pins-match CI rule holds from day one.
- **`notion-bindings.md` renamed and reshaped into `issue-tracker.md`** (the tos v2
  convention name and shape: role mapping + per-operation "When a skill says…"
  sections). Skill prose speaks abstract tracker verbs again; every concrete tool
  name, SQL recipe, and property shape lives only in the tracker doc.
- **`searching.md` and `writing.md` deleted.** Their field findings survive as tracker
  doc content: wildcards go in the SQL parameter (Notion rejects predicate
  concatenation), the semantic index lags creation by ~1 minute so an empty semantic
  pass licenses nothing, verify-after-write, and the template/skeleton handling.
- **What survives of the original prose:** the Fold outcome (now drift record P4), the
  problem-not-solution filing discipline (P3), and the contract-first / Statuses-DB-wins
  rules (moved to the tracker doc's Status writes section, where they bind every skill
  instead of one). The `.out-of-scope/` knowledge base maps onto `Rejected` rows — one
  concept per page, never deleted, reconsideration = new PRD linking the old one.

## 2026-08-06 — repo bootstrapped

- Marketplace `team-plugins` and the `product` plugin manifest created.
- `lock.md` opened with an empty upstream pin; no skill vendored from
  mattpocock/skills yet, so the pin stays blank until the first vendoring run.
- `plugins/tech/` deliberately not scaffolded — it arrives once tos v2's build
  effort lands, and an entry pointing at a missing directory breaks marketplace
  loading.

## 2026-08-06 — `product:triage`

First skill of the roster.

- **Three outcomes, not two.** CLAUDE.md names reject-with-citation and hand-to-draft.
  A third case turned up in practice: a live PRD already covers the area and the
  request adds a real nuance to it. Opening a near-duplicate would fragment the corpus,
  and rejecting would lose the nuance — so triage folds it in as a comment and creates
  nothing.
- **Triage creates `Rejected` rows itself.** Settled by the Statuses DB, whose
  `Rejected` row reads "ruled out at triage, kept forever with the reason and the prior
  page it matched" and is `Set by: product plugin`. The rejection therefore has to be a
  page, so the next search can find it.
- **The PRD skeleton is fetched from Notion, never vendored.** Copying it into the repo
  would make it a local paraphrase of something Notion owns, and it would drift the
  first time the template changed. The skeleton page URL lives in the bindings file.
- **Backlog PRDs carry the whole skeleton with only Problem Statement filled.** The
  alternative — writing just the one section — was rejected: every later skill expects
  the shape, and a half-page reads as a page someone abandoned.
- **`notion-bindings.md` at the plugin root** holds the Notion addresses for the whole
  plugin, including an explicit prohibition on the production board. `product:setup`
  will maintain it. Not a CONTEXT.md: it is an address book, not vocabulary.

Exercised end-to-end against the sandbox — both search passes and the Open write path.
Two corrections came out of it, and are in `searching.md`:

- Notion's SQL rejects `LIKE '%' || ? || '%'`; the wildcards go in the parameter.
- The semantic index lags page creation by roughly a minute, so an empty semantic pass
  is not on its own grounds to open a PRD. The SQL sweep is the authoritative one.
