<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f0c29,50:302b63,100:24243e&height=200&section=header&text=CLAUDE%20OS&fontSize=72&fontColor=ffffff&fontAlignY=38&desc=The%20Ultimate%20AI-Powered%20Fullstack%20Development%20System&descAlignY=58&descSize=18&descColor=a78bfa" width="100%"/>

[![License: MIT](https://img.shields.io/badge/License-MIT-a78bfa?style=for-the-badge)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-6d28d9?style=for-the-badge&logo=anthropic&logoColor=white)](https://claude.ai/code)
[![Agents](https://img.shields.io/badge/Agents-31+-4f46e5?style=for-the-badge&logo=dependabot&logoColor=white)](#agents)
[![Skills](https://img.shields.io/badge/Skills-69+-7c3aed?style=for-the-badge&logo=bookstack&logoColor=white)](#skills)
[![Commands](https://img.shields.io/badge/Commands-64+-8b5cf6?style=for-the-badge&logo=gnubash&logoColor=white)](#commands)
[![MCP](https://img.shields.io/badge/MCP%20Servers-Ready-c4b5fd?style=for-the-badge&logo=serverless&logoColor=white)](#mcp-servers)
[![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-ddd6fe?style=for-the-badge)](#quick-install)

<br/>

> **One install. Full power. From idea to production — without leaving Claude Code.**

<br/>

[**Quick Install**](#quick-install) · [**What's Inside**](#whats-inside) · [**Agents**](#agents) · [**Commands**](#commands) · [**Skills**](#skills) · [**MCPs**](#mcp-servers) · [**Workflow**](#workflow) · [**Templates**](#templates) · [**Docs**](docs/getting-started.md)

</div>

---

## What is Claude OS?

**Claude OS** is a production-ready, fullstack AI development system built on top of [Claude Code](https://claude.ai/code). It transforms Claude Code into a complete development environment with specialized agents, 64+ commands, 69+ skills, multi-agent orchestration, context-rot prevention, SEO automation, security scanning, and built-in best practices for every layer of your stack.

Stop configuring. Start building.

```bash
curl -fsSL https://raw.githubusercontent.com/royaluniondesign-sys/claude-os/main/install.sh | bash
```

---

## What's Inside

| Layer | Tools | Coverage |
|---|---|---|
| **Project Lifecycle** | GSD v1.22 | Idea → Specs → Architecture → Build → Verify → Ship |
| **Multi-Agent Orchestration** | ECC v1.7 + GSD | Parallel agents, wave execution, subagent spawning |
| **Code Quality** | Rules + Reviewers | TypeScript, Python, Go, Java — enforced automatically |
| **Security** | AgentShield (1282 tests, 102 rules) | OWASP, secrets, dependency audit |
| **SEO** | claude-seo + mcp-gsc | Technical SEO, GSC integration, Core Web Vitals |
| **Testing** | TDD + E2E + Coverage | Unit, integration, e2e, performance |
| **Memory** | Session hooks | Context persists across sessions automatically |
| **System Control** | DesktopCommanderMCP | Terminal, filesystem, processes, Excel, PDF |
| **Continuous Learning** | Instinct engine | Claude learns your patterns and improves over time |

---

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/royaluniondesign-sys/claude-os/main/install.sh | bash
```

**Or manually:**

```bash
git clone https://github.com/royaluniondesign-sys/claude-os.git
cd claude-os
./install.sh
```

**Requirements:** [Claude Code](https://claude.ai/code), Node.js 18+, Python 3.9+, Git

---

## Workflow

Claude OS follows a proven spec-driven development cycle that eliminates context rot and delivers production-quality output consistently:

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLAUDE OS CYCLE                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  /gsd:new-project    →  Questions → Research → Specs → Roadmap │
│  /gsd:discuss-phase  →  Lock decisions before planning          │
│  /gsd:plan-phase     →  Research + atomic XML plans             │
│  /gsd:execute-phase  →  Parallel agents, 200k tokens each       │
│  /gsd:verify-work    →  Human + automated verification          │
│  /gsd:complete-milestone → Archive, tag, release                │
│                                                                 │
│  Each plan runs in a FRESH context window.                      │
│  No degradation. No "I'll be more concise now."                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Agents

31 specialized agents ready to spawn on demand:

### GSD Orchestration Agents
| Agent | Role |
|---|---|
| `gsd-planner` | Creates atomic XML implementation plans |
| `gsd-executor` | Executes tasks in isolated 200k token contexts |
| `gsd-verifier` | Validates deliverables against phase goals |
| `gsd-debugger` | Diagnoses failures systematically |
| `gsd-roadmapper` | Builds phased project roadmaps |
| `gsd-phase-researcher` | Deep research before planning |
| `gsd-plan-checker` | Verifies plans before execution |
| `gsd-codebase-mapper` | Analyzes existing codebases |
| `gsd-project-researcher` | Domain and ecosystem research |
| `gsd-research-synthesizer` | Synthesizes research findings |
| `gsd-integration-checker` | Validates cross-component integration |

### Development Agents
| Agent | Role |
|---|---|
| `architect` | System design, stack selection, architecture decisions |
| `chief-of-staff` | Orchestrates multi-agent workflows |
| `planner` | Task breakdown and planning |
| `code-reviewer` | Code quality, patterns, readability |
| `security-reviewer` | OWASP compliance, vulnerability detection |
| `database-reviewer` | Schema design, query optimization |
| `tdd-guide` | Test-driven development guidance |
| `refactor-cleaner` | Code cleanup and refactoring |
| `doc-updater` | Documentation synchronization |
| `e2e-runner` | End-to-end test execution |
| `build-error-resolver` | Diagnoses and fixes build failures |
| `python-reviewer` | Python-specific code review |
| `go-reviewer` | Go-specific code review |
| `go-build-resolver` | Go build error diagnosis |

### SEO Agents
| Agent | Role |
|---|---|
| `seo-technical` | Technical SEO audit |
| `seo-content` | Content optimization |
| `seo-performance` | Core Web Vitals, page speed |
| `seo-schema` | Structured data / JSON-LD |
| `seo-sitemap` | Sitemap generation and optimization |
| `seo-visual` | Visual SEO analysis |

---

## Commands

64 commands across two systems:

### GSD Commands (31) — Project Lifecycle
```bash
/gsd:new-project          # Full project init: questions → research → specs → roadmap
/gsd:map-codebase         # Analyze existing codebase before starting
/gsd:discuss-phase [N]    # Capture implementation decisions
/gsd:plan-phase [N]       # Research + create atomic plans
/gsd:execute-phase <N>    # Execute in parallel waves
/gsd:verify-work [N]      # Human acceptance testing
/gsd:quick                # Ad-hoc tasks with GSD guarantees
/gsd:debug [desc]         # Systematic debugging
/gsd:progress             # Where am I? What's next?
/gsd:new-milestone        # Start next version
/gsd:complete-milestone   # Archive and tag release
/gsd:settings             # Configure model profiles
/gsd:health --repair      # Diagnose and repair installation
```

### ECC Commands (33) — Development Tools
```bash
/orchestrate              # Spawn and coordinate multiple agents
/multi-plan               # Parallel planning with multiple agents
/multi-execute            # Parallel execution across agents
/multi-frontend           # Frontend-focused multi-agent workflow
/multi-backend            # Backend-focused multi-agent workflow
/multi-workflow           # Full-stack multi-agent orchestration
/code-review              # Comprehensive code review
/security-scan            # AgentShield security scan (102 rules)
/tdd                      # Test-driven development workflow
/e2e                      # End-to-end testing
/test-coverage            # Coverage analysis
/verify                   # Verification loop
/checkpoint               # Save progress checkpoint
/learn                    # Extract patterns into reusable skills
/evolve                   # Evolve existing skills
/refactor-clean           # Automated refactoring
/update-docs              # Sync documentation
/plan                     # Structured planning
/pm2                      # Multi-service process management
```

---

## Skills

69 production-ready skills covering every part of the stack:

### Frontend
`frontend-patterns` `frontend-slides` `liquid-glass-design` `swiftui-patterns` `swift-concurrency-6-2` `swift-actor-persistence` `swift-protocol-di-testing`

### Backend
`backend-patterns` `api-design` `python-patterns` `golang-patterns` `django-patterns` `springboot-patterns` `jpa-patterns`

### Database
`postgres-patterns` `database-migrations` `clickhouse-io`

### Infrastructure
`docker-patterns` `deployment-patterns`

### Testing
`tdd-workflow` `e2e-testing` `python-testing` `golang-testing` `django-tdd` `springboot-tdd` `django-verification` `springboot-verification` `cpp-testing` `eval-harness` `verification-loop`

### Security
`security-review` `security-scan` `django-security` `springboot-security`

### SEO (12 skills)
`seo` `seo-audit` `seo-technical` `seo-content` `seo-page` `seo-plan` `seo-schema` `seo-sitemap` `seo-images` `seo-geo` `seo-hreflang` `seo-programmatic` `seo-competitor-pages`

### AI & LLMs
`foundation-models-on-device` `iterative-retrieval` `cost-aware-llm-pipeline` `regex-vs-llm-structured-text` `content-hash-cache-pattern`

### Business & Content
`article-writing` `content-engine` `market-research` `investor-materials` `investor-outreach` `strategic-compact`

### Productivity
`coding-standards` `cpp-coding-standards` `java-coding-standards` `search-first` `continuous-learning` `continuous-learning-v2` `skill-stocktake` `skill-create` `configure-ecc` `project-guidelines-example`

---

## MCP Servers

Model Context Protocol servers that extend Claude's capabilities:

| MCP | What it gives Claude |
|---|---|
| `desktop-commander` | Full terminal control, filesystem ops, process management, Excel/PDF support |
| `github` *(optional)* | PR creation, issue management, CI/CD integration |
| `postgresql` *(optional)* | Direct database access, schema inspection, query execution |
| `gsc` *(optional)* | Google Search Console data, SEO insights |

### Install optional MCPs

```bash
# GitHub integration
./scripts/install-mcp-github.sh

# PostgreSQL
./scripts/install-mcp-postgres.sh

# Google Search Console (SEO)
./scripts/install-mcp-gsc.sh
```

---

## Code Quality Rules

Language-specific rules enforced automatically on every task:

```
rules/
├── common/       # Universal rules: security, naming, structure
├── typescript/   # TS-specific: types, async patterns, imports
├── python/       # PEP 8, type hints, dependency management
└── golang/       # Go idioms, error handling, concurrency
```

---

## Templates

Starter templates with Claude OS pre-configured:

| Template | Stack | Includes |
|---|---|---|
| `nextjs-fullstack` | Next.js 15 + PostgreSQL + Auth | App Router, tRPC, Drizzle, Tailwind |
| `api-rest` | Node.js / Python / Go | OpenAPI spec, auth, rate limiting, tests |
| `shopify-theme` | Shopify + Liquid | Theme architecture, performance, SEO |
| `saas-starter` | Next.js + Stripe + Auth | Billing, orgs, roles, dashboards |

```bash
# Use a template
./scripts/new-project.sh nextjs-fullstack my-app
```

---

## Configuration

### Model Profiles

Balance quality vs cost per task:

```bash
/gsd:set-profile quality    # Opus everywhere (best results)
/gsd:set-profile balanced   # Opus planning + Sonnet execution (default)
/gsd:set-profile budget     # Sonnet planning + Haiku verification
```

### Permissions (recommended)

Add to `.claude/settings.json` in your project:

```json
{
  "permissions": {
    "allow": [
      "Bash(git:*)",
      "Bash(npm:*)",
      "Bash(npx:*)"
    ],
    "deny": [
      "Read(.env)",
      "Read(.env.*)",
      "Read(**/*.pem)",
      "Read(**/*.key)"
    ]
  }
}
```

---

## What Gets Installed

```
~/.claude/
├── agents/          (31 agents)
├── commands/        (64 commands)
│   └── gsd/         (31 GSD commands)
├── skills/          (69 skills)
├── rules/           (4 language rulesets)
├── hooks/           (session memory + context monitor)
├── hooks.json       (hook configuration)
├── get-shit-done/   (GSD templates and config)
└── settings.json    (updated with hooks + statusline)
```

---

## Contributing

Claude OS aggregates and builds on the work of an incredible open source community:

| Project | Contribution |
|---|---|
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | Core agents, skills, commands, rules, hooks |
| [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) | Project lifecycle system |
| [wonderwhy-er/DesktopCommanderMCP](https://github.com/wonderwhy-er/DesktopCommanderMCP) | System control MCP |
| [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) | SEO skill suite |
| [davila7/claude-code-templates](https://github.com/davila7/claude-code-templates) | Template components |
| [anthropics/skills](https://github.com/anthropics/skills) | Official Anthropic skills |

All original licenses are preserved. See [ATTRIBUTION.md](ATTRIBUTION.md) for details.

**To contribute:**
1. Fork this repo
2. Add your agent / skill / command / MCP in the right folder
3. Document it in this README
4. Open a PR

---

## Roadmap

- [ ] GitHub Actions MCP integration
- [ ] Terraform / infrastructure agent
- [ ] Monitoring agent (Datadog / Grafana)
- [ ] n8n workflow integration
- [ ] One-click Vercel / Railway deployment templates
- [ ] Web UI for skill/agent management

---

## License

MIT — see [LICENSE](LICENSE)

---

<div align="center">

**Built for developers who ship.**

[![Star on GitHub](https://img.shields.io/github/stars/royaluniondesign-sys/claude-os?style=social)](https://github.com/royaluniondesign-sys/claude-os)

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:24243e,50:302b63,100:0f0c29&height=100&section=footer" width="100%"/>

</div>
