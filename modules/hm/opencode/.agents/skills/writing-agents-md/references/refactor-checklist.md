# AGENTS.md Refactor Checklist

## 1) Inventory Inputs

- Existing `AGENTS.md` files (root + nested)
- `.cursor/rules/**` and `.cursorrules`
- `.github/copilot-instructions.md`
- `opencode.json` / `config.json` instructions includes

## 2) Classify Every Rule

- `root`: applies to nearly all tasks
- `domain`: belongs in a linked domain doc
- `scoped`: belongs in package-level AGENTS
- `safety`: always/ask-first/never boundary
- `stale`: path/reference likely outdated
- `noise`: vague or non-actionable

## 3) Resolve Conflicts

- Remove contradictory guidance.
- Keep one canonical version of each rule.
- Ask one targeted question only when conflict cannot be resolved from repo evidence.

## 4) Rebuild Root (Lean)

- Commands near the top; include file-scoped checks.
- Three-tier boundaries: Always / Ask first / Never.
- Explicit stack + package manager when non-obvious.
- Clear links to deeper docs.
- Target: 40-120 lines (avoid >180 unless justified).

## 5) Validate Quality

- Commands are runnable in this repository.
- Rules are measurable and enforceable.
- No stale brittle file-path maps.
- No duplicate guidance across AGENTS/Cursor/Copilot.
- Secrets and destructive operations are explicitly guarded.

## 6) Deliverables

- Updated root `AGENTS.md`
- Any new `docs/agents/*.md` files for moved detail
- Optional scoped AGENTS files for monorepo packages
- Short change note: kept / moved / removed / unresolved
