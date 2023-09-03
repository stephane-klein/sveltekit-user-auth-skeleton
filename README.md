# SvelteKit SSR user auth skeleton

Repository starting point issue (in French): https://github.com/stephane-klein/backlog/issues/209

This skeleton is build over [`sveltekit-ssr-skeleton`](https://github.com/stephane-klein/sveltekit-ssr-skeleton).

Features:

- User login
- User signup
- User signup by invitation (enabled by `INVITATION_REQUIRED=1` variable env)
- User password reset support
- User impersonate support for staff user

Opinions:

- No ORM pattern
- `impersonate_user_id` is stored in `auth.sessions` table (this can be challenged)
- No REST API
- I'm trying to move towards [Radical Simplicity](https://www.radicalsimpli.city/)
- [Don’t Build A General Purpose API To Power Your Own Front End](https://max.engineer/server-informed-ui)

Components and libraries:

- ✅ [SSR](https://kit.svelte.dev/docs/page-options#ssr) [SvelteKit](https://github.com/sveltejs/kit) with [Hydration](https://kit.svelte.dev/docs/glossary#hydration)
- ✅ PostgreSQL database server
- ✅ [Postgres.js](https://github.com/porsager/postgres) - PostgreSQL client for Node.js
- ✅ Migration powered by [graphile-migrate](https://github.com/graphile/migrate)

Tooling:

- ✅ [asdf](https://asdf-vm.com/)
- ✅ [NodeJS](https://nodejs.org/en/)
- ✅ [pnpm](https://pnpm.io/)
- ✅ [Jest](https://jestjs.io/) for unittest

## Getting started

```sh
$ asdf install
```

```sh
$ pnpm install
```

Start database engine:

```sh
$ ./scripts/init.sh
$ ./scripts/fixtures.sh
```

Start web server:

```sh
$ pnpm run dev
```

Go to http://localhost:5173/

## Valid logins

- email: `john.doe1@example.com`
  password: `secret1`
- email: `john.doe2@example.com`
  password: `secret2`
- email: `john.doe3@example.com`
  password: `secret3`

Create new user with:

```
$ pnpm run user create --email=john.doe4@example.com --username=john-doe4 --password=password --firstname=John --lastname=Doe
```

## Maildev

You can access to Maildev on http://localhost:1080

## Database migration

```
$ pnpm run migrate:watch
```

Apply migration in `migrations/current.sql` and commit:

```
$ pnpm run migrate:commit
```

## Execute Unittest

```
$ pnpm run migrate-test:watch
```

```sh
$ pnpm run -s tests
 PASS  tests/auth.js
  ✓ Create a user (39 ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
Snapshots:   0 total
Time:        0.255 s, estimated 1 s
Ran all test suites.
```

## Prettier

Launch Prettier check:

```sh
$ pnpm run prettier-check
```

Apply Prettier fix example:

```sh
$ pnpm run prettier src/app.html
```

## ESlint

```sh
$ pnpm run eslint
```
