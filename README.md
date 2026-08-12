# timeleft-ai

A Claude Code plugin marketplace holding one plugin per team at Timeleft, plus a shared
one. The two team plugins are chained by a single handshake: a PRD's phase in Notion.
Product works a PRD up to `Ready for development`; tech picks it up from there and either
accepts it into `In development` or leaves the phase where it is and sets
`Tech review: Changes requested` with anchored comments. Neither plugin performs the
other's transitions.

`.claude/skills/product/` is the product team's workflow over Notion PRDs — triage, draft,
refine, ticket resolvers, comment handling, and the handoff gate. `.claude/skills/shared/`
holds the skills both rosters use. `.claude/skills/tech/` is not on `main`; it lands later
as tos v2, renamed. Each plugin is self-contained: its own vendored skills, `lock.md`
provenance and `changelog.md` (its `update` skill is still unbuilt — that maintenance is
by hand for now).

Shared state lives in Notion, never here — PRDs, tickets, phases, the workflow
contract, the glossary. This repo holds only behavior. The design document is
[CLAUDE.md](./CLAUDE.md); where it and Notion disagree, Notion wins.

## Loading

There is no install step for local work — **placement is the registration**. Any
`.claude/skills/*/` directory carrying a `.claude-plugin/plugin.json` is discovered by
the CLI, so cloning this repo and opening it is enough; the skills are live against the
working tree, branch checkouts included.

Everywhere the CLI isn't — claude.ai chat, the Desktop Home tab — the plugin arrives
through a marketplace synced from this repo's **remote**:

```
/plugin marketplace add hrougier/timeleft-ai
```

The root `.claude-plugin/marketplace.json` is the catalog that add reads. It does nothing
locally, and it follows the remote rather than your working tree: an unpushed commit
reaches no one. Org-wide distribution through the admin console is the same catalog under
a different owner, and arrives when the repo moves to `timeleft-dev`.

See [docs/plugin-loading.md](./docs/plugin-loading.md) for every load path and the two
dead ends not to re-attempt.
