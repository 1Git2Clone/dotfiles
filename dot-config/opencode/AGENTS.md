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

- **Default to DeepSeek R1** (`Co-authored-by: DeepSeek R1
  <[service@deepseek.com](mailto:service@deepseek.com)>`) when the agent has
  no clear signal about which model authored the work. This is the most
  common case in OpenCode where agents lack self-awareness of their own
  identity.
- **If context suggests a different model** was involved (mentioned in
  conversation, evident from tool/session metadata, etc.), ask once to
  confirm before using it.
- **If genuinely unclear**, omit the trailer and briefly note why so the
  user can add it manually.

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

| Model                  | Email                                                    |
|------------------------|----------------------------------------------------------|
| DeepSeek R1 / V3       | `[service@deepseek.com](mailto:service@deepseek.com)`    |
| Claude (any version)   | `[noreply@anthropic.com](mailto:noreply@anthropic.com)`  |
| GPT / Codex / o-series | `[noreply@openai.com](mailto:noreply@openai.com)`        |
| Gemini                 | `[noreply@google.com](mailto:noreply@google.com)`        |
| Grok                   | `[noreply@x.ai](mailto:noreply@x.ai)`                    |

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
