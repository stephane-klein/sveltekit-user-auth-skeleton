#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

docker compose up -d postgres postgres-test --wait
pnpm run migrate:reset --erase
pnpm run migrate-test:reset --erase
