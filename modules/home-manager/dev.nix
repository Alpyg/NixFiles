{ pkgs, lib, config, ... }: {

  options.dev.enable = lib.mkEnableOption "Enable dev";

  config = lib.mkIf config.dev.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = "Alpyg";
      userEmail = "alpyg@pm.me";
    };
    programs.gh.enable = true;
    programs.lazygit.enable = true;
    programs.direnv = {
      enable = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    programs.tmux.enable = true;
    programs.tmux.mouse = true;
    programs.tmux.baseIndex = 1;

    nixvim.enable = true;

    home.packages = with pkgs; [
      lazydocker
      nodejs
      bun
      python313
      gcc
      qemu
      gnumake
      dbeaver-bin
      rustup
      go
      zigpkgs.mach
      just
      tmuxinator
      vrc-get
      libnotify
      nixfmt-classic
      godot_4
    ];
  };
}
