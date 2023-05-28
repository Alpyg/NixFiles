#!/usr/bin/sh

pushd ~/.dotfiles

install_dotfiles() {
  for folder in $(ls -d .*/ */ 2>/dev/null | grep -Ev "^\.{1,2}/?|\.git/?'");do
    echo "Stowing $folder"
    stow -R $folder
  done
}

clear_dotfiles() {
  for folder in $(ls -d .*/ */ 2>/dev/null | grep -Ev "^\.{1,2}/?|\.git/?'");do
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

