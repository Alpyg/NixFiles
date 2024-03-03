# NixFiles

To update system
```shell
nixos-rebuild switch --flake .#<host>
```

To update user
```
home-manager switch --impure --flake .#<user>@<host>
```
