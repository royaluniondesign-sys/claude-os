#!/usr/bin/env bash
# ============================================================
#   Claude OS — Install GitHub MCP
#   Gives Claude direct access to GitHub: PRs, issues, CI/CD
# ============================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; RESET='\033[0m'

# Detect config path by OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  CLAUDE_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
elif [[ "$OSTYPE" == "linux"* ]]; then
  CLAUDE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/claude/claude_desktop_config.json"
else
  echo -e "${RED}Unsupported OS: $OSTYPE${RESET}"
  echo "Manually merge mcp-configs/github.json into your Claude config."
  exit 1
fi

echo -e "${CYAN}Installing GitHub MCP...${RESET}"

# Check for GitHub token
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo -e "${YELLOW}GITHUB_TOKEN not set.${RESET}"
  echo "Create a token at: https://github.com/settings/tokens"
  echo ""
  read -sp "Enter your GitHub token (or press Enter to skip): " token
  echo ""
  if [ -n "$token" ]; then
    GITHUB_TOKEN="$token"
  else
    echo "Skipping — set GITHUB_TOKEN in your shell profile and re-run."
    exit 0
  fi
fi

# Add to Claude config safely via environment variables
mkdir -p "$(dirname "$CLAUDE_CONFIG")"
[ -f "$CLAUDE_CONFIG" ] || echo '{"mcpServers":{}}' > "$CLAUDE_CONFIG"

CLAUDE_CONFIG_PATH="$CLAUDE_CONFIG" MCP_TOKEN="$GITHUB_TOKEN" python3 -c '
import json, os

config_path = os.environ["CLAUDE_CONFIG_PATH"]
token = os.environ["MCP_TOKEN"]

with open(config_path) as f:
    config = json.load(f)

config.setdefault("mcpServers", {})["github"] = {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-github"],
    "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": token}
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)
'

chmod 600 "$CLAUDE_CONFIG"

echo -e "${GREEN}Done! Restart Claude to activate GitHub MCP.${RESET}"
echo ""
echo "Claude will now be able to:"
echo "  - Create and review pull requests"
echo "  - Manage issues and milestones"
echo "  - Read repository contents and commits"
echo "  - Trigger and monitor GitHub Actions"
