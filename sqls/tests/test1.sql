BEGIN;
SELECT plan(1);

SELECT has_table('auth'::name, 'users'::name);
ROLLBACK;
