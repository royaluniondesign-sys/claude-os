# Agents Reference

Claude OS includes 31 specialized agents. Claude spawns them automatically during workflows, or you can reference them directly.

---

## GSD Orchestration Agents

These run automatically during `/gsd:*` workflows.

| Agent | File | Role |
|---|---|---|
| `gsd-planner` | `.claude/agents/gsd-planner.md` | Creates atomic XML implementation plans |
| `gsd-executor` | `.claude/agents/gsd-executor.md` | Executes tasks in isolated 200k token contexts |
| `gsd-verifier` | `.claude/agents/gsd-verifier.md` | Validates deliverables against phase goals |
| `gsd-debugger` | `.claude/agents/gsd-debugger.md` | Systematic root-cause diagnosis |
| `gsd-roadmapper` | `.claude/agents/gsd-roadmapper.md` | Builds phased project roadmaps |
| `gsd-planner` | `.claude/agents/gsd-plan-checker.md` | Verifies plans pass quality bar before execution |
| `gsd-phase-researcher` | `.claude/agents/gsd-phase-researcher.md` | Deep domain research before planning |
| `gsd-project-researcher` | `.claude/agents/gsd-project-researcher.md` | Ecosystem and technology research |
| `gsd-research-synthesizer` | `.claude/agents/gsd-research-synthesizer.md` | Synthesizes research into actionable findings |
| `gsd-codebase-mapper` | `.claude/agents/gsd-codebase-mapper.md` | Analyzes existing codebases |
| `gsd-integration-checker` | `.claude/agents/gsd-integration-checker.md` | Validates cross-component integration |

---

## Development Agents

Reference these in prompts like: *"Use the architect agent to design the auth system"*

| Agent | Specialty |
|---|---|
| `architect` | System design, stack selection, architecture decisions |
| `chief-of-staff` | Coordinates complex multi-agent workflows |
| `planner` | Task decomposition and sequencing |
| `code-reviewer` | Code quality, patterns, readability, best practices |
| `security-reviewer` | OWASP, vulnerability detection, secrets audit |
| `database-reviewer` | Schema design, indexes, query optimization |
| `tdd-guide` | Test-driven development, test design |
| `refactor-cleaner` | Code cleanup, dead code removal, modernization |
| `doc-updater` | Keeps documentation in sync with code |
| `e2e-runner` | End-to-end test execution and maintenance |
| `build-error-resolver` | Diagnoses and fixes build failures |
| `python-reviewer` | Python-specific review: PEP 8, type hints, idioms |
| `go-reviewer` | Go-specific review: idiomatic patterns, concurrency |
| `go-build-resolver` | Go build error diagnosis |

---

## SEO Agents

Spawned automatically by `/seo:audit` and related commands.

| Agent | Focus |
|---|---|
| `seo-technical` | Crawlability, indexing, robots, sitemaps |
| `seo-content` | E-E-A-T, readability, keyword optimization |
| `seo-performance` | Core Web Vitals, LCP, CLS, FID |
| `seo-schema` | JSON-LD structured data validation |
| `seo-sitemap` | Sitemap generation and validation |
| `seo-visual` | Visual SEO — image optimization, alt text |

---

## Adding a Custom Agent

Create a file in `.claude/agents/my-agent.md`:

```markdown
# My Agent

[Description of what this agent does and when to use it]

## Role
You are a [role] specialized in [domain].

## Responsibilities
- ...

## Approach
1. ...
```

No registration needed — Claude picks it up automatically.
