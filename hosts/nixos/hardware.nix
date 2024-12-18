{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4de1a9c0-f3f4-4241-ac17-660b3ae851bd";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3A26-0A4F";
    fsType = "vfat";
  };

  fileSystems."/mnt/x" = {
    device = "/dev/disk/by-uuid/d7a408d4-44e1-4717-9385-494f15784a58";
    fsType = "ext4";
  };

  fileSystems."/mnt/y" = {
    device = "/dev/disk/by-uuid/bf9b64e3-b69d-4f00-8201-1b7237934366";
    fsType = "ext4";
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
