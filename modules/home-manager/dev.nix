{ pkgs, lib, config, ... }: {
  options.dev.enable = lib.mkEnableOption "Enable dev";

  config = lib.mkIf config.dev.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      userName = "Alpyg";
      userEmail = "alpyg@pm.me";
      extraConfig.init.defaultBranch = "main";
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
      dotnet-sdk
      zigpkgs.mach
      just
      tmuxinator
      vrc-get
      libnotify
      nixfmt-classic
      godot_4
      android-studio
      google-chrome
    ];
  };
}
