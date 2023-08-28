import { redirect, fail } from "@sveltejs/kit";
import sql from "$lib/server/db.js";

export async function GET({locals, params, url}) {
    if (locals?.user?.is_staff) {
        await sql`
            UPDATE auth.sessions
               SET impersonate_user_id=${params.user_id}
             WHERE id=${locals.session_id}
        `;
        throw redirect(
            302,
            url.searchParams.get("redirect") || "/"
        );
    } else {
        return fail(400);
    }
};
