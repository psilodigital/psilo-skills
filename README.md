# Psilo Skills

A curated collection of Claude skills and plugins built by [Psilo Digital](https://psilodigital.com) — for our team, our clients, and anyone who wants to level up their Claude workflow.

## What's this?

Each skill in this repo is a ready-to-use Claude plugin that adds a slash command or automated behavior to Claude Code / Claude Apps. Browse, copy, or install in one click.

## Skills

| Skill | Description | Category |
|-------|-------------|----------|
| _coming soon_ | | |

## One-click install

> Install any skill directly into your Claude app via the plugin marketplace or local setup.

### Via Plugin Marketplace _(coming soon)_

Each skill will include a marketplace link for one-click install into your Claude app.

### Local Setup

1. Clone this repo:
   ```bash
   git clone https://github.com/psilodigital/psilo-skills.git
   ```
2. Navigate into a skill folder and follow its `README.md`.
3. Copy the skill definition into your Claude project's `.claude/` directory.

## Structure

```
psilo-skills/
├── skills/
│   └── <skill-name>/
│       ├── README.md        # What it does, how to install
│       ├── skill.md         # Skill definition (Claude prompt/config)
│       └── settings.json    # Optional hook/permission config
└── README.md
```

## Contributing

Internal team: open a PR with your skill in `skills/<skill-name>/`. Include a README and a working `skill.md`.

---

Built with love by [Psilo Digital](https://psilodigital.com)
