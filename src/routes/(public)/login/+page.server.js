import { redirect, fail } from "@sveltejs/kit";
import db from "../../../db";

export const actions = {
    default: async({ request, cookies }) => {
        const data = await request.formData();
        const res = await db.query(
            `
                SELECT public.authenticate(
                    input_username=>'',
                    input_email=>$1,
                    input_password=>$2
                )
            `,
            [
                data.get("email"),
                data.get("password")
            ]
        );
        if (res?.rows[0].authenticate?.sessionId !== null) {
            cookies.set("session", res?.rows[0].authenticate?.sessionId, { path: "/" });
            throw redirect(302, "/");
        } else {
            cookies.delete("session");
            return fail(
                400,
                {
                    email: data.get("email"),
                    error: res?.rows[0].authenticate.status
                }
            );
        }
    }
};
