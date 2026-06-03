# AGENTS.md

## Hard constraints

- High-impact actions require explicit user request: any `sudo` command, `nixos-rebuild switch`, `nixos-rebuild test`, or `nix flake update`.
- Do not run `./rebuild-nix-system.sh` or `./update-nix-system.sh` unless explicitly requested; they can switch the live system and create commits.
- Do not create commits or push unless explicitly requested.
- Do not update `flake.lock` unless explicitly requested.

## Verification commands

- After changing `.nix` files, run `alejandra .`.
- For non-doc changes, always run `nix flake check --no-build`.

## Clarification path

- If the task is ambiguous and could trigger a high-impact action, ask one targeted question with the safe default: evaluate/build only, no activation, no lockfile update, no commit.
