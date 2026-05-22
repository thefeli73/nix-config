# Root AGENTS.md Template

Use this as a starting point. Keep only sections relevant to the repository.

```markdown
# AGENTS.md

This repository is a [one-sentence project description].
Package manager: [npm|pnpm|bun|yarn].

## Commands
- Typecheck changed files: `[exact command]`
- Lint changed files: `[exact command]`
- Test changed files: `[exact command]`
- Full build (only when requested or needed): `[exact command]`

## Boundaries

### Always
- Keep diffs focused and small.
- Validate changed files before claiming completion.
- Follow established project patterns in touched areas.

### Ask first
- Installing dependencies.
- Running expensive full-repo commands.
- Schema, infra, or deployment changes.

### Never
- Commit secrets or credentials.
- Modify vendor/generated files unless explicitly requested.
- Use destructive git commands without explicit approval.

## Code and Workflow Expectations
- [Language/framework conventions that apply broadly]
- [Testing expectations]
- [Commit/PR expectations if relevant]

## Project Navigation Hints
- [Stable capability-level hints, not brittle full path maps]

## Progressive Disclosure
- For TypeScript conventions: `docs/agents/typescript.md`
- For testing strategy: `docs/agents/testing.md`
- For API patterns: `docs/agents/api.md`
```

Notes:
- Prefer concise, enforceable rules over long explanations.
- Avoid path-level detail that is likely to go stale.
- Keep root AGENTS as routing + policy, not an encyclopedia.
