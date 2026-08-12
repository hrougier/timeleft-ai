# GitHub access for the plugins

How a session gets to the code, and what its credential is allowed to do.

**Nothing here is a step Claude can perform.** Creating accounts, registering apps, minting
tokens, handling passkeys and entering them anywhere are human acts; a session can prepare
exact values and verify the result afterwards, never do it.

## The requirement

The product plugin's skills **read** three private repositories to ground product decisions
(`code-repository.md` holds the rules for how they read and how findings are phrased):

- `timeleft-dev/timeleft-os` — TOS, the back-office
- `timeleft-dev/timeleft-monorepo` — the mobile app
- `timeleft-dev/timeleft-backend` — the backend

Read-only, default branch, and never a word of it repeated in code terms. Most POs have no
GitHub account and should never need one of their own — which is the constraint the whole
design follows from.

## Why an App replaces the OAuth App

The claude.ai code route currently authenticates through a **GitHub OAuth App**, whose scopes
are account-wide: `repo`, the only scope granting private-repo read, also grants write across
every repository the signing-in human can reach. A **GitHub App** replaces it because its
permissions are per-repository and declared up front, and because it accepts several callback
URLs where an OAuth App accepts one. Read-only for code eyes is enforced by the MCP endpoint
(`…/mcp/x/repos/readonly`) plus the App's `Contents: Read-only`.

## What the connector dialog actually offers (checked 2026-08-12)

A custom connector has two connection methods, and only one of them is usable:

- **Individual sign-in** — each member signs in to connect. Available, and therefore the
  design constraint: *somebody* signs in.
- **Managed authorization** (Beta) — "each member is connected through your identity
  provider". Its *Request access* button is inert for us. And it would not have helped
  anyway: it federates each member's **own** identity through the IdP, so every PO would
  still need a GitHub identity behind the mapping. It is not an admin-entered shared token.
  (An earlier note in this repo described a `static_headers` fixed-token mechanism on this
  surface — that was wrong, and is retracted.)

There is no humanless path here. The only way to remove the human entirely would be to host
our own minimal MCP server holding the token server-side — a service to run, not a setting
to toggle. Recorded as the proper fix for later, not chosen now.

## The design: one machine account, shared by passkey

Since someone must sign in, everyone signs in as the same machine account.

### The account

**`timeleft-bot`** (`github@timeleft.com`), created 2026-08-12. GitHub permits machine
accounts: registered by a named human who accepts the terms on its behalf, used for automated
tasks, with multiple people directing its actions. One human owns it and is answerable for it.

It is an **org member** of `timeleft-dev`, so it carries the org's
`default_repository_permission`, which is **write** — admin on `timeleft-os`, write elsewhere.
**PO decision, 2026-08-12: this is accepted as-is.** The read-only guarantee for code eyes
rests on the MCP endpoint (`…/mcp/x/repos/readonly`) and the App's permissions, not on the
account's own access. A session reading code still obeys `code-repository.md` — reads only,
findings in product language — because that rule never depended on the credential.

Consequence to keep in view rather than re-argue: the passkey below reaches an account that
can write, so **its vault membership is the boundary**. Offboarding means removing the passkey,
revoking the account's sessions, and rotating.

### How people sign in: a passkey in 1Password

- The account's password, TOTP and GitHub recovery codes live in a **restricted** vault the
  owner alone opens — break-glass, not the daily path.
- A **passkey** on the account lives in a **1Password shared vault** the product team can
  reach. It must be **created with 1Password as the authenticator, choosing the shared vault in
  the save dialog** — a passkey made anywhere else (Keychain, a browser profile, a phone) cannot
  be exported or copied in afterwards. Its private key never leaves the authenticator that
  minted it; that is the point of a passkey. A wrongly-placed one gets deleted from the GitHub
  account and re-created, not moved. That is what POs use: no password in the flow, nothing to paste into a chat, and it
  is phishing-resistant because a passkey is bound to github.com's origin. Revocation is
  deleting the item and removing the key from the account.
- Each PO needs the 1Password browser extension (or app), and the item in a vault their
  account can see.
- Tell them once: while signed in that way they are **acting as `timeleft-bot`** on
  github.com. A separate browser profile, or signing in only for the connector flow, avoids
  mistaking that session for their own.

## The two GitHub Apps

**Both are owned by the `timeleft-dev` organization, not by `timeleft-bot`.** This is
mechanical, not stylistic: an App owned by a personal account is either installable *only on
that account* — useless, since the repositories are the org's — or must be made **publicly
installable by anyone**. Org ownership keeps it private to the org, lets org owners manage it,
and survives the bot account being rotated or deleted.

**An App is not linked to the account that signs in through it.** The App is the OAuth client;
`timeleft-bot` is the user. Two independent roles: the App's permissions cap what any token can
do, the account decides whose access is used.

### App 1 — code eyes (the connector)

| Setting | Value |
| ------- | ----- |
| Owner | `timeleft-dev` |
| Repository permissions | `Contents: Read-only`, `Metadata: Read-only` |
| Organization / account permissions | none |
| Webhooks | off |
| Callback URL | the connector's — `https://claude.ai/api/mcp/auth_callback`; if the flow rejects it, the error names the URI it wanted, and an App accepts several |
| Installed on | the three repositories above |

Put its client ID and a generated client secret into the connector's **Advanced settings**
(the dialog's *OAuth Client ID* / *OAuth Client Secret* fields). **The endpoint URL does not
change**, so the plugin's `.mcp.json` needs no edit. Connection method: **Individual sign-in**
— POs sign in as `timeleft-bot` with the shared passkey.

### App 2 — release-please

| Setting | Value |
| ------- | ----- |
| Owner | `timeleft-dev` |
| Repository permissions | `Contents: Write`, `Pull requests: Write` |
| Installed on | the repositories that publish releases |

Chosen over a PAT for three reasons that hold regardless of anything else: an App **consumes
no license seat** (the org is at 24/24), the token is **minted per workflow run** via
`actions/create-github-app-token` so nothing long-lived sits in a secret store, and an App
token **triggers downstream workflows** where `GITHUB_TOKEN` does not — which is the actual
reason release-please setups reach for a PAT in the first place.

One App could technically serve both flows. Keep them separate mainly for attribution: release
commits, tags and PRs are authored by the App that made them, so a shared App would put the
code-eyes client's name through your changelog history.

## Forward note: the tech plugin needs write access

`implement-issue`, `address-pr-review`, `merge-pr` and friends create branches, open PRs and
merge them. That is a **separate credential** — its own GitHub App with `Contents: write`,
`Pull requests: write`, `Issues: write`, and a real human identity behind it, because writes
need attribution. It must never be this App, this account, or this passkey: the moment one
credential serves both rosters, product's read-only guarantee is gone.

## Checklist

Human steps, in order:

- [x] Create the `github@timeleft.com` account — **done 2026-08-12**, login `timeleft-bot`
- [x] Give it org access — **done**, as an org member (see the note above)
- [ ] Password + TOTP + recovery codes into the **restricted** vault; name its owner
- [ ] Add a passkey to the account; store it in the product team's **shared** 1Password vault
- [x] Register **App 1** under `timeleft-dev`; install on the three repositories — **done
      2026-08-12**, App `Timeleft GitHub MCP`, webhooks off, `Contents`/`Metadata: Read-only`,
      both callback URLs, *Only on this account*. Client ID and secret live in 1Password, not
      here — a repo is the wrong home for half a credential pair whoever can read it
- [x] Put App 1's client ID/secret into the connector's Advanced settings — **done
      2026-08-12**, connector reconnects and reads. Field-tested: an existing custom connector
      **cannot be edited** on claude.ai, so this meant deleting and recreating it. The endpoint
      URL must come back character-for-character —
      `https://api.githubcopilot.com/mcp/x/repos/readonly`, matching `.mcp.json` — because
      claude.ai matches a plugin's declared servers to connectors **by URL**
- [ ] Have one PO connect end to end with the passkey, on claude.ai
- [ ] Delete the old OAuth App once that works
- [ ] Register **App 2** under `timeleft-dev`; wire release-please to
      `actions/create-github-app-token`
- [ ] Add the passkey-removal + session-revocation step to the product-team offboarding
      runbook

A session can verify the result afterwards: read one file from each of the three
repositories, and confirm a write is refused. That check runs on **claude.ai**, where the
connector lives — a terminal session's GitHub access is a different credential and proves
nothing about this one.

## Parked, kept here so they don't get lost

Neither is a GitHub-access step; both are adjacent enough that losing them would cost this
work, and neither was written down anywhere until now.

- [ ] **Push `timeleft-dev/timeleft-ai`.** Local commits reach no PO until pushed — claude.ai
      installs from the marketplace synced against the remote. Gated on the trial below
      passing.
- [ ] **Trial run from `hrougier/timeleft-ai` first** (pushed 2026-08-12): install the product
      plugin from the personal remote and run `setup-product-ai` end to end, as a PO would.
      The marketplace works from either remote — `marketplace.json`'s `source` paths are
      repo-relative and name no host — so the docs pointing at `timeleft-dev` while the trial
      installs from `hrougier` is cosmetic, not a fault.
- [ ] **Rename the board at the moment of the move**: *Team Plugins HQ* → **Product Roadmap
      Board v2**, in the same act that moves it into the product team's space. The name it
      carries today is the name of a build effort; the name it needs is the one a PO landing
      beside the production board will understand. Page IDs do not change on a rename, so no
      binding moves with it.
- [x] **Move the repo to `timeleft-dev`** — done 2026-08-12: `timeleft-dev/timeleft-ai`,
      **private**, which settles the *public by decision* question the personal repo left open
      and puts the repo under the same org that owns both Apps.
