{ pkgs, lib, config, ... }: {
  options.nextcloud.enable = lib.mkEnableOption "Enable Nextcloud";

  config = lib.mkIf config.nextcloud.enable {
    networking = {
      firewall = {
        enable = true;
        trustedInterfaces = [ "enp0s31f6" ];
        allowedTCPPorts = [ 80 443 ];
        allowedUDPPorts = [ 80 443 ];
      };
    };

    sops.secrets."nextcloud/admin-password" = { owner = "nextcloud"; };
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
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
          aliasgroup1 = "192.168.2.112,10.147.20.100";
          extra_params = "--o:ssl.enable=false";
        };
      };
    };
  };
}
