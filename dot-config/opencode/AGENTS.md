# Global Agent Instructions

## Commit Conventions

When the user requests a commit message, follow this structure:

```txt
type(scope): short description

Longer body paragraphs explaining what and why.
Keep body paragraphs concise but informative.

Co-authored-by: <Model Name> <email>
```

The heading uses conventional commit types: `feat:`, `fix:`, `chore:`, `docs:`,
`style:`, `refactor:`, `test:`, etc.

### Scope

Scope (e.g., `feat(api): ...`) is optional per Conventional Commits, but
consistency within a repo matters more than the choice itself.

- **Before committing**, scan ~50 recent commits (`git log --oneline -50`) to
  detect the repo's scope conventions — naming, casing, and granularity.
- **If scopes are established**: match the existing convention exactly. Don't
  invent new scope names without checking.
- **If no scope is found in recent history**: propose a scope name based on
  the files touched and wait for user confirmation before committing.
- **If the repo doesn't follow conventional commits at all**: ask the user
  whether to (a) adopt the repo's existing style and save that as a
  repo-scoped memory entry, or (b) start using conventional commits going
  forward. Don't unilaterally impose a style.

### Co-author trailer

- **Determine authorship based on the active model**: Use the model's identity
  and email if available. If the agent has no clear signal about which model
  authored the work, ask the user to pick the model's name and email.
- **If context suggests a different model** was involved (mentioned in
  conversation, evident from tool/session metadata, etc.), ask once to confirm
  before using it.

### Additional trailers

Beyond `Co-authored-by`, commits can carry other trailers like
`Signed-off-by`, `Acked-by`, `Helped-by`, `Reviewed-by`, `See-also`,
`Reported-by`, `Suggested-by`, etc.

- **Scan recent commits** for established trailer patterns when preparing a
  commit. If the repo consistently uses certain trailers (e.g., DCO
  sign-off), match the convention.
- **Before committing**, ask whether any additional trailers apply — a quick
  "anyone else to credit, ack, or sign off?" is enough.
- **Be proactive**: if the user mentioned earlier in the conversation that
  someone helped, reviewed, suggested, or reported the issue, surface the
  relevant trailer as a suggestion rather than waiting to be asked.

### Common model emails (hint, not exhaustive)

Agents should infer the email format for models not listed here based on the
provider's domain pattern.

<!-- markdownlint-disable MD013 -->
| Model                  | Email                                                  |
|------------------------|--------------------------------------------------------|
| DeepSeek R1 / V3       | [service@deepseek.com](mailto:service@deepseek.com)    |
| Claude (any version)   | [noreply@anthropic.com](mailto:noreply@anthropic.com)  |
| GPT / Codex / o-series | [noreply@openai.com](mailto:noreply@openai.com)        |
| Gemini                 | [noreply@google.com](mailto:noreply@google.com)        |
| Grok                   | [noreply@x.ai](mailto:noreply@x.ai)                    |
<!-- markdownlint-enable MD013 -->

### Pre-commit checks

Before generating a commit message, run `git diff --cached --check` to catch
trailing whitespace and unresolved merge conflict markers. If anything
surfaces, warn the user and let them decide whether to fix and re-stage or
proceed as-is. Don't run linters, formatters, or tests proactively — those
are repo-specific and belong in the repo's own `AGENTS.md`.

### Amending commits

Before amending any commit:

1. Check whether the commit has been pushed.
2. Verify the current branch is the intended one.
3. Ask the user for explicit confirmation before proceeding.

## Memory & Tools

- Use the `@knikolov/opencode-plugin-simple-memory` plugin to read and write
  memory in `.opencode/memory` log files via its memory tools. This applies
  for project-specific memories. If the user chats about global memories
  refer to `~/.config/opencode/[AGENTS.md](http://AGENTS.md)` and **do not**
  add project-based memories globally, nor global-based memories on the
  project. `@knikolov/opencode-plugin-simple-memory` and its tools work only
  on the project, not globally.
- **At session start**, check memory and surface relevant entries proactively
  rather than silently applying them. The user should know what context the
  agent is operating with.
- Store both project-scoped and global preferences as they're learned.
- Prefer consistency and predictability across responses and code output.

## Workflow

### Brainstorming

- Invoke the **brainstorming** superpower skill when requirements are
  ambiguous — this is the primary trigger.
- Size of the change is a secondary trigger: only invoke brainstorming for
  large changes if the approach isn't already clear.
- Small, well-specified changes don't need brainstorming regardless of file
  count.

### Clarifying questions

- Treat ambiguity as high priority — ask clarifying questions rather than
  guessing.
- Ask as many questions as genuinely needed, but **collapse overlapping or
  near-duplicate questions into one**. If two questions imply the same
  underlying uncertainty, the answer to one likely answers the other.
- If a clarifying loop starts circling, **proceed with a stated assumption**
  rather than blocking on more questions. The user can correct the assumption
  if it's wrong.

### Branch discipline

- **Do not work on `main`** unless the user explicitly requests it. Always
  confirm the target branch.
- **Do not `git push` to any remote** without explicit user confirmation,
  regardless of branch.

## Error Recovery

When a tool, command, or operation fails, tier the response by how critical
the failing component is:

- **Critical** (superpowers skills, git itself, anything the current task
  depends on directly) — stop and report. Don't work around the failure
  without explicit user confirmation.
- **Medium** (auxiliary tooling, optional integrations) — mention the
  failure, keep it in mind for the rest of the session, and continue with
  the task.
- **Minor** (transient warnings, cosmetic issues) — retry once or ignore.

General rules across all tiers:

- Report errors verbatim with exit codes when available. Don't paraphrase
  tool output.
- Don't auto-retry without confirmation unless the failure is clearly
  transient (network timeout, rate limit). One retry maximum.
- For the memory plugin specifically: if a **read** fails at session start,
  mention it and proceed without that context. If a **write** fails when the
  user explicitly asked to save something, stop and report — losing intended
  context is worse than operating without prior context.

### Git-specific recovery

If git surfaces an unexpected state — merge conflict, detached HEAD, dirty
working tree, rebase or cherry-pick in progress, untracked files blocking a
checkout — **stop and report**. Do not attempt to auto-stash, auto-reset, or
otherwise resolve the state. Surface the exact git output and let the user
decide how to proceed.

## Secrets & Sensitive Data

- **Never commit secrets, credentials, tokens, private keys, or `.env`
  files.** If obvious patterns appear in a staged diff (API keys, bearer
  tokens, private key headers, password assignments), abort the commit and
  warn with the file and line reference.
- Detection is **passive**: don't run a full secret scanner on every diff.
  The expectation is that the agent notices obvious patterns during normal
  review, not that it guarantees coverage.
- **Don't log or store sensitive information in agent memory**, even if the
  user pastes it directly. If a memory entry would otherwise contain a
  secret, reference it abstractly instead (e.g., "user's API key for service
  X is configured locally") rather than recording the value.

## Decision Making

For any questionable operation, ask for user confirmation first — even for
small things. This includes:

- Amending commits (especially pushed ones)
- Pushing to any remote
- Force pushes, rebases, or any history-rewriting operation
- Destructive git commands (`reset --hard`, `clean -fd`, branch deletion, etc.)
- Working on `main` or other protected branches

Verify before acting:

- Is the commit pushed?
- Am I on the right branch?
- Does the user actually want this, or are they thinking out loud?

<!-- codebase-memory-mcp:start -->
# Codebase Knowledge Graph (codebase-memory-mcp)

This project uses codebase-memory-mcp to maintain a knowledge graph of the codebase.
ALWAYS prefer MCP graph tools over grep/glob/file-search for code discovery.

## Priority Order
1. `search_graph` — find functions, classes, routes, variables by pattern
2. `trace_path` — trace who calls a function or what it calls
3. `get_code_snippet` — read specific function/class source code
4. `query_graph` — run Cypher queries for complex patterns
5. `get_architecture` — high-level project summary

## When to fall back to grep/glob
- Searching for string literals, error messages, config values
- Searching non-code files (Dockerfiles, shell scripts, configs)
- When MCP tools return insufficient results

## Examples
- Find a handler: `search_graph(name_pattern=".*OrderHandler.*")`
- Who calls it: `trace_path(function_name="OrderHandler", direction="inbound")`
- Read source: `get_code_snippet(qualified_name="pkg/orders.OrderHandler")`
<!-- codebase-memory-mcp:end -->
