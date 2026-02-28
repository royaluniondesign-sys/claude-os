#!/usr/bin/env bash
# ============================================================
#   CLAUDE OS — Install Script
#   https://github.com/royaluniondesign-sys/claude-os
#
#   Two modes:
#   1. From cloned repo: ./install.sh  (uses local files)
#   2. Via curl:         curl ... | bash (clones repo first)
# ============================================================

set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; PURPLE='\033[0;35m'; BOLD='\033[1m'; RESET='\033[0m'

CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

echo ""
echo -e "${PURPLE}${BOLD}"
echo "   ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗     ██████╗ ███████╗"
echo "  ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝    ██╔═══██╗██╔════╝"
echo "  ██║     ██║     ███████║██║   ██║██║  ██║█████╗      ██║   ██║███████╗"
echo "  ██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝      ██║   ██║╚════██║"
echo "  ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗    ╚██████╔╝███████║"
echo "   ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝     ╚═════╝ ╚══════╝"
echo -e "${RESET}"
echo -e "${CYAN}  The Ultimate AI-Powered Fullstack Development System${RESET}"
echo ""

# --- Resolve repo root ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)"
REPO_DIR=""
CLEANUP_REPO=""

# Check if running from cloned repo (local files exist)
if [ -d "$SCRIPT_DIR/.claude/agents" ] && [ "$(ls "$SCRIPT_DIR/.claude/agents/"*.md 2>/dev/null | wc -l)" -gt 0 ]; then
  REPO_DIR="$SCRIPT_DIR"
  echo -e "${GREEN}Using local repo: $REPO_DIR${RESET}"
else
  # Running via curl or outside repo — clone first
  echo -e "${CYAN}Cloning Claude OS repository...${RESET}"
  REPO_DIR=$(mktemp -d)
  CLEANUP_REPO="$REPO_DIR"
  git clone --depth 1 https://github.com/royaluniondesign-sys/claude-os.git "$REPO_DIR" 2>/dev/null
  echo -e "${GREEN}✓ Repository cloned${RESET}"
fi

echo ""

# --- Requirements check ---
echo -e "${BOLD}Checking requirements...${RESET}"

if ! command -v node &>/dev/null; then
  echo -e "${RED}✗ Node.js not found. Install from https://nodejs.org${RESET}"; exit 1
fi
echo -e "${GREEN}✓ Node.js $(node --version)${RESET}"

if ! command -v python3 &>/dev/null; then
  echo -e "${YELLOW}⚠ Python 3 not found. SEO skills will be limited.${RESET}"
else
  echo -e "${GREEN}✓ Python $(python3 --version 2>&1)${RESET}"
fi

if ! command -v git &>/dev/null; then
  echo -e "${RED}✗ Git not found.${RESET}"; exit 1
fi
echo -e "${GREEN}✓ Git $(git --version | awk '{print $3}')${RESET}"

echo ""
echo -e "${BOLD}Installing Claude OS components...${RESET}"
echo ""

# --- Create directories ---
mkdir -p "$CLAUDE_DIR"/{agents,commands/gsd,skills,hooks,rules}

# --- 1. Core components from repo ---
echo -e "${CYAN}[1/4] Installing agents, skills, commands, rules, hooks...${RESET}"
cp -r "$REPO_DIR/.claude/agents/." "$CLAUDE_DIR/agents/"
cp -r "$REPO_DIR/.claude/commands/." "$CLAUDE_DIR/commands/"

# Copy skills excluding any .venv directories (Python virtual environments)
rsync -a --exclude='.venv' --exclude='node_modules' "$REPO_DIR/.claude/skills/" "$CLAUDE_DIR/skills/" 2>/dev/null || \
  cp -r "$REPO_DIR/.claude/skills/." "$CLAUDE_DIR/skills/"

for lang_dir in "$REPO_DIR/.claude/rules"/*/; do
  lang="$(basename "$lang_dir")"
  mkdir -p "$CLAUDE_DIR/rules/$lang"
  cp -r "$lang_dir." "$CLAUDE_DIR/rules/$lang/"
done

cp "$REPO_DIR/.claude/hooks.json" "$CLAUDE_DIR/hooks.json" 2>/dev/null || true

AGENT_COUNT=$(ls "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
SKILL_COUNT=$(ls -d "$CLAUDE_DIR/skills/"*/ 2>/dev/null | wc -l | tr -d ' ')
CMD_COUNT=$(find "$CLAUDE_DIR/commands" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
RULE_COUNT=$(ls -d "$CLAUDE_DIR/rules/"*/ 2>/dev/null | wc -l | tr -d ' ')
echo -e "${GREEN}  ✓ ${AGENT_COUNT} agents, ${SKILL_COUNT} skills, ${CMD_COUNT} commands, ${RULE_COUNT} rulesets${RESET}"

# --- 2. GSD hooks and statusline ---
echo -e "${CYAN}[2/4] Installing GSD hooks, statusline, and runtime...${RESET}"
npx get-shit-done-cc@latest --claude --global 2>/dev/null | grep -E "✓|Done" || true
echo -e "${GREEN}  ✓ GSD runtime configured${RESET}"

# --- 3. DesktopCommanderMCP ---
echo -e "${CYAN}[3/4] Installing DesktopCommanderMCP...${RESET}"
npx @wonderwhy-er/desktop-commander@latest setup --no-onboarding 2>/dev/null | grep -E "✅|successfully" || true
echo -e "${GREEN}  ✓ desktop-commander MCP configured${RESET}"

# --- 4. Claude SEO Python dependencies ---
echo -e "${CYAN}[4/4] Setting up Claude SEO Python environment...${RESET}"
SEO_DIR="$CLAUDE_DIR/skills/seo"
if [ -d "$SEO_DIR" ] && command -v python3 &>/dev/null; then
  if [ ! -d "$SEO_DIR/.venv" ]; then
    python3 -m venv "$SEO_DIR/.venv" 2>/dev/null || true
  fi
  if [ -f "$SEO_DIR/.venv/bin/pip" ]; then
    "$SEO_DIR/.venv/bin/pip" install --upgrade pip -q 2>/dev/null
    "$SEO_DIR/.venv/bin/pip" install "Pillow>=11.0.0" -q 2>/dev/null
    if [ -f "$SEO_DIR/requirements.txt" ]; then
      "$SEO_DIR/.venv/bin/pip" install -r "$SEO_DIR/requirements.txt" -q 2>/dev/null || true
    fi
    echo -e "${GREEN}  ✓ SEO Python dependencies installed${RESET}"
  else
    echo -e "${YELLOW}  ⚠ Could not create Python venv. SEO visual analysis limited.${RESET}"
  fi
else
  echo -e "${YELLOW}  ⚠ SEO skill or Python not available. Skipping.${RESET}"
fi

# --- Cleanup temp repo if cloned ---
[ -n "$CLEANUP_REPO" ] && rm -rf "$CLEANUP_REPO"

# --- Make scripts executable ---
chmod +x "$REPO_DIR/scripts/"*.sh 2>/dev/null || true

# --- Summary ---
echo ""
echo -e "${PURPLE}${BOLD}════════════════════════════════════════════════════${RESET}"
echo -e "${GREEN}${BOLD}  Claude OS installed successfully!${RESET}"
echo -e "${PURPLE}${BOLD}════════════════════════════════════════════════════${RESET}"
echo ""
echo -e "  ${GREEN}✓${RESET} ${BOLD}Agents:${RESET}   ${AGENT_COUNT}"
echo -e "  ${GREEN}✓${RESET} ${BOLD}Commands:${RESET} ${CMD_COUNT}"
echo -e "  ${GREEN}✓${RESET} ${BOLD}Skills:${RESET}   ${SKILL_COUNT}"
echo -e "  ${GREEN}✓${RESET} ${BOLD}Rules:${RESET}    ${RULE_COUNT} languages"
echo -e "  ${GREEN}✓${RESET} ${BOLD}MCP:${RESET}      desktop-commander"
echo ""
echo -e "  ${CYAN}Open a project in Claude Code and run:${RESET}"
echo -e "  ${BOLD}/gsd:new-project${RESET}   — Start a new project with full architecture"
echo -e "  ${BOLD}/gsd:help${RESET}          — See all available commands"
echo -e "  ${BOLD}/orchestrate${RESET}       — Launch multi-agent workflow"
echo ""
echo -e "  ${CYAN}Optional MCPs:${RESET}"
echo -e "  ${BOLD}./scripts/install-mcp-github.sh${RESET}    — GitHub integration"
echo -e "  ${BOLD}./scripts/install-mcp-postgres.sh${RESET}  — PostgreSQL access"
echo -e "  ${BOLD}./scripts/install-mcp-gsc.sh${RESET}       — Google Search Console"
echo ""
