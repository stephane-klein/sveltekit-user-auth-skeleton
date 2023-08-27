import postgres from "postgres";

let sql;


beforeAll(() => {
    sql = postgres(
        'postgres://postgrestest:passwordtest@localhost:5433/myapp'
    );
});
afterAll(() => {
    sql.end()
});

test('Create a user', async () => {
    await sql`DELETE FROM auth.users`;

    await sql`SELECT auth.create_user(
        username   => 'john-doe',
        first_name => 'John',
        last_name  => 'Doe',
        email      => 'john.doe@gmail.com',
        password   => 'secret',
        is_staff   => false,
        is_active  => true
    )`;

    expect(
        (await sql`SELECT COUNT(*)::INTEGER FROM auth.users WHERE first_name = 'John'`)[0].count
    ).toBe(1);
});
