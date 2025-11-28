{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops

    ./hardware.nix
  ];

  adguard.enable = true;
  crafty.enable = true;
  hostify.enable = true;
  nextcloud.enable = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["nexus"];
  };
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  sops.defaultSopsFile = ../../secrets.yml;
  sops.defaultSopsFormat = "yaml";

  sops.age.generateKey = true;
  sops.age.keyFile = "/home/nexus/.config/sops/age/keys.txt";

  networking = {
    hostName = "nexus";
    networkmanager.enable = true;
  };

  services.openssh.enable = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = ["ebe7fbd445ae1d09"];
    localConf = {};
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    extraOptions = "--insecure-registry 10.147.20.18:10000";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  users.users.nexus = {
    isNormalUser = true;
    description = "Nexus";
    extraGroups = ["networkmanager" "wheel" "storage" "docker"];
  };
  users.defaultUserShell = pkgs.fish;

  programs.fish.enable = true;

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        security = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "10.147.20.0/24 192.168.2.0/24 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nexus";
        "map to guest" = "bad user";
      };
      "crafty" = {
        path = "/home/nexus/crafty";
        browsable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    fishPlugins.done
    nix-index
    stow
    killall
  ];
  environment.shells = with pkgs; [fish];
  fonts.packages = with pkgs; [nerd-fonts.noto];

  system.stateVersion = "25.11";
}
