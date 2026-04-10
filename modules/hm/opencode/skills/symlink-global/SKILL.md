---
name: symlink-global
description: Fetch, pull, and symlink agent skills and global OpenCode command files from a git repo to ~/.agents and ~/.config/opencode for global availability. Use when setting up a new machine, syncing global config, updating skills/commands, or making version-controlled agent tooling available system-wide.
---

# Symlink Global Agent Skills and Commands

## When to use this skill

Use this skill when:
- Setting up agent skills on a new machine
- Making skills from a git repo available globally
- Syncing/updating version-controlled config to the global location
- Pulling latest changes to skills and commands
- The user mentions "global config", "symlink skills", "symlink commands", "sync skills", "update skills", "update commands", or "new machine setup"

## Prerequisites

- A git-tracked agent skills directory (like this one)
- Skills located in `.agents/skills/`
- `AGENTS.md` present in the repo root
- OpenCode commands in `.opencode/commands/`

## Instructions

### Step 1: Run the script

From within your git repo:

```bash
./.agents/skills/symlink-global/scripts/symlink-global.sh
```

### Step 2: Verify

```bash
ls -la ~/.agents/skills
ls -la ~/.agents/AGENTS.md
ls -la ~/.config/opencode/commands
```

## Notes

- The script will symlink `skills` and `AGENTS.md` into `~/.agents/`, and commands into `~/.config/opencode/commands`.
- It refuses to overwrite a real file at `~/.agents/AGENTS.md` (only replaces an existing symlink).
- It refuses to overwrite a real directory at `~/.config/opencode/commands` (migrate files into repo first).

## Edge cases

- **Existing directory at target**: The script will NOT overwrite a real directory - you must manually handle this
- **Existing symlink**: The script will replace existing symlinks (idempotent)
- **Not in a git repo**: The script will fail with a clear error
- **Different repo location on different machines**: Works fine - symlink points to wherever the repo is cloned
- **Local uncommitted changes**: Git pull uses `--ff-only`, so it won't overwrite local changes - it will warn and continue
- **No network/remote**: Fetch may fail but script continues with current state
- **Existing commands directory at target**: The script will NOT overwrite `~/.config/opencode/commands`; migrate and remove first

## After running

Skills and commands from your git repo will be available globally. You can verify by:
1. `cd` to any directory outside the repo
2. Run `opencode`
3. Your skills should appear in the skill tool's available skills list
4. Run `/init` and confirm your version-controlled custom command is used
