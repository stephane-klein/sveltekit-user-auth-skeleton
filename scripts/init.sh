#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

docker compose up -d postgres postgres-test --wait
pnpm run migrate:reset --erase
pnpm run migrate-test:reset --erase
pnpm run migrate:watch --once
pnpm run migrate-test:watch --once
