{
  lib,
  config,
  ...
}: {
  options.hostify.enable = lib.mkEnableOption "Enable Hostify";

  config = lib.mkIf config.hostify.enable {
    networking = {
      firewall = {
        enable = true;
        trustedInterfaces = ["eno1"];
        allowedTCPPorts = [80 443];
        allowedUDPPorts = [80 443];
      };
    };

    sops.secrets."cloudflared/tunnel" = {owner = "nexus";};
    services.cloudflared = {
      enable = true;
      tunnels."nexus" = {
        credentialsFile = config.sops.secrets."cloudflared/tunnel".path;
        ingress = {
          "vaultwarden.alpyg.dev" = {service = "http://localhost:8222";};
          "analytics.alpyg.dev" = {service = "http://localhost:10000";};
          "crafty.alpyg.dev" = {service = "https://localhost:8443";};
          "avorust.alpyg.dev" = {service = "http://localhost:27000";};
        };
        originRequest.noTLSVerify = true;
        default = "http_status:404";
      };
    };

    services.vaultwarden.enable = true;

    # sops.secrets."plausible/key" = { };
    # services.plausible = {
    #   enable = true;
    #   server = {
    #     baseUrl = "https://analytics.alpyg.dev";
    #     port = 10000;
    #     secretKeybaseFile = config.sops.secrets."plausible/key".path;
    #     # disableRegistration = false; # disabled after first account creation cuz adminUser didnt work
    #   };
    # };
  };
}
