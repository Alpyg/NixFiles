{ ... }: {
  programs.fish = {
    enable = true;
    shellAliases = { l = "ls -alh"; };
  };
}
