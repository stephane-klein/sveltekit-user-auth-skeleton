import { redirect } from "@sveltejs/kit";
import sql from "../../../db";

export const actions = {
    default: async({ request }) => {
        const data = await request.formData();
        await sql`
            SELECT auth.create_user(
                username   => ${data.get("username")},
                first_name => ${data.get("first_name")},
                last_name  => ${data.get("last_name")},
                email      => ${data.get("email")},
                password   => ${data.get("password")},
                is_staff   => false,
                is_active  => true
            );
        `;
        throw redirect(302, "/");
    }
};
