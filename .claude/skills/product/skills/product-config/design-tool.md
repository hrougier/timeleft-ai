# Design tool

The binding for `/design-prd`'s design-artifact branch. The skill speaks abstractly —
"a design artifact, several takes, made to be reacted to" — and this doc binds the
medium, the ritual, and the capture. Sibling of `issue-tracker.md` (the tracker) and
`code-repository.md` (the code), both in this same `config` skill: recipes for your hands, not your mouth.

## The medium: Claude design by default

**Where Claude design works, every prototype ticket starts there** — the
**`claude-design` MCP, shipped with this plugin** (`.mcp.json`): create the project, build
the takes there, link the chosen one. A behavior or flow question exports as a live
prototype; a static mock is judged as the page it is.

**It is a Claude Code capability, and that is the whole of it.** Its sign-in exists there and
nowhere else, so **on claude.ai there is nothing to connect and nothing to fix**: a session
that finds no `claude-design` tools has learned which surface it is on, not that something is
broken. Never send anyone to the connectors screen for it, never ask an admin to repair it,
and never investigate the error page its sign-in fallback may show — that page is Anthropic's
infrastructure, not this team's configuration, and diagnosing it burns a session on a wall
that isn't ours. Say which surface does the job and move on.

So on claude.ai the fallback is simply **the medium**: a **self-contained interactive HTML
artifact**, said plainly and without apology — the takes are still radically different, still
switchable in place, still one link. Reserve "fall back and say so" language for the case that
is genuinely degraded: Claude Code with the MCP unreachable or unauthenticated. Either way: all takes in one deliverable,
switchable in place — several radically different takes, one link (MP's UI-prototype
pattern) — and the chosen take's link is the handoff whatever the question was.

**Figma (claude.ai connector) only when the human names it, or the deliverable has to
live in Figma** — an existing Figma design system to extend, a tech-side process that
consumes Figma files. "The artifact is the handoff" is not a reason: that rule routed
a session to Figma on 2026-08-09 and the PO redirected it to Claude design — the
handoff is the chosen take's link, whichever medium made it. If Figma still looks
right, say why in one line and ask before creating anything there. When used: the
connector's design tools, `/figma-use` guidance where present; one file, one frame
(or page) per take.

**One project (or file) per prototype ticket**, named `<PRD handle> — <the ticket's
question, shortened>` (e.g. *TOS never winks back — the surprise*), all takes inside
it. A second prototype session on the same ticket reuses the project; a new ticket
gets a new one. The workspace stays navigable by the same names the map uses.

## Takes

Two or three, **radically different** — takes that differ only in padding teach
nothing. Skip the polish until one is chosen. The rejected takes are the throwaway
part: discard them, or leave them in the same project (in Figma, on an "explorations"
page) — either way, **the captured link points only at the chosen one**.

## The reaction ritual

HITL, always: the human reacts take by take, then the ticket's folded **review
prompts** are put to them one at a time, *against the artifact* — answered by
pointing at the thing, not by describing it. The agent never answers its own
prompts.

## Capture (the chosen take is durable)

- The chosen take's URL → the ticket's **`Artifact`** property **and** the PRD's
  **`Figma`** property — the property keeps its name for prod-board compatibility;
  any design URL belongs there, artifact links included.
- The verdict and each review prompt's answer → the ticket's **`## Resolution`**
  body section, per the tracker doc's resolve act (gist, `Resolved by`/`on`, the phase
  flip, fold-back, and rev bump all ride the same package). Resolving the ticket does
  **not** move the PRD off `In Design` — it's the map's last ticket, so the PRD is already
  where `send-prd-to-dev` picks it up. The icon stays as it was — it is the ticket's type,
  not its state.

## Ground in the real surface

When the ticket's question changes an **existing** surface, every take starts from
that surface **as it really is** — read it through `code-repository.md` (read-only,
as ever) and reproduce its actual structure: the real dialog, the real header, the
real neighbors of the thing being changed. The takes then *modify that reality*
differently; they never invent a parallel surface. A reaction to fiction teaches
nothing — the question is always "how does *our* screen feel with this on it."
Design from blank only when the surface itself is new.

## Register, in the artifact itself

The artifact speaks product: real copy in the product's vocabulary (glossary terms —
a mock that says "Reject picture" teaches; one that says "ACTION_LABEL" doesn't),
plausible data, the company's surfaces. No engineering placeholders, no lorem ipsum
where a real sentence would change the reaction.
