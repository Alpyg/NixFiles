#!/usr/bin/env bash

set -e

echo "Rebuilding NixOS"

UPDATE_FLAKE=false
for arg in "$@"; do
	if [ "$arg" == "-u" ]; then
		UPDATE_FLAKE=true
	fi
done

if [ "$UPDATE_FLAKE" = true ]; then
	echo "Updating packages"
	sudo nix flake update
fi

sudo nixos-rebuild switch --flake .#$(hostname)
home-manager switch --impure --flake .#$(whoami)@$(hostname)

notify-send -e "NixOS Rebuilt!" --icon=software-update-available
