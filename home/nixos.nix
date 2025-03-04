{ pkgs, ... }: {
  dev.enable = true;
  nixvim.enable = true;
  polybar.enable = true;
  bspwm = {
    enable = true;
    startupPrograms = [
      "kill polybar"
      "MONITOR=DP-3 polybar bar"
      "picom -b --config ~/.config/picom/picom.conf"
      "kdeconnect-cli"
      "flameshot"
      "discord"
      "steam"
    ];
  };
  sxhkd.enable = true;
  dunst.enable = true;
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
    username = "alpyg";
    homeDirectory = "/home/alpyg";
  };

  programs.home-manager.enable = true;

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
    prusa-slicer
    gnome-common
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
    winetricks
    vesktop
    (discord.override { withVencord = true; })

    stremio
    (zigpkgs.mach)
    # kicad
    sops
    anki
    gimp
    nexusmods-app
    r2modman
    blockbench
    ida-free
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
