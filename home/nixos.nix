{ inputs, pkgs, ... }: {
  bspwm = {
    enable = true;
    startupPrograms = [
      "kill polybar"
      "MONITOR=DP-1 polybar bar"
      "picom -b --config ~/.config/picom/picom.conf"
      "kdeconnect-cli"
      "flameshot"
      "discord"
      "steam"
    ];
  };
  catppuccin2.enable = true;
  dev.enable = true;
  dunst.enable = true;
  mangohud.enable = true;
  nixvim.enable = true;
  polybar.enable = true;
  sxhkd.enable = true;

  imports = [ inputs.zen-browser.homeModules.beta ];

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
    vlc
    mpv
    syncplay
    calibre
    # unityhub
    vrc-get
    goverlay
    prismlauncher
    osu-lazer
    obsidian
    prusa-slicer
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
    limo
    vesktop
    (discord.override { withVencord = true; })
    v4l-utils

    stremio
    kicad
    blender
    freecad
    sops
    anki
    # gimp
    nexusmods-app
    r2modman
    blockbench
  ];

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
