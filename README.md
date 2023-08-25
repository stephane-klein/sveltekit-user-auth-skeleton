# SvelteKit SSR user auth skeleton

Repository starting point issue (in French): https://github.com/stephane-klein/backlog/issues/209

This skeleton is build over [`sveltekit-ssr-skeleton`](https://github.com/stephane-klein/sveltekit-ssr-skeleton).

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

## Database migration

```
$ pnpm run migrate:watch
```

Apply migration in `migrations/current.sql` and commit:

```
$ pnpm run migrate:commit
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
