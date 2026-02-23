# AGENTS.md

## Hard constraints

- High-impact actions require explicit user request: any `sudo` command, `nixos-rebuild switch`, `nixos-rebuild test`, or `nix flake update`.
- Do not run `./rebuild-nix-system.sh` or `./update-nix-system.sh` unless explicitly requested; they can switch the live system and create commits.
- Do not create commits or push unless explicitly requested.
- Do not update `flake.lock` unless explicitly requested.
- Never commit secrets (`.env`, tokens, private keys).

## Verification commands

- After changing `.nix` files, run `alejandra .`.
- For non-doc changes, run `nix flake check --no-build`.
- Optional host build (only when requested): `nix build .#nixosConfigurations.<host>.config.system.build.toplevel`.

## Known failure patterns

- **When:** asked to use `rebuild-nix-system.sh` or `update-nix-system.sh`.
  **Do:** state side effects first (live switch and/or auto-commit) and only run when explicitly requested.
  **Verify:** command output confirms only the explicitly requested side effect occurred.
  **Scope:** root helper scripts.

- **When:** shared Nix files change and no host build was requested.
  **Do:** use `nix flake check --no-build` as the default completion gate.
  **Verify:** exit code 0 from `nix flake check --no-build`.
  **Scope:** `flake.nix`, `modules/**`, and cross-host changes.

## Legacy boundaries

- Keep both host outputs (`wildfire`, `hurricane`) intact unless the user explicitly asks to remove or rename one.

## Clarification path

- If the task is ambiguous and could trigger a high-impact action, ask one targeted question with the safe default: evaluate/build only, no activation, no lockfile update, no commit.
