# /saas:feature

Scaffold a complete SaaS feature with permissions, UI, API, and tests.

## Usage
```
/saas:feature [name] [--plan free|pro|enterprise] [--route path]
```

## What this creates
Given `/saas:feature analytics --plan pro`:

```
src/app/(app)/[orgSlug]/analytics/
├── page.tsx                     # Feature page (checks plan)
├── loading.tsx
└── _components/
    └── analytics-dashboard.tsx

src/lib/permissions/features.ts   # Updated with new feature gate
src/server/routers/analytics.ts   # tRPC router for this feature
tests/integration/analytics.test.ts
```

## Rules
- Check plan permission at both route level AND component level
- Never show "upgrade required" without a clear CTA to upgrade
- Feature must be isolated — removing it shouldn't break other features
- Add to the org's feature list in `src/lib/permissions/features.ts`
- Include integration test that verifies free plan CANNOT access pro feature
- All data queries filter by `orgId` — verified in tests

## Permission check pattern
```tsx
import { can } from '@/lib/permissions'

export default async function AnalyticsPage() {
  const { org } = await getCurrentOrg()

  if (!can(org, 'analytics:view')) {
    return <UpgradePrompt feature="Analytics" requiredPlan="pro" />
  }

  return <AnalyticsDashboard orgId={org.id} />
}
```
