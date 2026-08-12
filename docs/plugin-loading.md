# How these plugins load

Four environments, no repo-side registration files. (Distilled from the app repo's
`plugin-loading.md`, where every row was field-tested on tos v1; the marketplace row was
field-tested here on 2026-08-08.)

| Environment | Load path | Freshness |
| --- | --- | --- |
| **Local CLI** | Skills-directory auto-discovery: any `.claude/skills/*/` dir carrying a `.claude-plugin/plugin.json` loads as a plugin (`product@skills-dir`) | **Live** — always the working tree, branch checkouts included |
| **Desktop Home / Cowork** | `/plugin marketplace add hrougier/timeleft-ai`, then install `product` — field-tested 2026-08-08 **on Desktop, not in claude.ai chat**. Skills mount; `.mcp.json` registers the plugin's servers as connectors, matched **by URL**; hooks and sub-agents do **not** run here (per Anthropic's docs they run in Cowork) | **Follows the remote** — an unpushed commit changes nothing, and the Update button greys out because the catalog sees no newer version |
| **claude.ai chat** | Same catalog, **UI only — `/plugin` does not exist here** (corrected 2026-08-12; the row above previously claimed it did). Installing is a screen in settings, so every instruction aimed at a PO is a menu and a button, never a command. Loads and matches connectors as the Desktop row does | As above — follows the remote |
| **Claude cloud** (org access bundle) | The bundle ships the plugin as a zip, present from session start. Source: this repo, configured org-side (admin console → Plugins), auto-sync on, manual **Re-sync** as fallback | **Auto-synced** (cadence undocumented) |
| **No bundle** (web / DMs) | Nothing loads plugins — the attached clone still carries every skill file; read `.claude/skills/product/skills/ask-prd-ai/SKILL.md` and follow it by hand | Read it from the tree |

Rules that fall out of this:

- **Placement is the registration.** The plugins live under `.claude/skills/` because
  that path *is* what the CLI discovers. There is no install step for local work:
  clone, open, the skills are there.
- **Root `.claude-plugin/marketplace.json` is the catalog** read both by
  `/plugin marketplace add` and, later, by the admin console when this repo becomes the
  org's plugin source. It does nothing locally — placement already covers that.
- **Never register via `.claude/settings.json`** (`extraKnownMarketplaces` +
  `enabledPlugins`). Field-tested in the app repo and removed: cloud attach-time
  install ignores project-level marketplaces, and locally it shadows the live
  skills-dir copy behind a version-pinned cache.
- **Bump `version` in each plugin's `.claude-plugin/plugin.json` on skill changes** —
  it gates nothing locally; it is the update signal everywhere else. Marketplace
  installs offer Update only when the catalog's version exceeds the installed one, so a
  pushed change without a bump lands for nobody. A session reporting an old version
  means either the bump is missing, the commit is unpushed, or sync lagged — check in
  that order.
