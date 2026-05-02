---
name: write-a-skill
description: Create new Claude skills with proper structure, description format, and bundled reference docs. Use when user wants to create, write, or build a new skill for this repository.
---

# Writing a Skill

## Process

1. **Gather requirements** — ask:
   - What task/domain does the skill cover?
   - What specific use cases should it handle?
   - Does it need scripts or just instructions?
   - Any reference materials to include?

2. **Draft the skill** — create:
   - `SKILL.md` with concise instructions (keep under ~100 lines)
   - Additional reference files if content would exceed that
   - Utility scripts for deterministic operations

3. **Review with user** — present draft and confirm:
   - Does this cover your use cases?
   - Anything missing or unclear?

## SKILL.md Template

```md
---
name: skill-name
description: One sentence of what it does. Use when [specific triggers / keywords].
---

# Skill Name

## Quick start

[Minimal working example]

## Workflows

[Step-by-step processes]

## Advanced

See [REFERENCE.md](REFERENCE.md) for detailed docs.
```

## Description Rules

The description is **the only thing Claude sees** when deciding which skill to load.

- Max 1024 chars
- First sentence: capability
- Second sentence: `Use when [triggers]`

Good: `Write and debug JS in n8n Code nodes. Use when working in n8n Code nodes with JavaScript.`
Bad: `Helps with code.`

## When to split files

Split into separate files when:
- `SKILL.md` exceeds ~100 lines
- Content has clearly distinct domains
- Advanced features are rarely needed

## When to add scripts

Add a `scripts/` folder when:
- The operation is deterministic (validation, formatting)
- The same code would be generated repeatedly
- Errors need explicit handling

## After drafting — checklist

- [ ] Description includes `Use when...` triggers
- [ ] `SKILL.md` under ~100 lines
- [ ] No time-sensitive information
- [ ] Entry added to `.claude-plugin/plugin.json`
- [ ] Entry added to top-level `README.md`
- [ ] Entry added to category `README.md`
