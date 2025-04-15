update:
  nix flake update
cg:
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
test:
  nixos-rebuild test   --target-host root@10.147.20.18  --flake .#nixos
nixos:
  nixos-rebuild switch --target-host root@10.147.20.18  --flake .#nixos
nexus:
  nixos-rebuild switch --target-host root@10.147.20.99  --flake .#nexus
t470:
  nixos-rebuild switch --target-host root@10.147.20.101 --flake .#t470
kuyin:
  nixos-rebuild switch --target-host root@10.147.20.158 --flake .#kuyin
