# SvelteKit SSR user auth skeleton

I hope to use this skeleton as a foundation to integrate user authentication in SvelteKit web app.

[Screencast project presentation](https://youtu.be/l8x9daevJBQ) (audio in french)

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
- I'm trying to move towards [Radical Simplicity](https://www.radicalsimpli.city/)
- [Don’t Build A General Purpose API To Power Your Own Front End](https://max.engineer/server-informed-ui)

Components and libraries:

- ✅ [SSR](https://kit.svelte.dev/docs/page-options#ssr) [SvelteKit](https://github.com/sveltejs/kit) with [Hydration](https://kit.svelte.dev/docs/glossary#hydration)
- ✅ PostgreSQL database server
- ✅ [Postgres.js](https://github.com/porsager/postgres) - PostgreSQL client for Node.js
- ✅ Migration powered by [graphile-migrate](https://github.com/graphile/migrate)
- ✅ Token generated with [jsonwebtoken](https://github.com/auth0/node-jsonwebtoken)

Tooling:

- ✅ [asdf](https://asdf-vm.com/)
- ✅ [NodeJS](https://nodejs.org/en/)
- ✅ [pnpm](https://pnpm.io/)
- ✅ [Jest](https://jestjs.io/) for unittest

## Development time and costs

The `2023-09-21`, until commit [`fb78f6d`](https://github.com/stephane-klein/sveltekit-user-auth-skeleton/commit/fb78f6d4598697d6325d6b642d27ead57ef8d5dc), I spent 15 hours and 28 minutes on this project.<br />
This time was measured with a chronometer, which is deep work.<br />
I consider that a "normal" working day corresponds to a maximum of 4 hours of deep work.

This work would correspond to the following price:

- For a French developer on a permanent contract at 65 K€ gross per year: 1748 € (total cost paid by the employer)
- For a freelance developer at 600 € per day: 2400 € (total cost invoiced by the freelance)

<details>
  <summary>See details</summary>

```sh
$ python
Python 3.11.5 (main, Aug 28 2023, 00:00:00) [GCC 13.2.1 20230728 (Red Hat 13.2.1-1)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import math
>>> french_developer_on_a_permanent_contract = math.ceil(15.5/4) * 437
>>> french_developer_on_a_permanent_contract
1748
>>> freelance = math.ceil(15.5/4) * 600
>>> freelance
2400
>>>
```

</details>

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
