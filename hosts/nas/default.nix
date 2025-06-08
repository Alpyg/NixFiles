{ pkgs, inputs, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops

    ./hardware.nix
  ];

  adguard.enable = true;
  nextcloud.enable = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "nas" ];
  };
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  sops.defaultSopsFile = ../../secrets.yml;
  sops.defaultSopsFormat = "yaml";

  sops.age.generateKey = true;
  sops.age.keyFile = "/home/nas/.config/sops/age/keys.txt";

  networking = {
    hostName = "nas";
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
  };

  users.users.nas = {
    isNormalUser = true;
    description = "NAS";
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
  fonts.packages = with pkgs; [ nerd-fonts.noto ];

  system.stateVersion = "24.05";
}
