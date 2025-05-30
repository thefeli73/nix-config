#!/bin/bash
sudo nix flake update /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos/#default
