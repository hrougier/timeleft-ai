# shared — vendoring lock

Provenance for every skill in this plugin. Maintained by `shared:update` (unbuilt — see
CLAUDE.md; this plugin's pin is one of the three CI compares, so it needs its own
maintainer rather than borrowing a workflow plugin's).

Doctrine: upstream `mattpocock/skills` is checked for a counterpart **first**. Where one
exists its text is vendored **word-for-word** from the pinned commit; every adaptation is
a patch-only amendment in MP's voice, recorded as a drift record below.

**What belongs here.** A skill lives in `shared` only if it **owns a method and never a
destination.** Bindings are reached by naming a config skill, and a shared skill cannot
know whether the session is product's or tech's — so the moment a skill needs to say
where its output goes, it stops being shareable and belongs in the plugin that owns that
destination. This is the rule that decides admission; apply it before adding anything.

## Upstream pin

One pin for the whole vendored set. It matches the product and tech plugins' pins (CI
asserts all three are equal).

| Upstream                             | Ref  | Pinned SHA                                 | Pinned on  |
| ------------------------------------ | ---- | ------------------------------------------ | ---------- |
| https://github.com/mattpocock/skills | main | `2ab958093e83e0ec752e6c1c5932da465bf23e0c` | 2026-08-06 |

## Skills

| Skill      | Origin                                 | Verbatim / Adapted | Drift    |
| ---------- | -------------------------------------- | ------------------ | -------- |
| `grilling` | `skills/productivity/grilling` @ pin   | **Verbatim** — body and `name:` | none |
| `research` | `skills/engineering/research` @ pin    | Adapted (step 3)   | C1 below |
| `glossary-and-decisions` | `skills/engineering/domain-modeling` @ pin | Adapted (one inserted paragraph), `name:` renamed from `domain-modeling`; siblings `ADR-FORMAT.md`, `CONTEXT-FORMAT.md` verbatim | C2, C3 below |

`grilling` is the cleanest case in either plugin: it already owned a method and no
destination, so extraction restored it to fully verbatim. It carried a `name:` rename
while it lived in the product plugin (that plugin's drift record R1); moving it here
removed the rename and the drift with it.

### Drift records — `research`

- **C1 — the destination becomes the caller's** (step 3, one bullet). Upstream ends
  "Save it where the repo already keeps such notes; match the existing convention." That
  is a destination, and a repo-shaped one: right for an engineering workflow, wrong for a
  product manager whose findings belong on a ticket. While this skill lived in the
  product plugin the destination was overridden out-of-band by that plugin's tracker doc
  — which worked only because the caller had already loaded it, and would have written
  Markdown into a repo on a cold invocation.

  The patch replaces the destination with a rule about *whose* it is: follow the binding
  the session already carries; with none, hand the findings back and say where you would
  put them, rather than inventing a place or defaulting to a repo. Method untouched —
  primary sources, follow every claim to its owner, cite each one.

  This is the admission rule applied to the one skill that didn't already satisfy it. It
  is the only patch this plugin should ever need of this kind; a second one is a sign the
  skill belongs in a workflow plugin instead.

### Drift records — `glossary-and-decisions`

- **C2 — the model's location becomes the caller's** (before §File structure, 2026-08-09).
  Upstream is 74 lines built on a repo: `CONTEXT.md`, `docs/adr/0001-*.md`,
  `CONTEXT-MAP.md`, directory trees. Every one of those is overridden by
  `issue-tracker.md`'s translation section — which means the skill was correct only when
  the caller had already loaded the tracker doc. Invoked cold, it told a product manager
  to create `CONTEXT.md` and start numbering ADR files.

  One inserted paragraph, before the file layout: the layout is the default for a repo
  that keeps its model in files; a binding naming a glossary or decisions database wins
  and the paths are read as roles; with no binding at all, say so and stop rather than
  assume a repository. The discipline itself — challenge terms, invent edge cases, write
  it down the moment it crystallises — is untouched, which is the whole point of putting
  the patch above the layout rather than inside it.

  Same repair as C1 above and the product plugin's P8, and the largest of the three: not a
  stray line but the skill's spine. **It is what made the move here possible** — the skill
  named its own destinations, and nothing else blocked it. With C2 in place it carries
  none, so it needs no config of its own: the caller passes the binding, exactly as
  `research` does.
- **C3 — the name stays `glossary-and-decisions`** (frontmatter). Upstream is
  `domain-modeling`. Moving here would normally restore the upstream name — that is what
  made `grilling` fully verbatim — and doing so costs nothing on the surface, since the
  voice layer forbids saying any skill name to a human. The PO chose to keep the renamed
  one anyway: it is what a person recognises in the picker, and the picker is the one
  place a name is still visible. A deliberate trade of one drift record for legibility,
  not an oversight — the only rename in this plugin, and the reason `grilling` is verbatim
  while this is not.
