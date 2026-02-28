# /nextjs:schema

Generate a Drizzle ORM schema for a database table with relations.

## Usage
```
/nextjs:schema [table-name] [--relations table1,table2]
```

## Rules
- Use `pgTable` from `drizzle-orm/pg-core`
- Always include: `id` (uuid, default random), `createdAt`, `updatedAt`
- Foreign keys reference the related table's id column
- Add indexes on foreign keys and commonly filtered columns
- Export both the table and its TypeScript type (`type NewX = typeof x.$inferInsert`)
- Place in `src/lib/db/schema/[table].ts`
- Register in `src/lib/db/schema/index.ts`

## Template
```ts
import { pgTable, uuid, text, timestamp, index } from 'drizzle-orm/pg-core'
import { users } from './users'

export const posts = pgTable('posts', {
  id: uuid('id').defaultRandom().primaryKey(),
  title: text('title').notNull(),
  content: text('content'),
  authorId: uuid('author_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
  createdAt: timestamp('created_at').defaultNow().notNull(),
  updatedAt: timestamp('updated_at').defaultNow().notNull().$onUpdate(() => new Date()),
}, (t) => [
  index('posts_author_id_idx').on(t.authorId),
])

export type Post = typeof posts.$inferSelect
export type NewPost = typeof posts.$inferInsert
```
