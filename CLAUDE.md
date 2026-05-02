# Psilo Skills — Contributor Guide

Skills are organized into category folders under `skills/`:

- `n8n/` — n8n workflow automation skills
- `productivity/` — general workflow tools, not domain-specific
- `deprecated/` — no longer maintained; kept for reference only

## Rules

Every skill in `n8n/` or `productivity/` must have:
1. An entry in `.claude-plugin/plugin.json`
2. An entry in the top-level `README.md` skills table (with a link to its `SKILL.md`)
3. An entry in its category `README.md`

Skills in `deprecated/` must NOT appear in `plugin.json` or the top-level `README.md`.

## Adding a skill

1. Create `skills/<category>/<skill-name>/SKILL.md`
2. Add reference docs alongside it if needed (keep `SKILL.md` under ~100 lines)
3. Add the path to `.claude-plugin/plugin.json`
4. Add a row to the skills table in `README.md`
5. Add a bullet to the category `README.md`

## Skill description format

The description field in `SKILL.md` frontmatter is **the only thing Claude sees** when deciding which skill to load. Write it carefully:

- Max 1024 characters
- First sentence: what it does
- Second sentence: `Use when [specific triggers / keywords]`

**Good:** `Write and debug JavaScript in n8n Code nodes. Use when working in n8n Code nodes with JavaScript or when the user mentions n8n JS expressions.`

**Bad:** `Helps with n8n code.`

## File structure per skill

```
skill-name/
├── SKILL.md        # required — main instructions, keep under ~100 lines
├── REFERENCE.md    # optional — detailed docs when SKILL.md would get too long
├── EXAMPLES.md     # optional — usage examples
└── scripts/        # optional — deterministic helper scripts
```

## Deprecating a skill

Move the folder to `skills/deprecated/` and remove it from `plugin.json` and both READMEs.
