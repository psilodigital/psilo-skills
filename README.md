# Psilo Skills

A curated collection of Claude skills and plugins built by [Psilo Digital](https://psilodigital.com) — for our team, our clients, and anyone who wants to level up their Claude workflow.

## Quick Install

**One-click via Claude plugin marketplace** _(coming soon)_ — or install now:

**Clone & install (team / contributors):**
```bash
git clone git@github.com:psilodigital/psilo-skills.git
cd psilo-skills
./install.sh
```

**One-liner for clients (no git required):**
```bash
curl -sSL https://raw.githubusercontent.com/psilodigital/psilo-skills/main/install.sh | bash
```

Install a specific category only:
```bash
curl -sSL https://raw.githubusercontent.com/psilodigital/psilo-skills/main/install.sh | bash -s -- n8n
```

Restart Claude Code — skills are available as `/skill-name` commands.

**Filter installs (if cloned):**
```bash
./install.sh n8n                     # all n8n skills
./install.sh n8n-code-javascript     # one specific skill
./install.sh --list                  # see everything available
./install.sh --uninstall             # remove all psilo skills
```

**Stay up to date:**
```bash
git pull   # directory symlinks auto-update — no re-install needed
```

---

## Skills

### Productivity

| Skill | Command | Description |
|-------|---------|-------------|
| [Grill Me](./skills/productivity/grill-me/SKILL.md) | `/grill-me` | Stress-test any plan or design through relentless one-at-a-time questioning |
| [Write a Skill](./skills/productivity/write-a-skill/SKILL.md) | `/write-a-skill` | Create new skills with proper structure, description format, and reference docs |

### n8n

| Skill | Command | Description |
|-------|---------|-------------|
| [n8n Code — JavaScript](./skills/n8n/n8n-code-javascript/SKILL.md) | `/n8n-code-javascript` | Write & debug JavaScript in n8n Code nodes |
| [n8n Code — Python](./skills/n8n/n8n-code-python/SKILL.md) | `/n8n-code-python` | Write & debug Python in n8n Code nodes |
| [n8n Expression Syntax](./skills/n8n/n8n-expression-syntax/SKILL.md) | `/n8n-expression-syntax` | Master n8n expressions and templating syntax |
| [n8n MCP Tools Expert](./skills/n8n/n8n-mcp-tools-expert/SKILL.md) | `/n8n-mcp-tools-expert` | Use MCP tools effectively inside n8n workflows |
| [n8n Node Configuration](./skills/n8n/n8n-node-configuration/SKILL.md) | `/n8n-node-configuration` | Configure any n8n node correctly |
| [n8n Validation Expert](./skills/n8n/n8n-validation-expert/SKILL.md) | `/n8n-validation-expert` | Validate and debug n8n workflow errors |
| [n8n Workflow Patterns](./skills/n8n/n8n-workflow-patterns/SKILL.md) | `/n8n-workflow-patterns` | Common n8n workflow architecture patterns |

---

## Structure

```
.claude-plugin/
  plugin.json          # marketplace manifest — lists all public skills
skills/
  n8n/
    README.md
    <skill-name>/
      SKILL.md         # Claude skill definition
      *.md             # reference docs (accessible via relative paths)
  productivity/
    README.md
    <skill-name>/
      SKILL.md
  deprecated/
    README.md          # retired skills, not in plugin.json
install.sh             # symlink installer / uninstaller
CLAUDE.md              # contributor rules
```

## Contributing

See [CLAUDE.md](./CLAUDE.md) for the full contributor guide. Quick version:

1. Add your skill under `skills/<category>/<skill-name>/SKILL.md`
2. Add its path to `.claude-plugin/plugin.json`
3. Add a row to the table above (with a link to `SKILL.md`)
4. Add a bullet to the category `README.md`
5. Open a PR

---

Built by [Psilo Digital](https://psilodigital.com)
