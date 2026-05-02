#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_TARGET="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
SKILLS_SOURCE="$REPO_DIR/skills"

# Colors
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

usage() {
  cat <<EOF
Usage: ./install.sh [OPTIONS] [SKILL_NAME|CATEGORY]

Install Psilo skills as symlinks into ~/.claude/skills/

OPTIONS:
  --list        List all available skills
  --uninstall   Remove installed symlinks
  --dry-run     Show what would be installed without doing it
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
  find "$SKILLS_SOURCE" -name "SKILL.md" | sort | while read -r skill_file; do
    rel="${skill_file#$SKILLS_SOURCE/}"           # category/skill-name/SKILL.md
    category=$(echo "$rel" | cut -d'/' -f1)
    skill=$(echo "$rel" | cut -d'/' -f2)
    installed=""
    [[ -L "$SKILLS_TARGET/${skill}.md" ]] && installed=" ${GREEN}[installed]${NC}"
    echo -e "  ${YELLOW}${category}${NC}/${skill}${installed}"
  done
}

install_skill() {
  local skill_file="$1"
  local rel="${skill_file#$SKILLS_SOURCE/}"
  local skill
  skill=$(echo "$rel" | cut -d'/' -f2)
  local target="$SKILLS_TARGET/${skill}.md"

  if [[ "$DRY_RUN" == true ]]; then
    echo "  [dry-run] Would link: ${skill}.md → ${skill_file}"
    return
  fi

  mkdir -p "$SKILLS_TARGET"
  ln -sf "$skill_file" "$target"
  echo -e "  ${GREEN}✓${NC} ${skill}"
}

uninstall_skill() {
  local skill_file="$1"
  local rel="${skill_file#$SKILLS_SOURCE/}"
  local skill
  skill=$(echo "$rel" | cut -d'/' -f2)
  local target="$SKILLS_TARGET/${skill}.md"

  if [[ -L "$target" ]]; then
    [[ "$DRY_RUN" == true ]] && echo "  [dry-run] Would remove: ${skill}.md" && return
    rm "$target"
    echo -e "  ${RED}✗${NC} ${skill} (removed)"
  fi
}

# Parse args
FILTER=""
DRY_RUN=false
ACTION="install"

while [[ $# -gt 0 ]]; do
  case $1 in
    --list)        list_skills; exit 0 ;;
    --uninstall)   ACTION="uninstall" ;;
    --dry-run)     DRY_RUN=true ;;
    -h|--help)     usage; exit 0 ;;
    *)             FILTER="$1" ;;
  esac
  shift
done

echo -e "${GREEN}Psilo Skills Installer${NC}"
echo -e "Target: ${SKILLS_TARGET}\n"

matched=0
while IFS= read -r skill_file; do
  rel="${skill_file#$SKILLS_SOURCE/}"
  category=$(echo "$rel" | cut -d'/' -f1)
  skill=$(echo "$rel" | cut -d'/' -f2)

  # Filter: match category OR skill name prefix OR exact
  if [[ -n "$FILTER" ]]; then
    [[ "$category" != "$FILTER" && "$skill" != "$FILTER" && "$skill" != *"$FILTER"* ]] && continue
  fi

  [[ "$ACTION" == "install" ]] && install_skill "$skill_file"
  [[ "$ACTION" == "uninstall" ]] && uninstall_skill "$skill_file"
  ((matched++))
done < <(find "$SKILLS_SOURCE" -name "SKILL.md" | sort)

if [[ $matched -eq 0 ]]; then
  echo -e "${RED}No skills matched '${FILTER}'. Run --list to see available skills.${NC}"
  exit 1
fi

echo -e "\n${matched} skill(s) processed."
[[ "$ACTION" == "install" ]] && echo -e "${GREEN}Done! Restart Claude Code to pick up new skills.${NC}"
