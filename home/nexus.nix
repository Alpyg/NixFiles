# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./modules/btop.nix
    ./modules/tmux.nix
    ./modules/nixvim
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "nexus";
    homeDirectory = "/home/nexus";
  };

  # Add stuff for your user as you see fit:
  # home.packages = with pkgs; [ steam ];

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
    enableFishIntegration = true;
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
