# Getting Started with Claude OS

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/royaluniondesign-sys/claude-os/main/install.sh | bash
```

Or clone and install:

```bash
git clone https://github.com/royaluniondesign-sys/claude-os.git
cd claude-os
./install.sh
```

**Requirements:** Node.js 18+, Python 3.9+, Git, [Claude Code](https://claude.ai/code)

---

## Your First Project

Open any empty folder in Claude Code and run:

```
/gsd:new-project
```

GSD will ask you questions about what you want to build, research the domain, generate a roadmap, and create all planning documents. Then you're ready to build.

---

## Use a Template

```bash
./scripts/new-project.sh nextjs-fullstack my-app
cd my-app
claude
```

Inside Claude Code:
```
/gsd:new-project
```

---

## Core Workflow

```
1. /gsd:new-project          Start: answer questions, get roadmap
2. /gsd:discuss-phase 1      Shape how phase 1 should be built
3. /gsd:plan-phase 1         Research + create atomic plans
4. /gsd:execute-phase 1      Agents build in parallel
5. /gsd:verify-work 1        You confirm it works
6. Repeat for each phase
7. /gsd:complete-milestone   Archive, tag, release
```

---

## Key Commands to Know

| Command | When to use |
|---|---|
| `/gsd:new-project` | Starting any new project |
| `/gsd:quick` | Quick tasks without full planning |
| `/gsd:progress` | Check where you are |
| `/orchestrate` | Manual multi-agent workflow |
| `/code-review` | Review before merging |
| `/security-scan` | Before shipping to production |
| `/tdd` | When adding features with tests |
| `/seo audit [url]` | SEO audit for any URL |

---

## Add Optional MCPs

```bash
# GitHub integration (PRs, issues, Actions)
./scripts/install-mcp-github.sh

# PostgreSQL direct access
./scripts/install-mcp-postgres.sh

# Google Search Console (SEO data)
./scripts/install-mcp-gsc.sh
```

---

## Updating

```bash
cd claude-os
git pull
./install.sh
```
