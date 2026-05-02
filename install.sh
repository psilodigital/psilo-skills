#!/usr/bin/env bash
set -euo pipefail

# Links all skills in the repository to ~/.claude/skills/ as directory symlinks,
# so all reference docs are accessible via relative paths when a skill runs.

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

usage() {
  cat <<EOF
Usage: ./install.sh [OPTIONS] [SKILL_NAME|CATEGORY]

Install Psilo skills as directory symlinks into ~/.claude/skills/

OPTIONS:
  --list        List all available skills
  --uninstall   Remove installed symlinks
  --dry-run     Show what would happen without doing it
  -h, --help    Show this help

EXAMPLES:
  ./install.sh                     # Install all skills
  ./install.sh n8n                 # Install all skills in the n8n category
  ./install.sh n8n-code-javascript # Install one specific skill
  ./install.sh --list              # See all available skills
  ./install.sh --uninstall         # Remove all psilo skill symlinks
EOF
}

list_skills() {
  echo -e "${GREEN}Available skills:${NC}\n"
  find "$REPO/skills" -name "SKILL.md" \
    -not -path "*/deprecated/*" | sort | while read -r skill_file; do
    rel="${skill_file#$REPO/skills/}"
    category=$(echo "$rel" | cut -d'/' -f1)
    skill=$(echo "$rel" | cut -d'/' -f2)
    installed=""
    [[ -L "$DEST/$skill" ]] && installed=" ${GREEN}[installed]${NC}"
    echo -e "  ${YELLOW}${category}${NC}/${skill}${installed}"
  done
}

# Bail if ~/.claude/skills is itself a symlink into this repo
if [ -L "$DEST" ]; then
  resolved="$(readlink -f "$DEST")"
  case "$resolved" in
    "$REPO"|"$REPO"/*) echo -e "${RED}error:${NC} $DEST is a symlink into this repo. Run: rm \"$DEST\"" >&2; exit 1 ;;
  esac
fi

FILTER=""
DRY_RUN=false
ACTION="install"

while [[ $# -gt 0 ]]; do
  case $1 in
    --list)      list_skills; exit 0 ;;
    --uninstall) ACTION="uninstall" ;;
    --dry-run)   DRY_RUN=true ;;
    -h|--help)   usage; exit 0 ;;
    *)           FILTER="$1" ;;
  esac
  shift
done

echo -e "${GREEN}Psilo Skills Installer${NC}"
echo -e "Target: ${DEST}\n"

matched=0
while IFS= read -r -d '' skill_file; do
  src="$(dirname "$skill_file")"
  skill="$(basename "$src")"
  rel="${skill_file#$REPO/skills/}"
  category=$(echo "$rel" | cut -d'/' -f1)
  target="$DEST/$skill"

  # Filter by category or skill name
  if [[ -n "$FILTER" ]]; then
    [[ "$category" != "$FILTER" && "$skill" != "$FILTER" && "$skill" != *"$FILTER"* ]] && continue
  fi

  if [[ "$ACTION" == "install" ]]; then
    if [[ "$DRY_RUN" == true ]]; then
      echo "  [dry-run] Would link: ${skill}/ → ${src}"
    else
      mkdir -p "$DEST"
      # Remove existing file or broken symlink; preserve real dirs
      [[ -e "$target" && ! -L "$target" ]] && rm -rf "$target"
      ln -sfn "$src" "$target"
      echo -e "  ${GREEN}✓${NC} ${skill}"
    fi
  else
    if [[ -L "$target" ]]; then
      [[ "$DRY_RUN" == true ]] && echo "  [dry-run] Would remove: ${skill}" && ((matched++)) && continue
      rm "$target"
      echo -e "  ${RED}✗${NC} ${skill} (removed)"
    fi
  fi
  ((matched++))
done < <(find "$REPO/skills" -name "SKILL.md" -not -path "*/deprecated/*" -print0 | sort -z)

if [[ $matched -eq 0 ]]; then
  echo -e "${RED}No skills matched '${FILTER}'. Run --list to see available skills.${NC}"
  exit 1
fi

echo -e "\n${matched} skill(s) processed."
[[ "$ACTION" == "install" && "$DRY_RUN" == false ]] && echo -e "${GREEN}Done! Restart Claude Code to pick up new skills.${NC}"
