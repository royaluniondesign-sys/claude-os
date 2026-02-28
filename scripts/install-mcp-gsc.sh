#!/usr/bin/env bash
# ============================================================
#   Claude OS — Install Google Search Console MCP
#   Gives Claude access to GSC data: rankings, clicks, coverage
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
  echo "Manually merge mcp-configs/gsc.json into your Claude config."
  exit 1
fi

echo -e "${CYAN}Installing Google Search Console MCP...${RESET}"
echo ""
echo "Prerequisites:"
echo "  1. Go to: https://console.cloud.google.com/apis/credentials"
echo "  2. Create OAuth 2.0 credentials (Desktop app)"
echo "  3. Download the credentials JSON file"
echo ""

read -p "Path to credentials JSON file: " CREDS_PATH

if [ -z "$CREDS_PATH" ] || [ ! -f "$CREDS_PATH" ]; then
  echo -e "${YELLOW}File not found. Skipping.${RESET}"
  exit 0
fi

# Resolve to absolute path
CREDS_PATH="$(cd "$(dirname "$CREDS_PATH")" && pwd)/$(basename "$CREDS_PATH")"

# Install mcp-gsc
pip3 install mcp-gsc 2>/dev/null || pip install mcp-gsc 2>/dev/null || {
  echo -e "${RED}pip install failed. Try: pip3 install mcp-gsc${RESET}"
  exit 1
}

# Add to Claude config safely via environment variables
mkdir -p "$(dirname "$CLAUDE_CONFIG")"
[ -f "$CLAUDE_CONFIG" ] || echo '{"mcpServers":{}}' > "$CLAUDE_CONFIG"

CLAUDE_CONFIG_PATH="$CLAUDE_CONFIG" MCP_CREDS="$CREDS_PATH" python3 -c '
import json, os

config_path = os.environ["CLAUDE_CONFIG_PATH"]
creds_path = os.environ["MCP_CREDS"]

with open(config_path) as f:
    config = json.load(f)

config.setdefault("mcpServers", {})["gsc"] = {
    "command": "python3",
    "args": ["-m", "mcp_gsc"],
    "env": {"GOOGLE_CREDENTIALS_PATH": creds_path}
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)
'

chmod 600 "$CLAUDE_CONFIG"

echo -e "${GREEN}Done! Restart Claude to activate GSC MCP.${RESET}"
echo ""
echo "Claude will now be able to:"
echo "  - Pull search performance data (clicks, impressions, CTR)"
echo "  - Identify ranking opportunities and drops"
echo "  - Analyze page indexing and coverage issues"
echo "  - Cross-reference with SEO audits"
