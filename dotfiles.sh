#!/bin/sh

pushd ~/.dotfiles

folders=("vencord")

install_dotfiles() {
	for folder in "${folders[@]}"; do
		echo "Stowing $folder"
		stow -R $folder
	done
}

clear_dotfiles() {
	for folder in "${folders[@]}"; do
		echo "Unstowing $folder"
		stow -D $folder
	done
}

case "$1" in
"i")
	install_dotfiles
	;;
"c")
	clear_dotfiles
	;;
*)
	echo "Invalid argument. Usage: $0 {i|c}"
	exit 1
	;;
esac

popd
