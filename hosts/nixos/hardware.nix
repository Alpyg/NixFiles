{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/577323f9-209b-4c10-a447-aea9af34a6cf";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/577323f9-209b-4c10-a447-aea9af34a6cf";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/577323f9-209b-4c10-a447-aea9af34a6cf";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/var" = {
      device = "/dev/disk/by-uuid/577323f9-209b-4c10-a447-aea9af34a6cf";
      fsType = "btrfs";
      options = [ "subvol=var" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/0C00-9FD9";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    "/mnt/x" = {
      device = "/dev/disk/by-uuid/d7a408d4-44e1-4717-9385-494f15784a58";
      fsType = "ext4";
    };

    "/mnt/y" = {
      device = "/dev/disk/by-uuid/bf9b64e3-b69d-4f00-8201-1b7237934366";
      fsType = "ext4";
    };
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
