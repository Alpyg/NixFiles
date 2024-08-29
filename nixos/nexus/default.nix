# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops

    # Include the results of the hardware scan.
    ./hardware.nix
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "nexus" ];
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
    joinNetworks = [ "ebe7fbd445ae1d09" ];
    localConf = { };
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker = { enable = true; };

  hardware.pulseaudio.enable = false;
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
    extraGroups = [ "networkmanager" "wheel" "storage" "docker" ];
  };
  users.defaultUserShell = pkgs.fish;

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    fishPlugins.done
    nix-index
    stow
    killall
  ];
  environment.shells = with pkgs; [ fish ];
  fonts.packages = with pkgs; [ nerdfonts ];

  system.stateVersion = "24.05";
}
