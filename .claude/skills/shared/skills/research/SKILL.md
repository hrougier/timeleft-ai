---
name: research
description: Investigate a question against high-trust primary sources and hand back cited findings. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
---

<!-- Vendored from mattpocock/skills skills/engineering/research at 2ab9580, with one audited patch (C1: the destination becomes the caller's) — see this plugin's lock.md. -->

Spin up a **background agent** to do the research, so you keep working while it reads.

Its job:

1. Investigate the question against **primary sources** — official docs, source code, specs, first-party APIs — not a secondary write-up of them. Follow every claim back to the source that owns it.
2. Write the findings up in one place, citing each claim's source.
3. **Where they are recorded belongs to whoever asked, not to you.** If the session already carries a binding that says where findings land — a tracker doc, a repo convention — follow it. If it carries none, hand the findings back and say where you would put them; do not invent a destination and do not write into a repo by default.
