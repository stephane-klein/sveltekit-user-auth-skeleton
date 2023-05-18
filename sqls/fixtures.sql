\echo "Loading fixtures..."

SET client_min_messages TO WARNING;

TRUNCATE public.users;

INSERT INTO public.users
    (
        username,
        first_name,
        last_name,
        email,
        is_staff,
        is_active
    )
    VALUES
    (
        'user1',                 -- username
        'John1',                 -- first_name
        'Doe1',                  -- last_name
        'john.doe1@example.com',  -- email
        true,                    -- is_staff
        true                     -- is_active
    ),
    (
        'user2',                 -- username
        'John2',                 -- first_name
        'Doe2',                  -- last_name
        'john.doe2@example.com',  -- email
        false,                    -- is_staff
        true                     -- is_active
    ),
    (
        'user3',                 -- username
        'John3',                 -- first_name
        'Doe3',                  -- last_name
        'john.doe3@example.com',  -- email
        false,                    -- is_staff
        true                     -- is_active
    );

\echo "Fixtures loaded"
