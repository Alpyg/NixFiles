# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ./modules/catppuccin.nix
    ./modules/bspwm.nix
    ./modules/sxhkd.nix
    ./modules/polybar.nix
    ./modules/dunst.nix
    ./modules/btop.nix
    ./modules/kitty.nix
    ./modules/tmux.nix
    # ./modules/vscode.nix
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
    username = "alpyg";
    homeDirectory = "/home/alpyg";
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
    # enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  programs.mangohud.enable = true;
  programs.obs-studio.enable = true;

  programs.fish.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    zoxide
    nixfmt-classic
    tmuxinator
    libnotify
    xclip
    flameshot
    playerctl
    catppuccin-fcitx5
    p7zip
    unzip
    unrar
    thunderbird
    brave
    firefox-devedition
    vlc
    mpv
    syncplay
    calibre
    unityhub
    vrc-get
    goverlay
    prismlauncher
    osu-lazer
    obsidian
    wineWowPackages.unstable
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.qtstyleplugin-kvantum
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ffmpegthumbs
    kdePackages.qtimageformats
    kdePackages.qtsvg
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.filelight
    kdePackages.ktorrent
    kdePackages.kservice
    kdePackages.polkit-kde-agent-1
    (lutris.override {
      extraLibraries = pkgs: [ wineWowPackages.waylandFull libGL ];
    })
    protontricks
    modrinth-app
    winetricks
    vesktop
    (discord.override { withVencord = true; })

    godot_4
    lazydocker
    nodejs
    bun
    python312
    gcc
    qemu
    gnumake
    dbeaver-bin
    # blender
    rustup
    go
    just
    prusa-slicer
    libreoffice-qt

    stremio
    (zigpkgs.master)
    kicad
    sops
    anki
    gimp
    nexusmods-app
    r2modman
    blockbench
    ida-free
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
