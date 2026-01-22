# AGENTS.md

This repository is a flake-based NixOS + Home Manager configuration.

## Safety / consent (read this first)

- Treat anything with `sudo`, `nixos-rebuild switch`, or `nix flake update` as high-impact.
- Do not activate/switch the running system unless the user explicitly asked.
- Do not commit or push unless explicitly requested.
- Never create/commit secrets (notably `.env` is gitignored).

## Repo layout

- `flake.nix`: flake inputs/outputs; defines `nixosConfigurations`.
- `hosts/<host>/configuration.nix`: host-specific NixOS config (imports shared modules).
- `hosts/<host>/hm/*`: host-specific Home Manager additions.
- `modules/common.nix`: shared baseline (includes Home Manager module).
- `modules/programs.nix`: shared system packages and program configs.
- `modules/desktops/*`: shared desktop/environment modules.
- `modules/hm/*`: reusable Home Manager modules.
- Scripts (use with care): `rebuild-nix-system.sh`, `update-nix-system.sh`.

## Build / lint / test commands

### Discover outputs (safe)

- List flake outputs:
  - `nix flake show`

### Fast evaluation (safe)

- Evaluate flake without building:
  - `nix flake check --no-build`

Notes:
- This flake currently has no explicit `checks` outputs; `nix flake check` still validates evaluation.

### “Single test” equivalents (Nix)

NixOS configs don’t have unit tests here; the closest equivalent is building a single derivation:

- Build one host’s system closure (CI-like, no activation):
  - `nix build .#nixosConfigurations.<host>.config.system.build.toplevel`

If the flake later gains checks:
- Build one check derivation:
  - `nix build .#checks.x86_64-linux.<checkName>`

### Build via nixos-rebuild (no activation)

- Build host config without switching generations:
  - `sudo nixos-rebuild build --flake .#<host>`

### System-changing commands (only if requested)

- Switch running system to host config:
  - `sudo nixos-rebuild switch --flake .#<host>`
- Test-run (activates temporarily, not default boot):
  - `sudo nixos-rebuild test --flake .#<host>`

## Formatting / linting

- Format all Nix files (repo convention):
  - `alejandra .`
- Review formatting changes:
  - `git diff -- '*.nix'`

Notes:
- `nix fmt` exists, but this flake does not define a `formatter` output.
- There is no repo-configured `treefmt`, `pre-commit`, `statix`, or `deadnix` workflow.

## Helper scripts (have side effects)

- `./rebuild-nix-system.sh`
  - Requires `.env` with `NIXOS_HOST=<host>`.
  - Runs `alejandra .`.
  - Runs `sudo nixos-rebuild switch ...`.
  - Writes logs to `logs/`.
  - **Auto-commits** via `git commit -am ...`.
  - Ask before running.

- `./update-nix-system.sh`
  - Runs `sudo nix flake update`.
  - Sources `rebuild-nix-system.sh`, so it also switches + auto-commits.
  - Ask before running.

## Cursor / Copilot rules

- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md` were found.
- Cursor is configured via Nix (`modules/hm/code-cursor.nix`).

## Code style guidelines (Nix)

### Formatting

- Run `alejandra` and let it decide layout (avoid manual alignment).
- Prefer 2-space indentation (alejandra’s default).

### Imports and module structure

- Keep `imports = [ ... ];` near the top.
- Use stable import ordering:
  - Host configs: `./hardware-configuration.nix` first, then `../../modules/*`, then host extras.
  - Shared modules: base/common first, then desktop, then programs.
- Keep related configuration grouped; this repo often uses section headers like:
  - `# ================================`

### Module arguments

- Prefer explicit args plus `...` for forward compatibility:
  - `{ pkgs, pkgs-unstable, inputs, lib, ... }:`
- Use `let ... in { ... }` for local helpers/constants (themes, shared values).

### Options and types (when creating new modules)

- If you introduce custom module options, use:
  - `lib.mkOption` with `type = lib.types.*`, `default`, and a short `description`.
- Keep types strict (e.g. `types.bool`, `types.str`, `types.listOf types.package`).
- Prefer `lib.mkIf` / `lib.mkMerge` for conditional composition.

### Attribute conventions

- Use `lib.mkDefault` for host overrides and `lib.mkForce` sparingly.
- Use `with pkgs;` only for package lists (e.g. `environment.systemPackages`).
- Prefer multi-line strings with `''` (avoid excessive escaping).

### Naming

- Hosts are lower-case and match `networking.hostName` (e.g. `wildfire`, `hurricane`).
- File names are kebab-case (`hyprland-desktop.nix`, `code-cursor.nix`).
- Prefer descriptive names (`pkgs-unstable` is fine; avoid new abbreviations).

### Reproducibility

- Prefer pinned sources (`fetchFromGitHub` with `rev` + `hash`).
- Avoid referencing mutable paths or network resources at runtime.
- Don’t update `flake.lock` unless asked.

### Secrets / sensitive data

- Never add secrets to the repo.
- Don’t create or commit `.env`; it’s intentionally gitignored.
- Be cautious when adding SSH configs, tokens, or private URLs.

### Error handling and safety

- When changing firewall, auth (PAM/U2F), disk encryption, or bootloader settings: be conservative and double-check intent.
- Prefer safe validation (`nix flake check --no-build`, `nix build ...toplevel`) before any activation.

## Shell script style (when editing scripts)

- Prefer `set -euo pipefail` for robustness.
- Quote variables and paths.
- Print actionable errors; don’t hide failures.
