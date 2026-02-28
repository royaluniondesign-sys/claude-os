# MCP Servers

Model Context Protocol servers extend Claude with real tools — filesystem access, database queries, API integrations, and more.

---

## Included (auto-installed)

### desktop-commander
Full system control for Claude Code.

**Capabilities:**
- Execute terminal commands with output streaming
- Read/write any file (text, Excel, PDF)
- Search files by content or pattern
- Manage running processes
- Interact with SSH sessions and databases
- Negative offset file reading (like `tail`)

**Config:** `mcp-configs/desktop-commander.json`

---

## Optional MCPs

### GitHub
Direct GitHub integration.

**Capabilities:**
- Create, review and merge pull requests
- Manage issues, milestones, labels
- Read repository structure and commits
- Trigger and monitor GitHub Actions workflows
- Create and manage branches

**Install:**
```bash
./scripts/install-mcp-github.sh
```
**Config:** `mcp-configs/github.json`

---

### PostgreSQL
Direct database access.

**Capabilities:**
- Execute queries against your database
- Inspect schema, tables, indexes, constraints
- Analyze slow queries with EXPLAIN
- Run migrations and seeds

**Install:**
```bash
./scripts/install-mcp-postgres.sh
```
**Config:** `mcp-configs/postgresql.json`

---

### Google Search Console
SEO data from Google directly into Claude.

**Capabilities:**
- Pull search performance: clicks, impressions, CTR, position
- Identify ranking drops and opportunities
- Analyze page indexing and coverage issues
- Cross-reference with on-page SEO audits

**Install:**
```bash
./scripts/install-mcp-gsc.sh
```
**Config:** `mcp-configs/gsc.json`

---

## Adding a Custom MCP

1. Find or build an MCP server (see [MCP Registry](https://mcp.so))
2. Add its config to `mcp-configs/your-mcp.json`
3. Create an install script in `scripts/install-mcp-yourname.sh`
4. Add it to the README MCP table

The config format:
```json
{
  "mcpServers": {
    "your-mcp": {
      "command": "npx",
      "args": ["-y", "your-mcp-package"],
      "env": {
        "API_KEY": "your-key"
      }
    }
  }
}
```

Then merge into `~/Library/Application Support/Claude/claude_desktop_config.json` and restart Claude.
