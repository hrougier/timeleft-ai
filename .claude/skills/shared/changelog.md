# shared — changelog

Append-only. One dated section per change decision (what changed, and why).
Never rewrite or reorder past entries.

## 2026-08-09 — the plugin is chartered, with `grilling` and `research`

Both plugins vendor the same skills from `mattpocock/skills`. Shipping them twice means
two copies of one text, two pins to keep equal, and — since claude.ai's chat surface
shows no plugin prefix — two skills answering to the same name. The product plugin worked
around the last one by renaming its copies `research-prd` and `grill-prd`, which fixed
the collision by making both copies wrong.

This plugin exists to delete the duplicate rather than disambiguate it. The names go back
to MP's: **`grilling`** and **`research`**, unique because only one plugin ships them.

**The admission rule, decided before the first skill moved: a shared skill owns a method
and never a destination.** Bindings are reached by naming a config skill, and a skill
here cannot know whether the session is product's or tech's — on claude.ai there is no
invoker context to infer it from. So the moment a skill needs to say where its output
goes, it belongs to the workflow that owns that destination.

Measured against it, the two candidates split:

- **`grilling` already satisfied it** — pure method, no repo, no tracker, not one line
  about where anything is recorded. Extraction restored it to fully verbatim: it had
  carried a `name:` rename in the product plugin, and moving it here removed the rename
  and the drift with it. Extraction made the vendoring *cleaner*, which is the shape a
  correct refactor has.
- **`research` did not.** It ended "save it where the repo already keeps such notes" — a
  destination, and a repo-shaped one. In the product plugin that was overridden
  out-of-band by the tracker doc, which worked only because the caller had already loaded
  it; invoked cold, the skill would have told a product manager to write Markdown into a
  repository. One patch (C1) replaces the destination with a rule about whose it is.

That patch is the price of extraction and it was worth paying: the alternative is the
tech plugin vendoring its own copy, which is the duplication this plugin removes.

What did **not** move: `design-prd` (product's makes a design artifact, tech's writes
throwaway code — two skills sharing one name, not one shared skill) and
`glossary-and-decisions` (plausible later — the Decisions database is already shared by
both plugins — but it writes to a tracker today, so it fails the admission rule).

**Who makes sure this plugin is actually installed.** Neither workflow plugin can install
it, and neither should assume it. **Each roster's `setup` skill checks first** — against
the session's own skill list, never a settings page, for the reason learned the hard way
on 2026-08-08: a connector can read "connected" and hand over nothing, and the only
honest test of a capability is whether you hold it. If `research` and `grilling` are
absent, setup walks the human through adding the marketplace and installing `shared`, then
re-checks before continuing.

The failure this prevents is the quiet one: a product session reaching a research ticket,
finding no skill, and either stopping with a confusing error or improvising the research
itself without the method. Recorded in CLAUDE.md against both rosters' `setup` entries.

Version 0.1.0.

## 2026-08-09 — `glossary-and-decisions` joins

Third skill, and the one that tested whether the admission rule means what it says.

It looked like a fail: 74 lines about `CONTEXT.md`, `docs/adr/` and directory trees —
destinations everywhere. But the destinations it *actually* has, once you look past the
file paths, are the **same for both plugins**: one company glossary, and a Decisions
database already chartered as both rosters' ADR corpus. The rule exists because a shared
skill cannot resolve a binding that *differs* per plugin. A binding that doesn't differ
was never the problem.

What did block it was that the skill named its own destinations. Fixed the day before it
moved (C2, carried over from the product plugin): the file layout is the default for a
repo that keeps its model in files, a binding naming a database wins, and with no binding
at all the skill says so and stops rather than assuming a repository. With that in place
it carries no destination, needs no config of its own, and the caller passes the binding —
exactly how `research` works.

**It kept the name `glossary-and-decisions` rather than reverting to upstream's
`domain-modeling`** (C3). Reverting would have bought back verbatim, as it did for
`grilling`, and costs nothing to a reader since no skill name is ever said aloud. The PO
chose legibility in the one place a name still shows: the picker. One drift record traded
for a name a person recognises, deliberately.

The product plugin's `issue-tracker.md` keeps its translation — `CONTEXT.md` → Glossary
rows, `docs/adr/` → Decisions rows — because that is per-plugin binding and belongs where
bindings live. Tech writes its own when it arrives.

Version 0.2.0.

## 2026-08-09 — named "Shared Toolkit" in the UI

`displayName` set. "Product Team" and "Tech Team" name their audiences; this plugin has
none of its own, so it is named for what it holds. The identifier stays `shared` —
`displayName` is not used for namespacing or lookup, so nothing else moved.

Both workflow plugins now declare this one as a `dependency`, which is the native version
of the install check their `setup` skills were given. The check stays as a second line of
defence: a declaration states what should be present, not what is.

Version 0.2.1.

## 2026-08-09 — the description says what it is, not why it is

Was: *"methods that own how the work is done, never where its output goes."* That is the
**admission rule** — the test for whether a skill belongs here — and it was doing duty as
a description. Useful to whoever adds the next skill, meaningless to someone deciding
whether to install this. The rule keeps its home in `lock.md` and the charter entry above.

Now: *"Plugin-agnostic skills shared by the product and tech teams."*

Version 0.2.2.

