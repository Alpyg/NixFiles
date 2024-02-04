# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
    ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos";

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "ebe7fbd445ae1d09" ];
  };

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_CA.UTF-8";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiIntel vaapiVdpau libvdpau-va-gl ];
  };
  hardware.bluetooth.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.alpyg = {
    isNormalUser = true;
    description = "Kuyin";
    extraGroups = [ "networkmanager" "wheel" "storage" ];
  };
  users.defaultUserShell = pkgs.fish;

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kuyin";
  services.xserver.windowManager.bspwm.enable = true;
  services.picom.enable = true;
  services.devmon.enable = true;
  security.polkit.enable = true;

  programs.fish.enable = true;
  programs.partition-manager.enable = true;

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    fishPlugins.done
    kitty
    nix-index
    neovim
    libsForQt5.qt5ct
    libsForQt5.polkit-kde-agent
    libsForQt5.breeze-icons
    libsForQt5.breeze-qt5
    libsForQt5.breeze-gtk
    libsForQt5.ark
    libsForQt5.gwenview
    libsForQt5.ktorrent
    gtk3
    dmenu
    killall
    wineWowPackages.stable
  ];
  environment.shells = with pkgs; [ fish ];
  environment.sessionVariables = rec {
    XDG_CACHE_HOME   = "$HOME/.cache";
    XDG_CONFIG_HOME  = "$HOME/.config";
    XDG_DATA_HOME    = "$HOME/.local/share";
    XDG_STATE_HOME   = "$HOME/.local/state";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  
  system.stateVersion = "23.11";
}
