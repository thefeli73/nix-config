#!/usr/bin/env bash

# Update the system
sudo nix flake update 

# Rebuild the system
. rebuild-nix-system.sh
