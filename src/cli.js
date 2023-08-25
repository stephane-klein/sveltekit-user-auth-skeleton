import yargs from "yargs/yargs";
import { hideBin } from "yargs/helpers";

import db from "./db.js";

await yargs(hideBin(process.argv))
    .command("user", "Manage users", (yargs) =>
        yargs.command(
            "create",
            "create a user",
            (yargs) =>
                yargs.options({
                    username: {
                        string: true,
                        demandOption: true
                    },
                    firstname: {
                        default: undefined,
                        string: true
                    },
                    lastname: {
                        default: undefined,
                        string: true
                    },
                    email: {
                        string: true,
                        demandOption: true
                    },
                    password: {
                        string: true,
                        demandOption: true
                    },
                    staff: {
                        boolean: true,
                        default: false
                    }
                }),
            async (argv) => {
                try {
                    await db.query(
                        `
                                    SELECT auth.create_user(
                                        username   => $1,
                                        first_name => $2,
                                        last_name  => $3,
                                        email      => $4,
                                        password   => $5,
                                        is_staff   => $6,
                                        is_active  => true
                                    );
                                `,
                        [argv.username, argv?.firstname, argv?.lastname, argv.email, argv.password, argv.staff]
                    );
                } catch (err) {
                    console.log(err.message);
                } finally {
                    db.end();
                }
            }
        )
    )
    .parse();
