# /nextjs:page

Scaffold a complete Next.js App Router page with all required files.

## Usage
```
/nextjs:page [name] [--route path] [--protected]
```

## What this creates
Given `/nextjs:page dashboard/analytics --protected`:

```
src/app/(dashboard)/analytics/
├── page.tsx          # Server Component with metadata
├── loading.tsx       # Suspense loading skeleton
├── error.tsx         # Error boundary
└── _components/      # Page-specific components
    └── analytics-chart.tsx
```

## Rules
- Default to Server Components — add `"use client"` only if needed
- Include `export const metadata: Metadata = { title, description }` in every page
- Add `loading.tsx` with skeleton that matches the page layout
- Add `error.tsx` with retry button
- Protected pages: wrap content check with session validation
- Add to sitemap if public page

## Template: page.tsx
```tsx
import { type Metadata } from 'next'

export const metadata: Metadata = {
  title: '[PageName] | App',
  description: '[Description]',
}

export default async function [PageName]Page() {
  return (
    <main>
      {/* page content */}
    </main>
  )
}
```
