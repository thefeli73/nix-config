#!/bin/bash

# Rebuild the system
sudo nixos-rebuild switch --flake ./#default

# Clean up old generations older than 90 days
sudo nix-collect-garbage --delete-older-than 90d 


