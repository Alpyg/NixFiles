#!/usr/bin/env bash

set -e

echo "Rebuilding NixOS"

nix flake update
sudo nixos-rebuild switch --flake .#$(hostname)
home-manager switch --impure --flake .#$(whoami)@$(hostname)

notify-send -e "NixOS Rebuilt!" --icon=software-update-available
