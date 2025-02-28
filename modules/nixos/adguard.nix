{ lib, config, ... }: {
  options.adguard.enable = lib.mkEnableOption "Enable AdGuard";

  config =
    lib.mkIf config.adguard.enable { services.adguardhome.enable = true; };
}
