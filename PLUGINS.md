# External Plugins

Third-party Claude plugins used by the Psilo Digital team. These are tracked here as submodules for version pinning — not owned or maintained by us.

---

## GSD — Get Shit Done

| | |
|---|---|
| **Repo** | https://github.com/gsd-build/get-shit-done |
| **Pinned at** | `external/gsd` submodule |
| **Current version** | 1.39.0-rc.4 |

A project management and execution framework for Claude Code. Provides `/gsd-*` commands for planning phases, executing work, reviewing, debugging, and more.

### Install

Follow the official instructions at the [GSD repo](https://github.com/gsd-build/get-shit-done).

### Update to latest

```bash
git submodule update --remote external/gsd
git add external/gsd
git commit -m "chore: update GSD submodule to latest"
git push
```

> This updates the pinned commit for the whole team. Everyone picks it up on next `git pull`.

### Check current pinned version

```bash
cat external/gsd/package.json | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['version'])"
```

---

## Adding a new external plugin

1. `git submodule add <repo-url> external/<name>`
2. Add an entry to this file with version, install instructions, and update command
3. Commit `.gitmodules`, `external/<name>`, and `PLUGINS.md`
