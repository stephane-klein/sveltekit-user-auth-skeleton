import { redirect, fail } from "@sveltejs/kit";
import sql from "../../../db";

export const actions = {
    default: async({ request, cookies }) => {
        const data = await request.formData();
        const authenticateResult = (await sql`
            SELECT auth.authenticate(
                input_username=>'',
                input_email=>${data.get("email")},
                input_password=>${data.get("password")}
            )
        `)[0]?.authenticate;
        if (authenticateResult.sessionId !== null) {
            cookies.set("session", authenticateResult?.sessionId, { path: "/" });
            throw redirect(302, "/");
        } else {
            cookies.delete("session");
            return fail(400, {
                email: data.get("email"),
                error: authenticateResult.status
            });
        }
    }
};
