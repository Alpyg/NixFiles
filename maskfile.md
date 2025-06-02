## update
> Update lock file
~~~sh
nix flake update
~~~

## cg
> Collect Garbage
~~~sh
sudo nix-collect-garbage -d
nix-collect-garbage -d
~~~

## test
> Runs `nixos-rebuild test` for .#nixos
~~~sh
nixos-rebuild test   --target-host root@10.147.20.18  --flake .#nixos
~~~

## switch (host)
> Runs `nixos-rebuild switch` for the specified host
~~~sh
case $host in
  nixos) ip="10.147.20.18" ;;
  nexus) ip="10.147.20.99" ;;
  t470)  ip="10.147.20.101" ;;
  kuyin) ip="10.147.20.158" ;;
  *)
    echo "Error: Unknown host $host" >&2
    exit 1
    ;;
esac

nixos-rebuild switch --target-host root@$ip --flake .#$host
~~~
