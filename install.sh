#!/usr/bin/env bash
# ============================================================
#   CLAUDE OS — Install Script
#   https://github.com/royaluniondesign-sys/claude-os
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

# --- Requirements check ---
echo -e "${BOLD}Checking requirements...${RESET}"

if ! command -v node &>/dev/null; then
  echo -e "${RED}✗ Node.js not found. Install from https://nodejs.org${RESET}"; exit 1
fi
echo -e "${GREEN}✓ Node.js $(node --version)${RESET}"

if ! command -v python3 &>/dev/null; then
  echo -e "${YELLOW}⚠ Python 3 not found. SEO skills will be limited.${RESET}"
else
  echo -e "${GREEN}✓ Python $(python3 --version)${RESET}"
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

# --- 1. Everything Claude Code ---
echo -e "${CYAN}[1/4] Installing Everything Claude Code (agents, skills, commands, rules, hooks)...${RESET}"
TMP_ECC=$(mktemp -d)
git clone --depth 1 https://github.com/affaan-m/everything-claude-code.git "$TMP_ECC/ecc" 2>/dev/null
cp -r "$TMP_ECC/ecc/agents/." "$CLAUDE_DIR/agents/"
cp -r "$TMP_ECC/ecc/skills/." "$CLAUDE_DIR/skills/"
cp -r "$TMP_ECC/ecc/commands/." "$CLAUDE_DIR/commands/"
cp "$TMP_ECC/ecc/hooks/hooks.json" "$CLAUDE_DIR/hooks.json" 2>/dev/null || true
# Install rules
for lang in common typescript python golang; do
  mkdir -p "$CLAUDE_DIR/rules/$lang"
  [ -d "$TMP_ECC/ecc/rules/$lang" ] && cp -r "$TMP_ECC/ecc/rules/$lang/." "$CLAUDE_DIR/rules/$lang/"
done
rm -rf "$TMP_ECC"
echo -e "${GREEN}  ✓ $(ls "$CLAUDE_DIR/agents/" | wc -l | tr -d ' ') agents, $(ls "$CLAUDE_DIR/skills/" | wc -l | tr -d ' ') skills, $(ls "$CLAUDE_DIR/commands/"*.md 2>/dev/null | wc -l | tr -d ' ') commands, 4 rulesets${RESET}"

# --- 2. Get Shit Done ---
echo -e "${CYAN}[2/4] Installing GSD — Spec-Driven Development System...${RESET}"
npx get-shit-done-cc@latest --claude --global 2>/dev/null | grep -E "✓|Done"
echo -e "${GREEN}  ✓ $(ls "$CLAUDE_DIR/commands/gsd/"*.md 2>/dev/null | wc -l | tr -d ' ') GSD commands, $(ls "$CLAUDE_DIR/agents/gsd-"*.md 2>/dev/null | wc -l | tr -d ' ') GSD agents${RESET}"

# --- 3. DesktopCommanderMCP ---
echo -e "${CYAN}[3/4] Installing DesktopCommanderMCP...${RESET}"
npx @wonderwhy-er/desktop-commander@latest setup --no-onboarding 2>/dev/null | grep -E "✅|successfully"
echo -e "${GREEN}  ✓ desktop-commander MCP configured${RESET}"

# --- 4. Claude SEO ---
echo -e "${CYAN}[4/4] Installing Claude SEO skills...${RESET}"
TMP_SEO=$(mktemp -d)
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git "$TMP_SEO/seo" 2>/dev/null
bash "$TMP_SEO/seo/install.sh" 2>/dev/null | grep -E "✓|installed"
# Fix dependencies if needed
if [ -f "$CLAUDE_DIR/skills/seo/.venv/bin/pip" ]; then
  "$CLAUDE_DIR/skills/seo/.venv/bin/pip" install --upgrade pip -q
  "$CLAUDE_DIR/skills/seo/.venv/bin/pip" install "Pillow>=11.0.0" -q
  "$CLAUDE_DIR/skills/seo/.venv/bin/pip" install -r "$CLAUDE_DIR/skills/seo/requirements.txt" -q 2>/dev/null || true
fi
rm -rf "$TMP_SEO"
echo -e "${GREEN}  ✓ $(ls "$CLAUDE_DIR/skills/seo-"* 2>/dev/null | wc -l | tr -d ' ') SEO skills installed${RESET}"

# --- Summary ---
echo ""
echo -e "${PURPLE}${BOLD}════════════════════════════════════════════${RESET}"
echo -e "${GREEN}${BOLD}  Claude OS installed successfully!${RESET}"
echo -e "${PURPLE}${BOLD}════════════════════════════════════════════${RESET}"
echo ""
echo -e "  ${GREEN}✓${RESET} ${BOLD}Agents:${RESET}   $(ls "$CLAUDE_DIR/agents/" | wc -l | tr -d ' ')"
echo -e "  ${GREEN}✓${RESET} ${BOLD}Commands:${RESET} $(( $(ls "$CLAUDE_DIR/commands/"*.md 2>/dev/null | wc -l | tr -d ' ') + $(ls "$CLAUDE_DIR/commands/gsd/"*.md 2>/dev/null | wc -l | tr -d ' ') ))"
echo -e "  ${GREEN}✓${RESET} ${BOLD}Skills:${RESET}   $(ls "$CLAUDE_DIR/skills/" | wc -l | tr -d ' ')"
echo -e "  ${GREEN}✓${RESET} ${BOLD}Rules:${RESET}    $(ls "$CLAUDE_DIR/rules/" | wc -l | tr -d ' ') languages"
echo -e "  ${GREEN}✓${RESET} ${BOLD}MCP:${RESET}      desktop-commander"
echo ""
echo -e "  ${CYAN}Open a project in Claude Code and run:${RESET}"
echo -e "  ${BOLD}/gsd:new-project${RESET}   — Start a new project with full architecture"
echo -e "  ${BOLD}/gsd:help${RESET}          — See all available commands"
echo -e "  ${BOLD}/orchestrate${RESET}       — Launch multi-agent workflow"
echo ""
