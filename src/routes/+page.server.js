import sql from "../db";

export async function load() {
    return {
        users: (
            await sql`
                SELECT
                    users.id AS id,
                    users.username AS username
                FROM auth.users
            `
        )
    };
}
