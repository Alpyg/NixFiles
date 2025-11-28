{pkgs, ...}: {
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
    username = "kuyin";
    homeDirectory = "/home/kuyin";
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  programs.gh.enable = true;
  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    xclip
    playerctl
    p7zip
    unzip
    unrar
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.filelight
    brave
    vlc
    mpv
    syncplay
    audacity
    libsForQt5.kdenlive
    prismlauncher
    libsForQt5.xp-pen-deco-01-v2-driver

    vesktop
    (pkgs.discord.override {withVencord = true;})
  ];

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
