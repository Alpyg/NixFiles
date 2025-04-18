{ pkgs, lib, config, ... }: {
  options.catppuccin2.enable = lib.mkEnableOption "Enable catppuccin";

  config = lib.mkIf config.catppuccin2.enable {
    catppuccin = {
      enable = true;
      accent = "blue";
      flavor = "mocha";

      cursors = {
        enable = true;
        accent = "blue";
        flavor = "mocha";
      };
    };

    home.packages = with pkgs; [ catppuccin-kvantum ];

    # gtk = {
    #   enable = true;
    #   theme = {
    #     name = "Catppuccin-Mocha-Mauve";
    #     package = pkgs.catppuccin-gtk;
    #   };
    #   cursorTheme = {
    #     name = "Catppuccin-Mocha-Blue-Cursors";
    #     package = pkgs.catppuccin-cursors.mochaBlue;
    #   };
    #   gtk3 = { extraConfig.gtk-application-prefer-dark-theme = true; };
    # };

    # dconf.settings = {
    #   "org/gnome/desktop/interface" = {
    #     gtk-theme = "Catppuccin-Mocha-Mauve";
    #     color-scheme = "prefer-dark";
    #   };
    # };

    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style.name = "kvantum";
    };

    xdg.configFile."Kvantum/kvantum.kvconfig".source =
      (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
        General.theme = "catppuccin-mocha-blue";
      };
  };
}
