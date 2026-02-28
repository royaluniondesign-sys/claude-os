#!/usr/bin/env bash
# ============================================================
#   Claude OS — Install GitHub MCP
#   Gives Claude direct access to GitHub: PRs, issues, CI/CD
# ============================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; RESET='\033[0m'

echo -e "${CYAN}Installing GitHub MCP...${RESET}"

# Check for GitHub token
if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo -e "${YELLOW}⚠ GITHUB_TOKEN not set.${RESET}"
  echo "Create a token at: https://github.com/settings/tokens"
  echo "Then run: export GITHUB_TOKEN=your_token"
  echo ""
  read -p "Enter your GitHub token (or press Enter to skip): " token
  if [ -n "$token" ]; then
    GITHUB_TOKEN="$token"
  else
    echo "Skipping — add GITHUB_TOKEN to your shell profile and re-run."
    exit 0
  fi
fi

# Install via npx
npx -y @modelcontextprotocol/server-github 2>/dev/null || true

# Add to Claude config
CLAUDE_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
if [ ! -f "$CLAUDE_CONFIG" ]; then
  mkdir -p "$(dirname "$CLAUDE_CONFIG")"
  echo '{"mcpServers":{}}' > "$CLAUDE_CONFIG"
fi

python3 - <<EOF
import json, os

config_path = os.path.expanduser("~/Library/Application Support/Claude/claude_desktop_config.json")
with open(config_path) as f:
    config = json.load(f)

config.setdefault("mcpServers", {})["github"] = {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-github"],
    "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": "$GITHUB_TOKEN"}
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)

print("✓ GitHub MCP added to Claude config")
EOF

echo -e "${GREEN}Done! Restart Claude to activate GitHub MCP.${RESET}"
echo ""
echo "Claude will now be able to:"
echo "  • Create and review pull requests"
echo "  • Manage issues and milestones"
echo "  • Read repository contents and commits"
echo "  • Trigger and monitor GitHub Actions"
