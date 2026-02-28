# REST API — Claude Instructions

## Stack Options
Choose one during `/gsd:new-project`:
- **Node.js:** Fastify + TypeScript + Zod + Drizzle
- **Python:** FastAPI + Pydantic + SQLAlchemy + Alembic
- **Go:** Chi router + sqlc + golang-migrate

## Project Structure (Node.js/Fastify)
```
src/
├── routes/             # Route handlers organized by domain
│   ├── users/
│   │   ├── index.ts    # Route registration
│   │   ├── handlers.ts # Business logic
│   │   └── schema.ts   # Zod schemas for this domain
│   └── ...
├── plugins/            # Fastify plugins
│   ├── auth.ts         # JWT verification plugin
│   ├── rateLimit.ts
│   └── db.ts           # Database plugin
├── lib/
│   ├── db/             # Drizzle schema + client
│   ├── errors.ts       # Typed error classes
│   └── logger.ts       # Structured logging (pino)
├── middleware/
│   └── ...
├── types/              # Shared TypeScript types
└── server.ts           # Entry point
tests/
├── unit/
├── integration/        # Uses test database
└── e2e/
```

## API Design Rules
- REST resources are nouns, not verbs: `/users`, `/orders`, not `/getUser`
- Use proper HTTP methods: GET (read), POST (create), PUT/PATCH (update), DELETE
- Return consistent envelope: `{ data, error, meta }` or use problem+json for errors
- Versioning in URL: `/api/v1/...`
- Pagination: cursor-based for large sets, offset for small
- Filter/sort via query params: `?status=active&sort=-createdAt&limit=20`

## Status Codes
- `200` OK, `201` Created, `204` No Content
- `400` Bad Request (validation), `401` Unauthorized, `403` Forbidden
- `404` Not Found, `409` Conflict, `422` Unprocessable Entity
- `429` Too Many Requests, `500` Internal Server Error

## Security Non-Negotiables
- JWT verification on every protected route — never trust client-sent user ID
- Rate limiting on all auth endpoints (100 req/15min for most, 5 req/15min for login)
- Input validation with Zod/Pydantic at route level — never trust raw input
- SQL queries via ORM only — no string interpolation
- Secrets via environment variables — validated at startup
- CORS configured explicitly — no wildcard in production
- Security headers: Helmet.js or equivalent

## Error Handling
- Typed error classes for each domain error
- Never expose stack traces in production
- Log full error internally, return safe message to client
- Use HTTP Problem Details format (RFC 7807) for complex errors

## Testing Strategy
- Unit tests for pure business logic
- Integration tests with real test database (Docker)
- Contract tests for external API dependencies
- Load testing with k6 before production

## OpenAPI
- Auto-generate from Zod/Pydantic schemas — never write spec manually
- Keep in sync with CI: fail if spec is outdated
- Expose at `/api/docs` in development

## Commands Available
- `/api:endpoint [method] [path]` — Scaffold route with handler, schema, tests
- `/api:middleware [name]` — Create middleware with proper typing
- `/api:schema [name]` — Generate Zod/Pydantic schema
- `/api:migrate` — Create and run database migration
- `/api:test` — Run full test suite with coverage
- `/api:openapi` — Regenerate OpenAPI spec
- `/api:deploy` — Build Docker image and push
