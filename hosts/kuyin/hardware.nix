{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/34ffc5c2-cf8d-4c2b-b05b-a1ae9d6e16eb";
    fsType = "ext4";
    noCheck = true;
    options = [ "nofail" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E520-BC2F";
    fsType = "vfat";
    noCheck = true;
    options = [ "nofail" ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
