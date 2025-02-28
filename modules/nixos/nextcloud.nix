{ pkgs, lib, config, ... }: {
  options.nextcloud.enable = lib.mkEnableOption "Enable Nextcloud";

  config = lib.mkIf config.nextcloud.enable {
    sops.secrets."nextcloud/admin-password" = { owner = "nextcloud"; };
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud30;
      hostName = "nextcloud";

      database.createLocally = true;

      config = {
        dbtype = "sqlite";
        adminpassFile = config.sops.secrets."nextcloud/admin-password".path;
      };

      appstoreEnable = true;
      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps) richdocuments;
      };

      settings = { trusted_domains = [ "192.168.2.*" "10.147.20.*" ]; };
    };

    virtualisation.oci-containers = {
      backend = "docker";
      containers.collabora = {
        image = "docker.io/collabora/code";
        ports = [ "9980:9980" ];
        autoStart = true;
        environment = {
          aliasgroup1 = "192.168.2.227,10.147.20.99";
          extra_params = "--o:ssl.enable=false";
        };
      };
    };
  };
}
