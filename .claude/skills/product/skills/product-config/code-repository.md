# Code repository

This plugin's skills may **read** the company's code to ground product decisions —
never to write it, and never to talk about it in code terms. An implementation fact
enters a session as a **product fact** or it doesn't enter at all.

## Repositories

| Product surface        | Repository                     | What lives here |
| ---------------------- | ------------------------------ | --------------- |
| TOS (the back-office)  | `timeleft-dev/timeleft-os`     | the web app teams use to run events, cities, venues, users |
| The mobile app         | `timeleft-dev/timeleft-monorepo` | the app members hold |
| The backend            | `timeleft-dev/timeleft-backend` | what the app and TOS both talk to |

All three are private GitHub repositories, **read over the network** — no local clone
is assumed and none is required, so a session reads the same code on any machine and
in the cloud. Read the **default branch**: never a feature branch, never someone's
fork, never a working copy that happens to be on disk. What ships is what counts.

**Use whatever GitHub access this surface has.** Two routes, same repositories, same
default branch, same rules — take the first one available:

1. **The `gh` CLI**, where a shell exists and it is authenticated:

   ```
   gh search code --repo timeleft-dev/<repo> '<terms>'     # where does this live?
   gh api repos/timeleft-dev/<repo>/contents/<path> \
     -H 'Accept: application/vnd.github.raw'               # read one file
   ```

2. **A GitHub connector's tools**, where there is no shell — claude.ai and similar.
   The plugin ships a read-only repository connector, but **a connector the settings
   page calls connected is not the same as tools in your hand**: on some surfaces the
   plugin's server is folded into the host's own GitHub integration, which browses
   files for a human and exposes nothing a session can call. So the test is never what
   the settings say. It is your own tool list. **Discover the tools available to you
   rather than assuming names**; if they are deferred, load them before the first
   call. Where they exist, they serve the same two moves — search code within a
   repository, then read a file's contents — scoped to one of the three repositories
   above, on the default branch.

   Where they don't, **this surface has no code route**, and that is the finding: say
   "this surface can't reach the code; in Claude Code it can", rather than reporting a
   connector fault the human has no way to act on. Where they exist but every
   repository answers 404, the missing piece is the org's approval of the GitHub app —
   not your query, and not something retrying will fix.

Neither route is a fallback for the other — they are the same capability on different
surfaces. Check for both before concluding you have no code access.

If no route is available, or a repository answers 404 or refuses access, **say so and
stop** — an unreachable repo is a stated gap in the answer, never a gap you fill by
inferring. Name which route you tried, so the gap is fixable rather than mysterious.

## Read-only, eyes-only

- **Reads only.** Never clone, edit, commit, branch, open an issue or PR, install, or
  run anything. The permission layer is the backstop; the rule stands regardless.

  The credential is meant to agree with the rule rather than merely permit it: the
  intended shape is a GitHub App (or a fine-grained token) carrying `Contents: read` and
  `Metadata: read` on these three repositories and nothing more, so a write is refused by
  GitHub and not only by discipline. `docs/github-access.md` in this repo holds the setup
  and the human steps. Until that lands, the route may still be an account-wide credential
  whose read-only-ness rests on the endpoint — which changes nothing about what you may
  do, and is a reason to be stricter rather than looser.
- **Delegate the reading where you can.** Code is noisy and a PO session's context is
  no place for it. Spin up a throwaway read-only agent, point it at this doc, hand it
  the *product question* — "can a user delete their own profile photo today?", "what
  does rejecting a photo actually do?" — and take back only its findings. The agent's
  context is where the technical vocabulary lives and dies; yours never holds it.

  **Where no subagent exists, read it yourself — narrowly, and answer in product terms
  anyway.** Delegation is how the vocabulary is kept out of a PO's session, not a
  precondition for reading code at all: a surface without subagents makes the rule
  harder to keep, not inapplicable. Ask one question at a time, read the least that
  answers it, and state the finding as behavior. Never quote what you read back into
  the conversation or the PRD.
- **Findings speak product.** What comes back — from the agent, and from you to the
  human or the PRD — is behavior, capability, and effort shape:
  - *behavior* — "rejecting a photo hides it from everyone, but the photo stays stored"
  - *capability* — "the full-size photo already exists; showing it larger creates no new data"
  - *effort shape* — "small change" · "touches one surface" · "deep change across the
    app and the backend". Never hours, never estimates dressed as facts.
  - **Never**: file paths, function or table names, code snippets, framework or
    service names. A finding that can't be said without them isn't a finding yet —
    say what it *means for the user* instead.
- **Claims verify against code the way bugs reproduce.** A Slack thread saying "the
  photo is stored full-size" is a claim; the code is the source. Verify before a
  problem statement asserts it — and say which claims were verified and which are
  still someone's word.

## When a skill says…

- **"explore the codebase" / "search for an existing implementation"** (triage) — the
  redundancy check runs here too: does the product already do what's asked, on any
  surface? Found = already-implemented `wontfix`, pointing at where it lives *in
  product terms* ("moderators already have this, under a different name").
- **"verify the claim"** (triage) — implementation claims relayed by requesters are
  checked here before the PRD repeats them.
- **"primary sources"** (research) — the code is a primary source for "what does the
  product do today"; findings land on the ticket in product language like any other
  source, each claim marked verified-in-code or reported-by.

- **charting a map** (refining) — the busiest consumer, and the least obvious. A question
  whose answer is a *current-behaviour fact* is answered here, in the charting
  conversation, and never becomes a ticket: nobody has to decide it, and a product manager
  is not expected to know it, so putting it to them produces an honest "I don't know" that
  reads exactly like a hesitation. Look it up instead — delegated, one question at a time,
  the answer in product language — and carry the fact into the map, where it makes the
  *real* questions sharp. The tracker doc's creating-a-ticket act holds the sort and the
  three cases where a ticket is right anyway (a survey, a data question, or no code route
  on this surface).

  Keep it proportionate: a couple of lookups is charting, ten is an audit wearing
  charting's clothes. And the register rule does not soften because the session is
  conversational — what comes back into a PO's charting conversation is behaviour and
  capability, never a file, a function or a framework.
