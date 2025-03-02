{ lib, config, ... }: {

  options.dunst.enable = lib.mkEnableOption "Enable dunst";

  config = lib.mkIf config.dunst.enable { services.dunst.enable = true; };
}
