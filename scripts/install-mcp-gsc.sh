#!/usr/bin/env bash
# ============================================================
#   Claude OS — Install Google Search Console MCP
#   Gives Claude access to GSC data: rankings, clicks, coverage
# ============================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; RESET='\033[0m'

echo -e "${CYAN}Installing Google Search Console MCP...${RESET}"
echo ""
echo "Prerequisites:"
echo "  1. Go to: https://console.cloud.google.com/apis/credentials"
echo "  2. Create OAuth 2.0 credentials (Desktop app)"
echo "  3. Download the credentials JSON file"
echo ""

read -p "Path to credentials JSON file: " CREDS_PATH

if [ ! -f "$CREDS_PATH" ]; then
  echo -e "${YELLOW}File not found. Skipping.${RESET}"
  exit 0
fi

# Install mcp-gsc
pip3 install mcp-gsc 2>/dev/null || pip install mcp-gsc 2>/dev/null || {
  echo "pip install failed. Try: pip3 install mcp-gsc"
  exit 1
}

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

config.setdefault("mcpServers", {})["gsc"] = {
    "command": "python3",
    "args": ["-m", "mcp_gsc"],
    "env": {"GOOGLE_CREDENTIALS_PATH": "$CREDS_PATH"}
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)

print("✓ Google Search Console MCP added to Claude config")
EOF

echo -e "${GREEN}Done! Restart Claude to activate GSC MCP.${RESET}"
echo ""
echo "Claude will now be able to:"
echo "  • Pull search performance data (clicks, impressions, CTR)"
echo "  • Identify ranking opportunities and drops"
echo "  • Analyze page indexing and coverage issues"
echo "  • Cross-reference with SEO audits"
