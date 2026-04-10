---
description: Create or refactor AGENTS.md using minimal non-discoverable requirements
---
Use the `writing-agents-md` skill first.

Task:
Analyze this repository and create or refactor `/AGENTS.md` so it is extremely high-signal, low-bloat, and practical for agentic coding. Context files with unnecessary requirements tend to reduce task success rates and increase cost. Follow the principles of **minimal requirements**, **non-discoverable guidance only**, and **verifiable rules**.

Important chain context:
You are generating a static `AGENTS.md` that will be always loaded by future worker LLMs. Those workers have the repository and this AGENTS file, but not your current reasoning. Write for worker execution quality, not meta explanation.

Important clarification policy:
If non-repo knowledge is missing and would change rules, ask the developer now while generating AGENTS. Do not postpone those questions to future workers.

Requirements:
1. **Worker-decision filter (required)**: keep a line only if it is non-discoverable, decision-changing, actionable, and verifiable.
2. **Generator asks questions right away**: when non-repo knowledge gaps are material, ask one targeted question at a time with a recommended default and what changes based on the answer.
3. **Do not defer known unknowns**: do not add generic placeholders telling future workers to ask the developer about questions you can ask now.
4. **Apply a discoverability test to every candidate rule**: if the answer can be found quickly by exploring the repo (files, configs, package scripts, tests), do not include it in AGENTS.md.
5. **Remove generic bloat**: Discard architecture dumps, style manifestos, generic repo summaries (folders, scripts, stack), file inventories, and broad technology mentions unless truly hidden.
6. **Do not add AGENTS meta boilerplate**: lines like "keep guidance minimal/high-signal" are process commentary and should not be in repo AGENTS.
7. **Never add self-referential AGENTS governance/maintenance content**: do not include rules about AGENTS authoring itself (e.g., "keep this file under 100 lines", "remove discoverable rules", "add rules only after repeated failures").
8. **Purpose is optional**: include Purpose only when it carries non-discoverable repo/business context that changes implementation tradeoffs.
9. **Focus on verification**: Put executable, verifiable commands early (e.g., `pnpm typecheck` before completion).
10. **Use the recommended structure**:
   - Purpose (optional, repo-specific, and non-discoverable; otherwise omit)
   - Hard constraints (safety/security)
   - Verification commands
   - Known failure patterns (use When/Do/Verify/Scope template)
   - Legacy boundaries
   - Clarification path (fallback only, after generator-time questions)
11. **Avoid preemptive rules**: Add rules only for known failure patterns. Avoid broad "Do not do X" rules as they introduce behavioral bias toward X.
12. Merge relevant guidance from `.cursor/rules/**`, `.cursorrules`, and `.github/copilot-instructions.md` if present, but **ruthlessly discard any unnecessary or discoverable rules**.
13. Keep the root file as short as possible (well under 100 lines).
14. If uncertainty materially affects behavior and cannot be resolved from repo evidence, ask the developer one targeted clarifying question with a recommended default.

Deliverables:
- Updated `/AGENTS.md` following the new minimal structure
- List of non-repo questions asked during generation and the answers incorporated into AGENTS.
- Brief report listing what was kept, what was removed (and why), and which retained rules are non-discoverable.
- Confirmation that no self-referential AGENTS-governance/maintenance rules were written into AGENTS.
- Any still-open non-discoverable questions (should be empty unless developer was unavailable).
- A short "dropped items" list of at least 3 candidate lines that were removed for being discoverable or non-actionable.

Do not run full-repo builds unless required.
