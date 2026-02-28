#!/usr/bin/env bash
# ============================================================
#   Claude OS — New Project Bootstrap
#   Usage: ./scripts/new-project.sh <template> <project-name>
#   Example: ./scripts/new-project.sh nextjs-fullstack my-app
# ============================================================

set -euo pipefail

CYAN='\033[0;36m'; GREEN='\033[0;32m'; RED='\033[0;31m'; BOLD='\033[1m'; RESET='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$REPO_DIR/templates"

TEMPLATE="${1:-}"
PROJECT_NAME="${2:-}"

# List available templates
if [ -z "$TEMPLATE" ]; then
  echo -e "${BOLD}Available templates:${RESET}"
  for dir in "$TEMPLATES_DIR"/*/; do
    name="$(basename "$dir")"
    desc=""
    [ -f "$dir/CLAUDE.md" ] && desc=$(head -3 "$dir/CLAUDE.md" | tail -1)
    echo -e "  ${CYAN}$name${RESET}  $desc"
  done
  echo ""
  echo "Usage: $0 <template> <project-name>"
  exit 0
fi

if [ -z "$PROJECT_NAME" ]; then
  echo -e "${RED}Error: project name required${RESET}"
  echo "Usage: $0 $TEMPLATE <project-name>"
  exit 1
fi

TEMPLATE_DIR="$TEMPLATES_DIR/$TEMPLATE"
if [ ! -d "$TEMPLATE_DIR" ]; then
  echo -e "${RED}Template '$TEMPLATE' not found.${RESET}"
  exit 1
fi

PROJECT_DIR="$(pwd)/$PROJECT_NAME"

echo -e "${CYAN}${BOLD}Creating project: $PROJECT_NAME${RESET}"
echo -e "Template: $TEMPLATE"
echo -e "Location: $PROJECT_DIR"
echo ""

# Create project directory
mkdir -p "$PROJECT_DIR"

# Copy template contents
cp -r "$TEMPLATE_DIR/." "$PROJECT_DIR/"

# Copy Claude OS base agents and commands
mkdir -p "$PROJECT_DIR/.claude/agents" "$PROJECT_DIR/.claude/commands"

# Rename template CLAUDE.md if exists
[ -f "$PROJECT_DIR/CLAUDE.md" ] && echo -e "${GREEN}✓ CLAUDE.md configured${RESET}"

echo ""
echo -e "${GREEN}${BOLD}Project '$PROJECT_NAME' created!${RESET}"
echo ""
echo -e "Next steps:"
echo -e "  ${CYAN}cd $PROJECT_NAME${RESET}"
echo -e "  ${CYAN}claude${RESET}   (open Claude Code)"
echo -e "  ${CYAN}/gsd:new-project${RESET}   (start with full architecture)"
