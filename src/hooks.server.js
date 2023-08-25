import db from "./db";

export async function handle({ event, resolve }) {
    const sessionId = event.cookies.get("session");

    if (sessionId) {
        console.log(sessionId);
        try {
            const { rows } = await db.query(
                `
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
                        sessions.id=$1
                `,
                [sessionId]
            );
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
