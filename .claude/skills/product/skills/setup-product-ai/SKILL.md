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

Missing → **Settings → Customize → Plugins**, and install **Shared Toolkit** — that's its
name on that screen. **Browse** lists what the catalogue offers; **Add** is for when the
catalogue itself isn't there yet. If it's in neither, ask them what the screen shows
rather than guessing further.

Never a command. `/plugin` does not exist in claude.ai chat, and a product lead should not
be learning commands in any case.

Re-check before continuing: on some surfaces the skills only appear after reloading, and
"it's installed now" is not the same as "this session can see it".

### 2. The PRD board

Load the tracker doc from the **`product-config`** skill and try two reads: the HQ page
and the Workflow Contract page.

Two different failures hide behind one symptom, and the fix is different for each:

- **No Notion connector** — the tools aren't in your hand at all. **Settings → Customize
  → Connectors → Not connected**, find **Notion**, **Connect**, sign in. Then reload so
  this session picks the tools up.
- **Connector fine, pages unreachable** — the board isn't shared with them. Somebody with
  access has to share the HQ page; nothing they do alone will fix it.

Say which of the two it is. Guessing sends someone to the wrong screen.

If the Workflow Contract page can't be read, say that plainly and stop recommending work:
no skill may move a PRD without it.

### 3. The code

The plugin reads three private repositories to ground product decisions. Read the rules
in **`product-config`**'s code binding, then read one small file from each repository —
one is not enough, because installation is per-repository and two can work while the
third was never added.

**The route that counts is the one this person will actually use, and for a product
manager that is the GitHub MCP connector.** Two routes exist — the `gh` command line where
a shell exists, and the connector where there isn't one — but they are not
interchangeable *here*, because this skill's whole job is to verify what the human in
front of you can reach. Discover the tools you actually have rather than assuming their
names; if they are deferred, load them first.

So: **a `gh` pass is never a pass for the connector.** If this session has a shell and the
command line works, that proves the repositories exist and are readable *by whoever owns
that shell* — it says nothing about the connector a PO will be using, and reporting it as
a pass hands them a green light for a route they don't have. Check the connector on its own
terms and report the two separately. Where both exist, the connector is the one whose
failure matters.

What a failure means:

- **No connector, but a working shell** → say plainly that the code route works *for this
  session* and is unverified for anyone on claude.ai, then check the connector anyway. A
  builder's machine passing is the most misleading result this skill can produce.
- **No tools and no shell** → this surface has no code route. That's the finding, not a
  fault: say the reading works in Claude Code and move on. Don't send anyone to a
  settings page over it.
- **Connector present but not connected** → **Settings → Customize → Connectors**, find
  **GitHub MCP** — the row badged *Custom*. It's published for the whole organisation, so
  it's in everyone's list like any other, but **each person connects it once themselves**.

  **`GitHub Integration` in that same list is a different connector and not the one.** It
  is Claude's own GitHub integration, it is often already connected, and connecting it does
  nothing for this plugin. Anyone searching that list for "GitHub" sees both. Name the
  right row, every time.

  Connecting signs them in as the team's shared machine account with the **passkey in the
  product team's 1Password vault** — no password, and nothing to type into a chat. If they
  can't see that vault, that's the gap: a vault-membership request to whoever owns it, not
  a GitHub problem, and nothing they can fix on the connectors screen.
- **Every repository answers 404** → the app isn't installed on them. An organisation
  owner fixes that; retrying won't.
- **One repository answers 404** → that one repository was missed at install. Name which.

**Never test read-only-ness by attempting a write.** The rule is reads only, and a skill
that breaks it to prove a point has broken it. Whether the credential *refuses* writes is
a question for whoever set it up, checked once, outside a PO's session.

### 4. The design tool

Answering a design question starts in **Claude design**, which ships with this plugin and
needs a one-time sign-in and a paid plan. Check the tools are in hand; on the connectors
screen it's the row named **claude-design**, also badged *Custom*.

Missing → report it as a **limitation, not a blocker**: design questions still get
answered, as a self-contained page instead of a shared design file. Everything else in the
plugin works. Don't inflate this into a failed setup.

### 5. The PRD template — the one thing no setup can do for you

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
3. **End on the handover**: what they do, and that you will re-check when they say it's
   done. One action, one gate.

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
