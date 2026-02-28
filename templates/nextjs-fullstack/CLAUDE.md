# Next.js Fullstack — Claude Instructions

## Stack
- **Framework:** Next.js 15 (App Router)
- **Database:** PostgreSQL + Drizzle ORM
- **Auth:** Auth.js v5 (NextAuth)
- **Styling:** Tailwind CSS v4 + shadcn/ui
- **API:** tRPC v11 or Route Handlers
- **Validation:** Zod
- **Testing:** Vitest + Playwright
- **Deployment:** Vercel or Docker

## Project Structure
```
src/
├── app/                    # App Router pages and layouts
│   ├── (auth)/             # Auth route group
│   ├── (dashboard)/        # Protected route group
│   ├── api/                # Route Handlers
│   └── layout.tsx
├── components/
│   ├── ui/                 # shadcn/ui primitives
│   └── features/           # Feature-specific components
├── lib/
│   ├── db/                 # Drizzle schema + client
│   ├── auth/               # Auth.js config
│   ├── trpc/               # tRPC router setup
│   └── utils.ts
├── server/
│   ├── routers/            # tRPC routers
│   └── actions/            # Server Actions
└── types/                  # Shared TypeScript types
```

## Conventions
- Use Server Components by default, Client Components only when needed (`"use client"`)
- All database queries go through Drizzle — no raw SQL except for migrations
- Validate ALL input with Zod at the API boundary
- Use Server Actions for mutations from forms
- Use tRPC for complex client-side data fetching
- Co-locate tests with the code they test (`*.test.ts` next to the file)
- Environment variables validated at startup with Zod (`src/lib/env.ts`)

## Database Patterns
- Schema in `src/lib/db/schema/` — one file per domain (users.ts, posts.ts, etc.)
- Migrations in `drizzle/` — never edit generated files
- Use `db.$transaction()` for multi-step writes
- Index every foreign key and commonly filtered column

## Auth Rules
- Protect routes with middleware (`src/middleware.ts`)
- Never expose hashed passwords or sensitive fields in API responses
- Session data: only userId + role — fetch full user on demand
- Rate limit auth endpoints

## Security Non-Negotiables
- CSRF protection on all mutations
- Input sanitization before DB writes
- No `dangerouslySetInnerHTML` without DOMPurify
- Secrets only in `.env.local` — never committed
- Content Security Policy headers configured in `next.config.ts`

## Testing Strategy
- Unit: pure functions and utilities with Vitest
- Integration: tRPC routers with test DB
- E2E: critical user paths with Playwright (login, checkout, etc.)
- Run before every commit: `npm run test:unit`

## Commands Available
- `/nextjs:page [name]` — Scaffold a new page with layout, loading, error
- `/nextjs:component [name]` — Create typed React component with tests
- `/nextjs:api [route]` — Create Route Handler with Zod validation
- `/nextjs:action [name]` — Create Server Action with auth check
- `/nextjs:schema [table]` — Generate Drizzle schema for a table
- `/nextjs:migrate` — Generate and run database migration
- `/nextjs:test` — Run full test suite
- `/nextjs:deploy` — Build, test and prepare for deployment
