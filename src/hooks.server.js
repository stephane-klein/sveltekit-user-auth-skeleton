import sql from "$lib/server/db.js";

export async function handle({ event, resolve }) {
    const sessionId = event.cookies.get("session");

    if (sessionId) {
        try {
            const rows = await sql`
                SELECT
                    users.id,
                    users.username,
                    users.first_name,
                    users.last_name,
                    users.email,
                    users.is_staff,
                    users.is_active,
                    users.last_login,
                    users.date_joined,
                    users.created_at,
                    users.updated_at
                FROM
                    auth.sessions
                INNER JOIN auth.users
                    ON sessions.user_id = users.id
                WHERE
                    sessions.id=${sessionId}
            `;
            if (rows?.length > 0) {
                event.locals.user = rows[0];
            }
        } catch (e) {
            console.log(e);
        }
    }
    if (!event.locals.user) event.cookies.delete("session");

    const response = await resolve(event);
    return response;
}
