{ pkgs, ... }: {
  dev.enable = true;
  polybar.enable = true;
  bspwm = {
    enable = true;
    startupPrograms = [
      "kill polybar"
      "MONITOR=eDP-1 polybar bar"
      "picom -b --config ~/.config/picom/picom.conf"
      "kdeconnect-cli"
      "flameshot"
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

  programs.fish.enable = true;
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  services.kdeconnect.enable = true;

  home.packages = with pkgs; [
    zoxide
    tmuxinator
    xclip
    flameshot
    playerctl
    p7zip
    unzip
    unrar
    thunderbird
    brave
    vlc
    stremio
    mpv
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
    (pkgs.discord.override { withVencord = true; })
  ];
  programs.java.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
