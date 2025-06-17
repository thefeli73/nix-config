#!/usr/bin/env bash

set -e

# Check for force flag
FORCE_REBUILD=false
if [[ "$1" == "-f" || "$1" == "--force" ]]; then
    FORCE_REBUILD=true
fi

# Source .env file
if [ -f ".env" ]; then
    source .env
else
    echo "Error: No .env file found. Copy .env.example to .env and set your NIXOS_HOST"
    exit 1
fi

if [ -z "$NIXOS_HOST" ]; then
    echo "Error: NIXOS_HOST not set in .env file"
    exit 1
fi

# Validate that the host configuration exists
AVAILABLE_HOSTS=$(nix flake show --json 2>/dev/null | jq -r '.nixosConfigurations | keys[]' 2>/dev/null)
if [ $? -ne 0 ] || [ -z "$AVAILABLE_HOSTS" ]; then
    echo "Warning: Could not validate host configuration. Proceeding anyway..."
else
    if ! echo "$AVAILABLE_HOSTS" | grep -q "^$NIXOS_HOST$"; then
        echo "Error: Host '$NIXOS_HOST' not found in flake.nix"
        echo "Available hosts: $(echo $AVAILABLE_HOSTS | tr '\n' ' ')"
        exit 1
    fi
fi

# Early return if no changes were detected (unless forced)
if [ "$FORCE_REBUILD" = false ] && git diff --quiet '*.nix' && git diff --quiet 'flake.lock'; then
    echo "No changes detected, exiting."
    exit 0
fi

# Autoformat your nix files
alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

# Shows your changes
git diff -U0 '*.nix'

echo "NixOS Rebuilding configuration for host: $NIXOS_HOST..."

# First, run a check to see if the flake is valid
nix flake check 2>&1 | grep -i --color error && exit 1

# Rebuild the system
mkdir -p logs
sudo nixos-rebuild switch --flake ./#$NIXOS_HOST &>logs/nixos-switch.log || (cat logs/nixos-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"

# Clean up old generations older than 180 days
sudo nix-collect-garbage --delete-older-than 180d &>logs/nixos-gc.log || (cat logs/nixos-gc.log | grep --color error && exit 1)


