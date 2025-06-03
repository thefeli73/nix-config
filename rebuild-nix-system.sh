#!/usr/bin/env bash

# Source .env file
if [ -f ".env" ]; then
    source .env
else
    echo "Error: No .env file found. Copy example.env to .env and set your NIXOS_HOST"
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

# Early return if no changes were detected
if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

# Autoformat your nix files
alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

# Shows your changes
git diff -U0 '*.nix'

echo "NixOS Rebuilding configuration for host: $NIXOS_HOST..."

# First, run a check to see if the flake is valid
nix flake check

# Rebuild the system
sudo nixos-rebuild switch --flake ./#$NIXOS_HOST &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"

# Clean up old generations older than 180 days
sudo nix-collect-garbage --delete-older-than 180d 


