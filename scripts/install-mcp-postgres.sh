#!/usr/bin/env bash
# ============================================================
#   Claude OS — Install PostgreSQL MCP
#   Gives Claude direct database access: queries, schema, migrations
# ============================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; RESET='\033[0m'

echo -e "${CYAN}Installing PostgreSQL MCP...${RESET}"

read -p "PostgreSQL connection string (postgresql://user:pass@host:5432/db): " PG_URL

if [ -z "$PG_URL" ]; then
  echo -e "${YELLOW}Skipping — no connection string provided.${RESET}"
  exit 0
fi

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

config.setdefault("mcpServers", {})["postgresql"] = {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-postgres", "$PG_URL"]
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)

print("✓ PostgreSQL MCP added to Claude config")
EOF

echo -e "${GREEN}Done! Restart Claude to activate PostgreSQL MCP.${RESET}"
echo ""
echo "Claude will now be able to:"
echo "  • Query your database directly"
echo "  • Inspect schema, tables and indexes"
echo "  • Run migrations and seeds"
echo "  • Optimize slow queries"
