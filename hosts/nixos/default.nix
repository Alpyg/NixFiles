{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops

    # Include the results of the hardware scan.
    ./hardware.nix
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "alpyg" ];
  };
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  sops.defaultSopsFile = ../../secrets.yml;
  sops.defaultSopsFormat = "yaml";

  sops.age.generateKey = true;
  sops.age.keyFile = "/home/alpyg/.config/sops/age/keys.txt";

  networking = {
    hostName = "nixos";
    useDHCP = true;
    firewall = {
      enable = true;
      trustedInterfaces = [ "eno1" "zth6rflskm" ];
      allowedTCPPorts = [ 9000 9001 9942 9943 9944 11470 25565 ];
      allowedUDPPorts = [ 9000 9001 9942 9943 9944 11470 ];
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
      allowedUDPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
    };
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "ebe7fbd445ae1d09" ];
    localConf = { };
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiVdpau libvdpau-va-gl ];
  };
  hardware.bluetooth.enable = true;
  hardware.opentabletdriver.enable = true;
  boot.kernelModules = [ "nouveau" ];
  boot.blacklistedKernelModules =
    [ "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.virtualbox = { host.enable = true; };
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  users.users.alpyg = {
    isNormalUser = true;
    description = "Alpyg";
    extraGroups = [ "networkmanager" "wheel" "storage" "docker" ];
  };
  users.defaultUserShell = pkgs.fish;

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "alpyg";
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
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  catppuccin.enable = true;
  console.catppuccin.enable = true;
  environment.systemPackages = with pkgs; [
    fishPlugins.done
    kitty
    nix-index
    neovim
    stow
    gtk3
    dmenu
    killall
    vulkan-loader
    qpwgraph
    deploy-rs
  ];
  environment.shells = with pkgs; [ fish ];
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glib
    libgcc
    libz
    libGL
    xorg.libX11
    xorg.libxcb
  ];

  fonts.packages = with pkgs; [ nerd-fonts.noto ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  system.stateVersion = "24.05";
}
