<script lang="js">
    export let data;
</script>

<h1>Users</h1>

<ul>
    {#each data.users as user}
        <li>{user.id} - {user.username}</li>
    {/each}
</ul>

<hr />

{#if data?.user}
    {data?.user?.first_name}
    {data?.user?.last_name}

    <hr />

    <a data-sveltekit-reload href="/logout/">Logout</a>
{:else}
    <a data-sveltekit-reload href="/login/">Login</a>
{/if}
