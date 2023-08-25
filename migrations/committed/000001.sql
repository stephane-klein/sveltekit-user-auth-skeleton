--! Previous: -
--! Hash: sha1:b68d3d5626fee3e5b7e0110e6ab231cf457d5a9c

-- Enter migration here

DROP SCHEMA IF EXISTS public CASCADE;
DROP SCHEMA IF EXISTS auth CASCADE;

CREATE SCHEMA IF NOT EXISTS utils;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA utils;
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA utils;

CREATE SCHEMA IF NOT EXISTS auth;

DROP TABLE IF EXISTS auth.users CASCADE;
CREATE TABLE auth.users (
    id                     SERIAL PRIMARY KEY,
    username               VARCHAR(100) NULL UNIQUE,
    first_name             VARCHAR(150) DEFAULT NULL,
    last_name              VARCHAR(150) DEFAULT NULL,
    email                  VARCHAR(360) DEFAULT NULL,
    password               VARCHAR(255) DEFAULT NULL,
    is_staff               BOOLEAN DEFAULT false,
    is_active              BOOLEAN DEFAULT false,
    last_login             TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    date_joined            TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    created_at             TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at             TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
CREATE INDEX users_username_index    ON auth.users (username);
CREATE INDEX users_first_name_index  ON auth.users (first_name);
CREATE INDEX users_last_name_index   ON auth.users (last_name);
CREATE INDEX users_email_index       ON auth.users (email);
CREATE INDEX users_is_staff_index    ON auth.users (is_staff);
CREATE INDEX users_is_active_index   ON auth.users (is_active);
CREATE INDEX users_last_login_index  ON auth.users (last_login);
CREATE INDEX users_date_joined_index ON auth.users (date_joined);
CREATE INDEX users_created_at_index  ON auth.users (created_at);
CREATE INDEX users_updated_at_index  ON auth.users (updated_at);

DROP FUNCTION IF EXISTS auth.create_user;
CREATE FUNCTION auth.create_user(
    username               VARCHAR(100),
    first_name             VARCHAR(150),
    last_name              VARCHAR(150),
    email                  VARCHAR(360),
    password               VARCHAR(255),
    is_staff               BOOLEAN,
    is_active              BOOLEAN
) RETURNS INTEGER
LANGUAGE sql
AS $$
    INSERT INTO auth.users
    (
        username,
        first_name,
        last_name,
        email,
        password,
        is_staff,
        is_active
    )
    VALUES(
        TRIM(username),
        TRIM(first_name),
        TRIM(last_name),
        LOWER(TRIM(email)),
        utils.CRYPT(TRIM(password), utils.GEN_SALT('bf', 8)),
        is_staff,
        is_active
    )
    RETURNING id;
$$;

DROP TABLE IF EXISTS auth.sessions CASCADE;
CREATE TABLE auth.sessions(
    id            UUID PRIMARY KEY DEFAULT utils.uuid_generate_v4() NOT NULL,
    user_id       INTEGER NOT NULL,
    expires       TIMESTAMP WITH TIME ZONE DEFAULT (CURRENT_TIMESTAMP + '2days'::interval),

    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES auth.users (id) ON DELETE CASCADE
);
CREATE INDEX sessions_user_id_index ON auth.sessions (user_id);

CREATE OR REPLACE FUNCTION auth.create_session(
    input_user_id INTEGER
) RETURNS UUID
LANGUAGE SQL
AS $$
    DELETE FROM auth.sessions WHERE user_id = input_user_id;
    INSERT INTO auth.sessions (user_id) VALUES (input_user_id) RETURNING sessions.id;
$$;;

DROP FUNCTION IF EXISTS auth.authenticate;
CREATE FUNCTION auth.authenticate(
    input_username VARCHAR(100),
    input_email    VARCHAR(360),
    input_password VARCHAR(255)
) RETURNS JSON
LANGUAGE 'plpgsql'
AS $$
DECLARE
    response JSON;
BEGIN
    WITH user_authenticated AS (
        SELECT
            id,
            username,
            first_name,
            last_name,
            email,
            password,
            is_staff,
            is_active
        FROM
            auth.users
        WHERE
            (
                (
                    (username = input_username) AND
                    (password = utils.CRYPT(input_password, password))
                ) OR
                (
                    (email = input_email) AND
                    (password = utils.CRYPT(input_password, password))
                )
            ) AND
            (is_active IS true)
        LIMIT 1
    )
    SELECT json_build_object(
        'statusCode', CASE WHEN (SELECT COUNT(*) FROM user_authenticated) > 0 THEN 200 ELSE 401 END,
        'status', CASE WHEN (SELECT COUNT(*) FROM user_authenticated) > 0
            THEN 'Login successful.'
            ELSE 'Invalid username/password combination.'
        END,
        'user', CASE WHEN (SELECT COUNT(*) FROM user_authenticated) > 0
            THEN (
                SELECT
                    json_build_object(
                        'username',   user_authenticated.username,
                        'first_name', user_authenticated.first_name,
                        'last_name',  user_authenticated.last_name,
                        'email',      user_authenticated.email,
                        'password',   user_authenticated.password,
                        'is_staff',   user_authenticated.is_staff
                    )
                FROM
                    user_authenticated
            )
            ELSE NULL
	    END,
	    'sessionId', (SELECT auth.create_session(user_authenticated.id) FROM user_authenticated)
    ) INTO response;
    RETURN response;
END;
$$;
