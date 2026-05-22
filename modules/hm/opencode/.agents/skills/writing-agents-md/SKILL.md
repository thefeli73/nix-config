---
name: writing-agents-md
description: Use when creating, reviewing, migrating, or refactoring AGENTS.md (or equivalent rule files like CLAUDE.md/Cursor/Copilot instructions) to produce high-signal, low-bloat agent guidance.
---

# Writing AGENTS.md Files

## Overview

Write AGENTS.md files that are extremely short, enforceable, and useful in real coding sessions.

**Crucial Research Finding:** Big AGENTS.md files often *reduce* agent quality by adding distracting context. Stale instructions are worse than no instructions, and large rule files make debugging failures harder. Both LLM-generated and human-written context files that are too long increase cost and time overhead while rarely improving success rates.

Therefore, context files must describe **only the minimal requirements** needed for the repository. Optimize for instruction budget: keep root guidance absolutely lean and verifiable.

Use AGENTS.md for information the model cannot reliably discover from the codebase itself (team policies, business constraints, known traps, and required verification behavior).

## Chain Model (Author -> Generator -> Worker)

- This is a multi-hop system: skill/init prompt -> AGENTS generator LLM -> always-loaded AGENTS.md -> worker LLM.
- Write instructions to survive translation across hops. Prefer explicit, testable directives over abstract guidance.
- Optimize for the final consumer (worker LLM with repo + AGENTS only), not for generator prose quality.
- Remove any line that does not directly improve worker decisions, safety, or verification behavior.
- During AGENTS generation, ask the developer targeted questions immediately for non-repo knowledge gaps.
- Prefer resolved facts in AGENTS over placeholder instructions that future workers should ask later.

## Outputs

- Create a new root `AGENTS.md` from repository signals.
- Refactor an existing `AGENTS.md` by ruthlessly pruning bloat.
- Split legacy or domain-heavy guidance into progressive-disclosure docs or delete it.

## Core Principle: Non-Discoverable Only

- Keep rules only if they answer a question that cannot be found quickly via repo exploration.
- If the agent can discover it via file search, package files, tests, or configs, do not put it in AGENTS.md.
- Prefer one clear clarification question to the developer over adding speculative or generic rules.
- If uncertainty is material and non-discoverable, ask one targeted question with a recommended default.

## Recommended AGENTS.md Structure (Minimal)

When creating or refactoring `AGENTS.md`, use this structure:
1. **Purpose (optional):** include only if non-discoverable product/business context materially changes implementation decisions. If not needed, omit this section.
2. **Hard constraints:** Safety/security/destructive-command policy that are not already obvious or present in a global AGENTS file.
3. **Verification:** Exact commands to run before claiming success (e.g. `pnpm typecheck`).
4. **Known failure patterns:** Short "if X, do Y" rules from real incidents.
5. **Legacy boundaries:** Where old/deprecated tech is allowed (keep isolated).
6. **Clarification path (fallback):** only for truly future ambiguity; do not use this as a substitute for asking questions during AGENTS generation.

If a Purpose section is included, it must describe repository/product intent, not meta-guidance about how AGENTS files should be written.

If included, Purpose should answer: "What non-discoverable context would make a worker choose a different implementation tradeoff?"

Never include AGENTS-governance content in generated AGENTS output (for example: "keep this file under 100 lines", "remove discoverable rules", or "add rules only after failures"). That belongs in generator instructions, not worker instructions.

## Worker-Decision Test (Keep/Drop Filter)

Keep a line only if all checks pass:
1. **Non-discoverable:** cannot be found quickly from repo exploration.
2. **Decision-changing:** would likely change worker implementation behavior.
3. **Actionable:** names a concrete action or command.
4. **Verifiable:** can be checked with command output, diff, or status.

If any check fails, delete the line.

## Generator-First Clarification (Ask Now, Not Later)

- While drafting AGENTS, identify non-repo unknowns that would change rules.
- Ask the developer one targeted question at a time, with a recommended default and what changes based on the answer.
- Incorporate answers into concrete AGENTS rules immediately.
- Do not defer known unknowns into AGENTS as generic "ask the developer" placeholders.

## Rule-Writing Template

When writing a specific rule for known failure patterns or legacy boundaries, use this exact pattern:
- **When:** specific trigger/situation.
- **Do:** exact action.
- **Don't:** prohibited action (only if strictly necessary - avoid saying "Do not do X" because it makes the model think about X).
- **Verify:** concrete command/output expected.
- **Scope:** files/dirs/features it applies to.

*Example:*
- **When:** editing TypeScript files under `src/`
- **Do:** run `pnpm typecheck`.
- **Verify:** with exit code 0 from `pnpm typecheck`.
- **Scope:** all non-doc changes.

## Workflow

### 0) Model the downstream consumer first

- Treat AGENTS.md as static always-on context for future worker LLMs.
- Avoid writing instructions that only explain AGENTS philosophy ("minimal", "high-signal") unless they enforce a concrete behavior.
- Prefer concise imperative statements that survive paraphrasing across model hops.
- Resolve non-repo knowledge gaps now by asking the developer during generation.
- Minimize future worker clarifications by encoding resolved answers as concrete rules.

### 1) Determine scope and collect rule sources

- Detect whether task is: create new, refactor existing, or audit and recommend.
- Load instruction sources (`AGENTS.md`, `.cursorrules`, `.github/copilot-instructions.md`, etc.).
- Tag candidate instructions as `discoverable` or `non-discoverable` before drafting.

### 2) Extract, classify, and deduplicate instructions

- Classify each rule and *aggressively discard* discoverable repo specifics, generic advice, auto-generated architecture dumps, and standard tech stack mentions that the agent can already discover.
- Keep only high-signal, non-obvious, failure-preventing rules.
- Add rules only when there is a repeated observed failure, not preemptively.

### 3) Resolve contradictions and prune

- Identify direct conflicts and remove ambiguity.
- Discard stale guidance (it biases wrong actions).
- If conflict materially changes behavior and repository evidence cannot disambiguate, ask one targeted question with a recommended default.

### 4) Draft a minimal, high-signal root AGENTS.md

- Keep it as short as possible. Unnecessary requirements reduce task success rates.
- Target size: well under 100 lines; ruthlessly cut anything that isn't absolutely required.
- Put verifiable runnable commands early.
- Prefer file-scoped checks first; full-repo checks only when needed.
- Re-read draft from worker perspective: "Would this line change what I do right now?"

### 5) Clarify non-repo knowledge during generation

- When ambiguity is not answerable from repository evidence, ask the developer immediately during AGENTS generation.
- Ask one targeted question at a time with a recommended default and what would change.
- Convert the answer into concrete AGENTS rules now.
- Do not defer known unknowns by writing generic "ask developer" instructions for workers.
- Keep the Clarification path section only as fallback for genuinely future, task-time ambiguity.

## What to Remove or Avoid

- **Auto-generated architecture dumps or generic repo summaries** (folders, scripts, stack) unless truly hidden/non-discoverable.
- **Directory/file inventories** that agents can discover in seconds by traversing the repo.
- **Generic "Purpose" boilerplate** like "keep guidance minimal/high-signal" that does not encode repo-specific decisions.
- **Meta process text** about how AGENTS should be written when it does not change worker behavior.
- **Self-referential maintenance sections** about AGENTS authoring/governance (line limits, pruning policy, rule-writing policy).
- **Placeholder rules** that tell future workers to ask questions the generator could ask right now.
- **Full package/script lists** copied from package.json.
- **"Style manifesto" text** that does not change decisions.
- **Broad technology mentions** that trigger wrong framework/tool usage.
- **Rules that cannot be checked or measured** (e.g. "write clean code").
- **"Do not do X" rules** unless absolutely necessary (they introduce behavioral bias toward X).

## Operational Process to Recommend

If explaining the process to the user, suggest:
1. Start with minimal rules.
2. Observe failures in real runs.
3. Fix codebase/tooling first (tests, structure, feedback loops).
4. Add one narrow rule only if failure persists.
5. Re-test.
6. Prune rules that no longer prevent failures.

## Quality Gate

Before finalizing, verify:
- Commands are executable and match the actual toolchain.
- Single-file validation commands exist where feasible.
- Root rules follow the "When/Do/Verify/Scope" template.
- Purpose section is omitted unless it carries non-discoverable, decision-relevant repo context.
- No AGENTS meta-boilerplate remains (e.g., "keep this minimal/high-signal").
- Generated AGENTS contains no self-referential AGENTS-governance or AGENTS-maintenance section.
- Non-repo unknowns were resolved by asking the developer during generation.
- AGENTS does not contain avoidable "ask developer" placeholders.
- Every retained rule is non-discoverable or a required safety boundary.
- Safety boundaries include secrets and destructive operations.
- Architecture dumps, style manifestos, and stale/brittle path guidance are completely removed.
- Root file stays exceptionally lean.
