{ pkgs, ... }: {
  catppuccin2.enable = true;

  nixpkgs = {
    overlays = [
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "nexus";
    homeDirectory = "/home/nexus";
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Alpyg";
    userEmail = "alpyg@pm.me";
  };
  programs.gh.enable = true;
  programs.lazygit.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    sops
    zoxide
    nixfmt-classic
    tmuxinator
    xclip
    playerctl
    p7zip
    unzip
    unrar

    lazydocker
    nodejs
    bun
    python312
  ];

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
