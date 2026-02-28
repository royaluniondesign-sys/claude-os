# Claude OS — System Instructions

This repository IS Claude OS. When working inside this repo, you are maintaining the system itself.

## What this repo contains

- `install.sh` — One-command installer for the full system
- `README.md` — Documentation and showcase
- `.claude/` — Reference configs (agents, skills, commands, rules)
- `mcp-configs/` — MCP server configurations
- `templates/` — Starter project templates
- `docs/` — Extended documentation
- `scripts/` — Utility and MCP install scripts

## Principles

- Every agent, skill, and command must follow best practices for its domain
- No vendor lock-in: everything works with any tech stack
- Security first: secrets never committed, OWASP rules enforced
- Production-ready: nothing here is a toy or demo

## When adding new components

1. Agents go in `.claude/agents/` — one file per agent, clear role
2. Skills go in `.claude/skills/<name>/` — must include a `SKILL.md`
3. Commands go in `.claude/commands/` — one `.md` per command
4. Rules go in `.claude/rules/<language>/` — language-specific
5. MCPs get a config in `mcp-configs/` and an install script in `scripts/`
6. Templates go in `templates/<name>/` with their own README

## Attribution

Always credit the original source when adapting existing work.
See ATTRIBUTION.md for full credits.
