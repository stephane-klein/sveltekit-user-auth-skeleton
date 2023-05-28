<script>
    export let form;
</script>

<form method="POST">
    {#if form?.error}<p class="error">{form.error}</p>{/if}
    <label>
        Email
        <input name="email" type="email" value={form?.email ?? ""} />
    </label>
    <label>
        Password
        <input name="password" type="password" />
    </label>

    <input type="submit" value="Login" />
</form>
