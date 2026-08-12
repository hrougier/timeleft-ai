#!/usr/bin/env bash
# UserPromptSubmit hook — inject the plugin's binding docs when the prompt is
# product work, once per session.
#
# Why: every `Read issue-tracker.md` is a full model round-trip before the first
# useful act. Injecting at prompt time removes 1-2 turns from every session's
# warm-up, with zero freshness risk (this script reads the same disk files at
# the moment the prompt is submitted). For UserPromptSubmit, stdout on exit 0
# is added to context.
#
# Fails open: on any error, print nothing and exit 0.

set -u
plugin_root="${1:-${CLAUDE_PLUGIN_ROOT:-}}"
plugin_data="${2:-${CLAUDE_PLUGIN_DATA:-}}"
[ -n "$plugin_root" ] && [ -d "$plugin_root" ] || exit 0

payload=$(cat 2>/dev/null) || exit 0

# Only fire on product work: an explicit /product: invocation, a PRD-ish prompt,
# or a Notion link (PRDs, tickets, and the contract all live there).
printf '%s' "$payload" | grep -qiE '/product:|\bPRDs?\b|notion\.(so|com)' || exit 0

# Once per session: a marker file keyed on the session id suppresses repeats.
# Session markers are ephemeral plugin state, so they live in the plugin's own data
# directory — never in a hand-picked corner of $HOME.
[ -n "$plugin_data" ] || exit 0

# Resolve the docs *before* the marker is written: a marker set on a run that had
# nothing to inject would suppress the injection for the rest of the session.
tracker="$plugin_root/skills/product-config/issue-tracker.md"
code="$plugin_root/skills/product-config/code-repository.md"
design="$plugin_root/skills/product-config/design-tool.md"
[ -f "$tracker" ] || exit 0

marker_dir="$plugin_data/binding-injected"
mkdir -p "$marker_dir" 2>/dev/null || exit 0
find "$marker_dir" -type f -mtime +7 -delete 2>/dev/null

if command -v jq >/dev/null 2>&1; then
  session=$(printf '%s' "$payload" | jq -r '.session_id // empty' 2>/dev/null)
else
  session=$(printf '%s' "$payload" | sed -n 's/.*"session_id"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
fi
[ -n "$session" ] || session="unknown-$(date +%Y%m%d)"
marker="$marker_dir/$session"
[ -e "$marker" ] && exit 0
touch "$marker" 2>/dev/null

echo "[product-plugin] This prompt looks like product/PRD work. If it is, load the product:ask-prd-ai skill now and follow it — it is the entry point and it routes; do not improvise the workflow around it. If this isn't product work, ignore this block. The binding docs are injected below, current as of this prompt. Do NOT Read issue-tracker.md, code-repository.md, or design-tool.md this session — this IS their full content; the skills' \"load the tracker doc whole\" is already satisfied."
echo
echo "===== issue-tracker.md ====="
cat "$tracker"
if [ -f "$code" ]; then
  echo
  echo "===== code-repository.md ====="
  cat "$code"
fi
if [ -f "$design" ]; then
  echo
  echo "===== design-tool.md ====="
  cat "$design"
fi
exit 0
