# SaaS Starter — Claude Instructions

## Stack
- **Framework:** Next.js 15 (App Router)
- **Auth:** Auth.js v5 with email + OAuth (Google, GitHub)
- **Database:** PostgreSQL + Drizzle ORM
- **Billing:** Stripe (subscriptions + usage-based)
- **Email:** Resend + React Email
- **Styling:** Tailwind CSS v4 + shadcn/ui
- **Background Jobs:** Trigger.dev or Inngest
- **Deployment:** Vercel + Neon (PostgreSQL)

## Project Structure
```
src/
├── app/
│   ├── (marketing)/        # Public pages: landing, pricing, blog
│   ├── (auth)/             # Login, signup, forgot password
│   ├── (app)/              # Authenticated app
│   │   ├── dashboard/
│   │   ├── settings/
│   │   │   ├── billing/    # Stripe portal, plan management
│   │   │   ├── team/       # Member management
│   │   │   └── profile/
│   │   └── [orgSlug]/      # Multi-tenant routing
│   └── api/
│       ├── webhooks/
│       │   └── stripe/     # Stripe webhook handler
│       └── ...
├── components/
│   ├── ui/                 # shadcn primitives
│   ├── billing/            # Pricing table, upgrade modals
│   └── marketing/          # Hero, features, testimonials
├── lib/
│   ├── db/
│   │   └── schema/
│   │       ├── users.ts
│   │       ├── orgs.ts
│   │       ├── memberships.ts
│   │       └── subscriptions.ts
│   ├── stripe/             # Stripe client + helpers
│   ├── auth/               # Auth.js config + helpers
│   ├── email/              # Resend client + templates
│   └── permissions/        # Role-based access control
└── types/
```

## Multi-Tenancy Model
- Users belong to one or more Organizations
- Each Organization has a plan (free/pro/enterprise)
- Roles: `owner`, `admin`, `member`
- Row-Level Security enforced at DB level
- Every query filters by `orgId` — never expose cross-org data

## Billing Architecture
- One Stripe Customer per Organization (not per user)
- Stripe Subscription attached to Organization
- Webhook events update `subscriptions` table synchronously
- Idempotent webhook handler — safe to replay
- Metered billing tracked in `usage_records` table
- Upgrade/downgrade via Stripe Customer Portal (no custom UI needed)

## Subscription Plans Schema
```
free:    { seats: 1,  storage: '1GB',   features: ['basic'] }
pro:     { seats: 5,  storage: '50GB',  features: ['basic', 'advanced'] }
enterprise: { seats: -1, storage: '500GB', features: ['*'] }
```

## Email Triggers
- Welcome email on signup
- Invitation email when member added
- Payment failed (3 attempts, then downgrade)
- Trial ending (7 days, 3 days, 1 day before)
- Monthly usage report

## Permissions System
- Feature flags checked via `can(user, 'feature:name')` helper
- Route-level protection in middleware
- Component-level gates with `<Gate feature="advanced">`
- Never trust client-side permission checks alone

## Security
- Stripe webhook signature verified on every request
- Multi-tenant isolation tested in every integration test
- Rate limiting on auth and API endpoints
- MFA support via Auth.js

## Commands Available
- `/saas:feature [name]` — Scaffold new feature with permissions, UI, tests
- `/saas:plan [name]` — Add new subscription tier with Stripe product
- `/saas:email [name]` — Create transactional email template
- `/saas:webhook [event]` — Add Stripe webhook event handler
- `/saas:onboarding` — Build onboarding flow steps
- `/saas:invite` — Create team invitation system
- `/saas:usage [metric]` — Add usage tracking for a metric
- `/saas:deploy` — Deploy to Vercel with environment validation
