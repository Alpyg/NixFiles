# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ../.modules/bspwm.nix
    ../.modules/sxhkd.nix
    ../.modules/polybar.nix
    ../.modules/dunst.nix
    ../.modules/btop.nix
    ../.modules/kitty.nix
    ../.modules/tmux.nix
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
    username = "alpyg";
    homeDirectory = "/home/alpyg";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
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

  programs.mangohud.enable = true;
  programs.obs-studio.enable = true;

  services.kdeconnect.enable = true;
  services.flameshot.enable = true;

  home.packages = with pkgs; [
    tmuxinator
    libnotify
    xclip
    playerctl
    p7zip
    unzip
    unrar
    kate
    dolphin
    filelight
    thunderbird
    brave
    firefox-devedition
    vlc
    mpv
    syncplay
    unityhub
    vrc-get
    goverlay
    prismlauncher
    osu-lazer
    obsidian
    (pkgs.discord.override { withVencord = true; })

    lazydocker
    nodejs
    bun
    python311
    gcc
    qemu
    gnumake
    dbeaver
    blender
    cargo
    zig
    rustc
    prusa-slicer
    kicad
    libreoffice-qt
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
