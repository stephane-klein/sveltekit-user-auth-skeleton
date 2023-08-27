<script>
    export let form;
</script>

<form method="POST">
    {#if form?.error}<p class="error">{form.error}</p>{/if}
    <div>
        <label for="email">Email:</label>
        <input id="email" name="email" type="email" required="required" value={form?.email ?? ""} />
    </div>
    <div>
        <label for="username">Username:</label>
        <input id="username" name="username" type="text" required="required" value={form?.username ?? ""} />
    </div>
    <div>
        <label for="password">Password:</label>
        <input id="password" name="password" type="password" />
    </div>
    <div>
        <label for="first_name">First name:</label>
        <input id="first_name" name="first_name" type="text" value={form?.first_name ?? ""} />
    </div>
    <div>
        <label for="last_name">Last name:</label>
        <input id="last_name" name="last_name" type="text" value={form?.last_name ?? ""} />
    </div>

    <input type="submit" value="Signup" />
    |
    <a href="../">back</a>
</form>
