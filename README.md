# Psilo Skills

A curated collection of Claude skills and plugins built by [Psilo Digital](https://psilodigital.com) — for our team, our clients, and anyone who wants to level up their Claude workflow.

## Quick Install

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

Restart Claude Code — all skills are available as `/skill-name` commands.

**Install a single category or skill (if cloned):**
```bash
./install.sh n8n                     # all n8n skills
./install.sh n8n-code-javascript     # one specific skill
./install.sh --list                  # see everything
./install.sh --uninstall             # remove all
```

**Stay up to date:**
```bash
git pull   # symlinks auto-update — no re-install needed
```

---

## Skills

### n8n

| Skill | Command | Description |
|-------|---------|-------------|
| n8n Code — JavaScript | `/n8n-code-javascript` | Write & debug JS in n8n Code nodes |
| n8n Code — Python | `/n8n-code-python` | Write & debug Python in n8n Code nodes |
| n8n Expression Syntax | `/n8n-expression-syntax` | Master n8n expressions and templating |
| n8n MCP Tools Expert | `/n8n-mcp-tools-expert` | Use MCP tools effectively inside n8n |
| n8n Node Configuration | `/n8n-node-configuration` | Configure any n8n node correctly |
| n8n Validation Expert | `/n8n-validation-expert` | Validate and debug n8n workflows |
| n8n Workflow Patterns | `/n8n-workflow-patterns` | Common workflow architecture patterns |

---

## Structure

```
skills/
  <category>/              # domain grouping (n8n, engineering, sales…)
    <skill-name>/
      SKILL.md             # the Claude skill definition (linked to ~/.claude/skills/)
      *.md                 # reference docs loaded by the skill
install.sh                 # installer / uninstaller
```

## Contributing

1. Fork or branch
2. Add your skill under `skills/<category>/<skill-name>/SKILL.md`
3. Open a PR — include a short description in the skills table above

---

Built by [Psilo Digital](https://psilodigital.com)
