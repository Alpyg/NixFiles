{ ... }: {
  programs.btop.enable = true;
  programs.btop.settings = {
    update_ms = 100;
    use_fstab = false;
    disks_filter = "/ /mnt/x /mnt/y";
  };
}
