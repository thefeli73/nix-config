{pkgs-unstable, ...}: {
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;
    settings = {
      theme = "gruvbox";
      tui = {
        scroll_speed = 1;
        scroll_acceleration.enabled = false;
      };
    };
    commands = {
      init = ./opencode/commands/init.md;
    };
    skills = {
      brainstorming = ./opencode/skills/brainstorming;
      building-native-ui = ./opencode/skills/building-native-ui;
      copy-editing = ./opencode/skills/copy-editing;
      copywriting = ./opencode/skills/copywriting;
      frontend-design = ./opencode/skills/frontend-design;
      shadcn = ./opencode/skills/shadcn;
      test-driven-development = ./opencode/skills/test-driven-development;
      using-git-worktrees = ./opencode/skills/using-git-worktrees;
      using-superpowers = ./opencode/skills/using-superpowers;
      vercel-react-native-skills = ./opencode/skills/vercel-react-native-skills;
      verification-before-completion = ./opencode/skills/verification-before-completion;
      writing-agents-md = ./opencode/skills/writing-agents-md;
    };
    rules = ''
# AGENTS.md

## Ask Before Acting

**Always ask clarifying questions when:**

- The request is vague or ambiguous
- You need specific implementation details
- There are multiple reasonable approaches to solve the problem
- You're unsure about naming conventions, file locations, or architectural decisions

**Do not assume.** Even if one approach seems "good enough," check with me first when there are multiple viable options. This saves tokens and avoids rework.

**Why This Matters:**

- Reduces wasted tokens on incorrect implementations
- Saves time by avoiding redo cycles
- Ensures the final result matches my actual intent
- Builds shared understanding of the codebase and preferences

## Language and Locale Preferences (English language, Swedish locale)

When writing user-facing text, **write in English** but default to **Swedish local conventions** for formatting:

- Use Swedish characters (`å`, `ä`, `ö`) when appropriate; do not transliterate to ASCII.
- Use natural Swedish phrasing when the conversation is in Swedish.
- Prefer Swedish date/time formatting:
  - `YYYY-MM-DD` for filenames/structured notes
  - `15 februari 2026` for prose
  - 24-hour time (e.g. `14:30`)
- Prefer Swedish number/currency formatting in prose:
  - decimal comma: `3,14`
  - thousands separator as space: `12 500`
  - currency style: `12 500 kr`
- Keep code, commands, IDs, and machine-readable formats unchanged even when locale differs.

## Commits
- Never commit `.sisyphus` or plans that were used just as helper documents for a specific task
    '';
  };
}
