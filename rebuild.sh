#!/usr/bin/env bash

set -e

echo "Rebuilding NixOS"

sudo nixos-rebuild switch --flake .#$(hostname) &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)
home-manager switch --impure --flake .#$(whoami)@$(hostname) &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

notify-send -e "NixOS Rebuilt!" --icon=software-update-available
