#!/usr/bin/env bash
# ============================================================
#   Claude OS — Install PostgreSQL MCP
#   Gives Claude direct database access: queries, schema, migrations
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
  echo "Manually merge mcp-configs/postgresql.json into your Claude config."
  exit 1
fi

echo -e "${CYAN}Installing PostgreSQL MCP...${RESET}"

read -sp "PostgreSQL connection string (postgresql://user:pass@host:5432/db): " PG_URL
echo ""

if [ -z "$PG_URL" ]; then
  echo -e "${YELLOW}Skipping — no connection string provided.${RESET}"
  exit 0
fi

# Add to Claude config safely via environment variables
mkdir -p "$(dirname "$CLAUDE_CONFIG")"
[ -f "$CLAUDE_CONFIG" ] || echo '{"mcpServers":{}}' > "$CLAUDE_CONFIG"

CLAUDE_CONFIG_PATH="$CLAUDE_CONFIG" MCP_PG_URL="$PG_URL" python3 -c '
import json, os

config_path = os.environ["CLAUDE_CONFIG_PATH"]
pg_url = os.environ["MCP_PG_URL"]

with open(config_path) as f:
    config = json.load(f)

config.setdefault("mcpServers", {})["postgresql"] = {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-postgres", pg_url]
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)
'

chmod 600 "$CLAUDE_CONFIG"

echo -e "${GREEN}Done! Restart Claude to activate PostgreSQL MCP.${RESET}"
echo ""
echo "Claude will now be able to:"
echo "  - Query your database directly"
echo "  - Inspect schema, tables and indexes"
echo "  - Run migrations and seeds"
echo "  - Optimize slow queries"
