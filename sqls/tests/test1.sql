BEGIN;
SELECT plan(2);

SELECT has_table('auth'::name, 'users'::name);
SELECT has_table('auth'::name, 'sessions'::name);

TRUNCATE auth.users CASCADE;

SELECT auth.create_user(
    username   => 'john-doe1',
    first_name => 'John',
    last_name  => 'Doe1',
    email      => 'john.doe1@example.com',
    password   => 'secret1',
    is_staff   => true,
    is_active  => true
);

SELECT auth.authenticate(
    input_username => 'john-doe1',
    input_email => NULL,
    input_password => 'secret1'
);

/*

DECLARE
response JSON

SELECT auth.authenticate(
    input_username => 'john-doe1',
    input_email => NULL,
    input_password => 'secret1'
) INTO response;

SELECT is(
    response->'statusCode',
    200
);

SELECT is(
    SELECT COUNT(*) FROM auth.session WHERE id=response->'sessionID',
    1
);

 */

WITH response AS (
    SELECT auth.authenticate(
        input_username => 'john-doe1',
        input_email => NULL,
        input_password => 'secret1'
    )::JSON
)
SELECT
    response->'responseCode'
FROM
    response;

ROLLBACK;
