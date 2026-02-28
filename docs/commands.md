# Commands Reference

64 commands across two systems. All available as `/command-name` in Claude Code.

---

## GSD Commands — Project Lifecycle

### Core Workflow
| Command | Description |
|---|---|
| `/gsd:new-project` | Full init: questions → research → specs → roadmap |
| `/gsd:map-codebase` | Analyze existing codebase before starting |
| `/gsd:discuss-phase [N]` | Shape how a phase should be built |
| `/gsd:plan-phase [N]` | Research + create atomic XML plans |
| `/gsd:execute-phase <N>` | Execute plans in parallel waves |
| `/gsd:verify-work [N]` | Confirm built features work as expected |
| `/gsd:quick` | Ad-hoc tasks without full planning |

### Milestone Management
| Command | Description |
|---|---|
| `/gsd:complete-milestone` | Archive milestone, tag release |
| `/gsd:new-milestone [name]` | Start next version cycle |
| `/gsd:audit-milestone` | Verify milestone achieved its goals |
| `/gsd:plan-milestone-gaps` | Create phases to close audit gaps |

### Phase Management
| Command | Description |
|---|---|
| `/gsd:add-phase` | Append phase to current milestone |
| `/gsd:insert-phase [N]` | Insert urgent work between phases |
| `/gsd:remove-phase [N]` | Remove and renumber a future phase |
| `/gsd:list-phase-assumptions [N]` | See Claude's approach before planning |

### Navigation & Session
| Command | Description |
|---|---|
| `/gsd:progress` | Where am I? What's next? |
| `/gsd:pause-work` | Create handoff when stopping mid-phase |
| `/gsd:resume-work` | Restore from last session |
| `/gsd:add-todo [desc]` | Capture idea for later |
| `/gsd:check-todos` | List and select pending todos |
| `/gsd:debug [desc]` | Systematic debugging with persistent state |

### Configuration
| Command | Description |
|---|---|
| `/gsd:settings` | Configure workflow toggles and model profile |
| `/gsd:set-profile <quality\|balanced\|budget>` | Switch model profile |
| `/gsd:health --repair` | Diagnose and fix installation |
| `/gsd:update` | Update GSD to latest version |

---

## ECC Commands — Development Tools

### Multi-Agent Orchestration
| Command | Description |
|---|---|
| `/orchestrate` | Coordinate multiple specialized agents |
| `/multi-plan` | Parallel planning with multiple models |
| `/multi-execute` | Parallel execution across agents |
| `/multi-frontend` | Frontend-focused multi-agent workflow |
| `/multi-backend` | Backend-focused multi-agent workflow |
| `/multi-workflow` | Full-stack multi-agent orchestration |
| `/pm2` | Multi-service process management |

### Code Quality
| Command | Description |
|---|---|
| `/code-review` | Comprehensive code review |
| `/python-review` | Python-specific review |
| `/go-review` | Go-specific review |
| `/refactor-clean` | Automated refactoring and cleanup |
| `/verify` | Verification loop |
| `/checkpoint` | Save progress checkpoint |

### Security
| Command | Description |
|---|---|
| `/security-scan` | AgentShield scan (1282 tests, 102 rules) |

### Testing
| Command | Description |
|---|---|
| `/tdd` | Test-driven development workflow |
| `/e2e` | Generate and run Playwright E2E tests |
| `/test-coverage` | Coverage analysis and reporting |
| `/go-test` | Go table-driven test workflow |
| `/go-build` | Fix Go build errors and linter issues |
| `/build-fix` | Diagnose and fix build failures |

### Learning & Skills
| Command | Description |
|---|---|
| `/learn` | Extract patterns from session into skills |
| `/learn-eval` | Extract + self-evaluate before saving |
| `/evolve` | Cluster instincts into skills |
| `/instinct-status` | Show learned instincts |
| `/instinct-export` | Export instincts for sharing |
| `/instinct-import` | Import instincts from teammates |
| `/skill-create` | Generate skill from git history |

### Documentation & Planning
| Command | Description |
|---|---|
| `/plan` | Structured planning with risk assessment |
| `/update-docs` | Sync documentation with code |
| `/update-codemaps` | Update codebase maps |
| `/eval` | Formal evaluation framework |
| `/sessions` | Session history management |
| `/setup-pm` | Setup project management |
| `/claw` | Start NanoClaw agent REPL |
| `/evolve` | Evolve existing skills |
