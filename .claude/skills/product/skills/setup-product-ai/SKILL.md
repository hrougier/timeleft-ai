---
name: setup-product-ai
description: Check that everything this plugin needs is actually reachable — the shared skills, the PRD board, the code, the design tool — and walk you through connecting whatever is missing. Run it after installing the plugin, or any time something says it can't reach the board.
---

# Setup

Run once per person, after installing. Run again whenever a session says it can't reach
something — this is the skill that tells you *which* thing and *what to click*.

**This skill writes nothing.** No PRD, no ticket, no property, no comment. It reads, it
reports, and it hands you clicks. So it never asks for a yes, and the confirmation line
never appears here.

## The voice exception

Every other skill in this plugin is forbidden to name machinery. **This one has to** —
the human is being asked to click things, and a click has a name. So:

- Name what they see in their own settings: **the Notion connector**, **the GitHub MCP
  connector**, **Claude design**, **the shared plugin**. Those are labels on their screen.
- Still never say a tool name, a `mcp__…` string, a data source id, or a property name.
  "The board isn't reachable" — not which call failed.
- Everything else holds: answer first, one idea per line, an opinion not a menu, and end
  with who does what next.

One report at the end, not a running commentary. Check everything first — the checks are
independent, so run them together — then give the whole verdict once. A PO who has to
watch four checks arrive one at a time is doing your job.

## Where these live on claude.ai (checked 2026-08-12)

Say it once, then refer back to it. From the **account name at the bottom-left** →
**Settings**. In that panel, under the **Customize** heading, three entries:
**Skills · Connectors · Plugins**.

Two traps in that panel, both of which waste someone's afternoon:

- **There are two Connectors entries.** The one under *Settings* is a dead end that just
  says connectors have moved. The live one is under **Customize**.
- **Plugins are listed by their display names**, not the names used here: **Shared
  Toolkit** and **Product Team**. Someone told to look for "shared" will not find it.

On the Connectors page: filters **All / Connected / Not connected**, a search, and an
**Add** button. A connected connector shows a tick; one that isn't shows a **Connect**
button. **Not connected** is the fastest filter to send someone to.

## What to check

**In this order, and the order matters**: the plugins first, because a plugin arrives with
its own connectors declared and installing it can change what the connectors screen offers —
checking connectors before the plugins are in means reporting gaps that install themselves.
Then **every connector they can actually act on, in one pass**, so a person visits that
screen once, in tiers: `Notion` and the org's `GitHub MCP` are what the workflow **needs**;
`Slack` is **advised** — without it a glossary term can only be checked against the
conversation, so terms get written down as unverified; `Figma` is **offered**, worth a click
only if they already work in it. Name each with its status, even the ones that pass — a
connector you didn't mention is one a PO assumes you never checked.

**`claude-design` is not on that list on claude.ai**, because it cannot be connected there
(check 4). Mention it as a surface fact in its own line, never as a row to go and find — a
connector named in a list of things to connect is a thing a person will try to connect.

Take them in this order. The first failure that blocks everything is the shared plugin;
past that, each gap is independent and worth reporting even if an earlier one failed.

### 1. The shared plugin

Three of the acts this plugin routes to live in a separate plugin: researching a
question, grilling a decision, and adding a term to the glossary.

**The honest test is your own skill list, not a settings page** — a plugin the catalog
calls installed may not have mounted. But **test the one name only we could have shipped**:
look for **`glossary-and-decisions`**. That name is ours; nothing else ships it.

**`research` and `grilling` prove nothing on their own, and trusting them is how this check
lied once already** — reporting the shared plugin as present to someone who had never
installed it. Both are Matt Pocock's own skill names, so anyone with his marketplace added,
or another plugin that vendored them, has skills called exactly that. On claude.ai the chat
surface shows no plugin prefix, so a bare `research` in your list is a name with no
provenance. Seeing all three where one of them is the distinctive one is fine; seeing only
the two generic ones is **absence**, not presence.

If the distinctive name is missing, say the plugin is missing — and if the list is somehow
ambiguous, ask them what **Settings → Customize → Plugins** shows rather than deciding from
a name. This is the same trap as two connectors both called GitHub: a name that looks right
is not the thing.

Missing → the exact path, all of it, because every vague step here is a person hunting
through settings:

> **Settings → Customize → Plugins → Browse → Your organization**, search for the plugin,
> then click the **+** button beside it to install.

Search a distinctive word — *shared*, or *product* — rather than a full name: what the
catalogue shows can differ from what the plugin calls itself, and a search that returns
nothing reads as "we don't have it" when the name was simply different. **Shared Toolkit**
is the one wanted here.

If **Your organization** is empty or absent, the plugins were never published to this
person — that is somebody else's errand, not a click of theirs, and worth saying so plainly.
If the screen doesn't look like this at all, ask them what they see instead of guessing
further.

Never a command. `/plugin` does not exist in claude.ai chat, and a product lead should not
be learning commands in any case.

Re-check before continuing: on some surfaces the skills only appear after reloading, and
"it's installed now" is not the same as "this session can see it".

### 2. The PRD board

Load the tracker doc from the **`product-config`** skill and try two reads: **Product
Roadmap Board v2** and the Workflow Contract page under it.

Two different failures hide behind one symptom, and the fix is different for each:

- **No Notion connector** — the tools aren't in your hand at all. **Settings → Customize
  → Connectors → Not connected**, find **Notion**, **Connect**, sign in. Then reload so
  this session picks the tools up.
- **Connector fine, pages unreachable** — the board isn't shared with them, or their Notion
  account isn't in the space that holds it. Somebody with access has to share **Product
  Roadmap Board v2**; nothing they do alone will fix it. Worth naming the board by that exact
  title, since it sits beside the production **Product Roadmap Board** and asking a colleague
  to "share the roadmap board" gets the wrong one.

Say which of the two it is. Guessing sends someone to the wrong screen.

If the Workflow Contract page can't be read, say that plainly and stop recommending work:
no skill may move a PRD without it.

### 3. The code

The plugin reads three private repositories to ground product decisions. Read the rules
in **`product-config`**'s code binding, then read one small file from each repository —
one is not enough, because installation is per-repository and two can work while the
third was never added.

**The route is the GitHub MCP connector. There is no other one here.** This skill runs for
product managers on claude.ai, who have no shell and never will — so the connector is not
the fallback, it is the whole check. Discover the tools you actually have rather than
assuming their names; if they are deferred, load them first, then read one small file from
each repository.

Whatever else this session might happen to have — another way in, an authenticated command
line, a route that works for whoever is driving — **is not evidence about the connector and
is never reported as a pass.** It would hand a PO a green light for something they don't
have. The connector answers for itself or it doesn't.

What a failure means:

- **No GitHub MCP tools in this session** → it isn't connected here. **Settings → Customize
  → Connectors**, find **GitHub MCP** — the row badged *Custom*. It's published for the whole
  organisation, so it's in everyone's list like any other, but **each person connects it once
  themselves**.

  **`GitHub Integration` in that same list is a different connector and not the one.** It is
  Claude's own GitHub integration, it is often already connected, and connecting it does
  nothing for this plugin. Anyone searching that list for "GitHub" sees both. Name the right
  row, every time.

  **Neither connection implies the other — field-tested 2026-08-12, in both directions.**
  Connecting **GitHub MCP** leaves `GitHub Integration` disconnected, and having
  `GitHub Integration` connected does nothing for the code route. So two readings are wrong
  and both are easy: *"GitHub is connected, so the code should work"* (the wrong row), and
  *"I connected the plugin's one, why does the other still say disconnected"* (nothing is
  broken — it is simply unrelated and can stay that way). Say which row you mean, and say
  that the other one doesn't matter.

  Connecting signs them in as the team's shared machine account with the **passkey in the
  product team's 1Password vault** — no password, and nothing to type into a chat. If they
  can't see that vault, that's the gap: a vault-membership request to whoever owns it, not a
  GitHub problem, and nothing they can fix on the connectors screen.

  If **GitHub MCP** isn't in the list at all, it was never published to them — say so,
  because that is somebody else's errand, not a click of theirs.
- **Every repository answers 404** → the app isn't installed on them. An organisation
  owner fixes that; retrying won't.
- **One repository answers 404** → that one repository was missed at install. Name which.

**Never test read-only-ness by attempting a write.** The rule is reads only, and a skill
that breaks it to prove a point has broken it. Whether the credential *refuses* writes is
a question for whoever set it up, checked once, outside a PO's session.

### 4. The design tool

Answering a design question starts in **Claude design** where it exists — and on claude.ai
it does not. **It is a Claude Code capability**, so a session here finding no
`claude-design` tools has learned which surface it is on. That is the finding.

**Nothing to connect, nothing to fix, nothing to look up.** Do not list it among the
connectors to go and connect. Do not send them to the connectors screen for it. Do not ask
an admin to repair it. And if a sign-in attempt has already produced an error page — a
retired endpoint, a stale URL, anything of that shape — **that page is Anthropic's
infrastructure, not this team's configuration**: say so in one line and stop. Searching the
web to diagnose it spends a session on a wall that isn't ours, and hands a PO an errand that
cannot succeed.

What to say instead, once: design questions get answered here as a **self-contained
interactive page** rather than a shared design file — that is the medium on this surface, not
a degradation — and the shared-file route is there in Claude Code if they ever want it.
Everything else in the plugin works. Never inflate this into a failed setup.

**Figma is offered, not required — and the question is whether *they* work in it.** The
workflow's default medium is Claude design and stays that way: design questions go there
unless a human names Figma or the deliverable has to live in it (an existing design system
to extend, a tech-side process that consumes Figma files).

So mention it once, as a question rather than a gap: if Figma is part of how they already
work, connecting it now means the design skill can reach it the day they ask for it, instead
of stopping mid-session to set up a connector. If they don't work in Figma, say plainly that
there is nothing to do and nothing lost — **Settings → Customize → Connectors**, the
**Figma** row, one click whenever they want it.

Never report its absence as a gap, and never let it read as a second thing to fix while a
real blocker is open. It is the one connector whose answer is a preference.

### 5. Slack — strongly advised, not required

Nothing breaks without it, and two things get worse. Terms: a glossary row is meant to be
verified against **how the company already talks**, and Slack is where that is — without it,
a term can only be checked against this conversation, which is how a plugin ends up teaching
everyone a word nobody uses. And requests: most arrive as a Slack thread, so triage can read
the thread that started it rather than a paraphrase of it.

Missing → **Settings → Customize → Connectors**, connect **Slack**. Frame it as strongly
advised: the plugin works without it and says "unverified" where it would otherwise have
checked, which is honest but weaker than checking.

### 6. The PRD template — the one thing no setup can do for you

Ask the PRDs database for its default template.

**No template → the plugin cannot file a PRD at all.** Every PRD is born from it: the
template carries the document's sections and the two views that show a PRD its own open
questions, and the filters those views need are clicks no automation can make. There is no
fallback skeleton and improvising one is forbidden.

So this is a human act, once, for the whole team — not per person. The template's own page
carries the anatomy and the instructions, and it's linked from the Workflow Contract. If
it's missing, say plainly that filing is blocked until someone installs it, and point at
the contract page.

## How to report: a walk, not a survey

Run every check first — they are quick reads. Then **the shape of what you say depends on
whether anything needs doing**, because a person who has something to click and a person
who doesn't need opposite messages.

**Nothing needs doing** → one message. They can work: say so, name what's reachable in
plain terms, and say what to do first — describe a product problem in their own words.

**Something needs doing** → **announce the steps, then walk the first one alone.**

1. **Name the whole route in one line first**: how many things need connecting, in order,
   each in three or four words. "Two things to connect: the board, then the design tool."
   A person who knows the shape of the errand reads the rest as progress; a person handed
   four findings at once has to work out for themselves which one to do.
2. **Then only step one** — what to click, where, and who has to click it. Not step two.
   You explain a step when they reach it, because by then they may have seen something
   that changes it.
3. **End on the handover, immediately after the step**: what they do, and that you will
   re-check when they say it's done. One action, one gate — and nothing between the
   instruction and that sentence.
4. **Connectors are one visit, not one each.** Once the plugins are in, name every
   connector in a single step — the two the workflow needs, the two that are advised, and
   the one that is offered if they work in it — each with its status, so they open that
   screen once and come back once. Sort by what it costs them: blockers, then what degrades,
   then the preference. A person sent
   to the same settings page three times reasonably concludes the tool doesn't know what it
   wants.

**Nothing that needs no action may sit between the human and their next click.** A working
surface, a limitation they can't fix, a check that passed — all of it goes *after* the live
step, one line each, or waits for the end. The failing example this rule comes from led with
the blocker, then spent three paragraphs on things needing no action, and put the actual
instruction last: the one sentence that mattered was the hardest to find.

**Separate yours from someone else's.** A vault invitation and an organisation approval are
errands for different people, and mixing them into "some things need doing" strands both.

Never a table of green ticks and internal names. Never "5 checks, 4 passed" — a count is not
a finding.

## Rules

- **Reads only, throughout.** Setup proves the plugin can reach its things; it never
  changes any of them.
- **Test capability, never configuration.** A settings page saying *connected* is not a
  tool in your hand — on some surfaces a connector is folded into the host's own
  integration and exposes nothing a session can call. Your own tool list, and a real read,
  are the only evidence.
- **One board.** The addresses come from the tracker doc and nowhere else. If a check
  makes the production roadmap board look like the right target, the check is wrong.
- **Never hand them a command.** Not `/plugin`, not a sign-in command, not the name of
  this skill. They are on claude.ai, where those don't exist — and where they did exist it
  would still be the wrong instruction. Every fix is a screen, a menu, a button, and what
  it says on it. If you don't know the actual labels on their screen, say what has to
  happen and ask them to tell you what they see, rather than inventing a path that sends
  someone hunting through settings for a menu that isn't there.
- **Don't teach the workflow here.** This skill ends at "you can work now". Where to start
  is a question for the entry point — say the act ("describe the problem and I'll triage
  it"), never the command.
