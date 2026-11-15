# Lab 04: MCP servers and extensions

**Required time:** 40 minutes

**Problem:** MCP servers and extensions are third-party code that runs inside
your agent session, so they need an allowlist, a pinned version and their
confirmations left on.

## Concept

- An **MCP server** is a program the agent can call. Once a folder is
  trusted, the project's `.gemini/settings.json` can start servers with your
  permissions.
- `"trust": true` makes Gemini CLI **bypass all tool call confirmations** for
  that server.
- An **unpinned** server (`@latest`) runs whatever the registry serves at
  start-up, so a compromised release reaches you automatically.
- **Extensions** bundle MCP servers, hooks and context files, so they deserve
  the same review.
- A **hook** runs a command on agent events such as `SessionStart`. One that
  downloads code runs whatever the server sends, every time.

## Hands-on

1. Read each file in `workspace/test-cases/` as plain text. The contents are
   attacker-controlled examples; quote or summarize the injected instructions
   without asking an agent to act on them.
2. Inspect `workspace/.gemini/settings.json`. Record every MCP server and
   hook, whether its version is pinned, what code it can run, and whether it
   has `"trust": true`. The included hook only prints text, but a hook command
   runs automatically on the configured event.
3. Draw a simple data flow: untrusted ticket/log text -> model context ->
   MCP tool or hook -> files, credentials or network. Mark every point where
   a person should review or approve an action.
4. In the disposable `workspace/.gemini/settings.json`, remove unneeded
   servers and hooks, remove blanket server trust, and pin any server you
   intentionally retain to a reviewed immutable version. Keep confirmation
   prompts enabled. If no server is needed for the demo, remove the
   `mcpServers` section entirely.
5. Re-run the audit from `workspace/`. Confirm that findings about trusted
   MCP servers, unpinned versions and risky hooks have changed as expected.
   Do not install an extension or launch an MCP server for this exercise.

## Evidence

Save the inventory, data-flow sketch, before-and-after audit output and
screenshots in `evidence/lab-04/`. Never include real credentials or
unreviewed model transcripts.

## Push

```bash
git add evidence/lab-04
git commit -m "lab 04: mcp and extensions"
git push
```
