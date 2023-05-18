import { redirect } from "@sveltejs/kit";
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
        console.log("res");
        console.log(res?.rows);
        console.log(res?.rows[0]);
        console.log(res?.rows[0].authenticate?.sessionId);
        cookies.set("session", res?.rows[0].authenticate?.sessionId, { path: "/" });
        throw redirect(302, "/");
    }
};
