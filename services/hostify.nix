{config, ...}: {
  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = ["eno1"];
      allowedTCPPorts = [80 443];
      allowedUDPPorts = [80 443];
    };
  };

  sops.secrets."cloudflared/nexus-tunnel/creds" = {owner = "cloudflared";};
  services.cloudflared = {
    enable = true;
    tunnels."nexus" = {
      credentialsFile = "${config.sops.secrets."cloudflared/nexus-tunnel/creds".path}";
      ingress = {
        "alpyg.dev" = {service = "http://localhost:80";};
        "vaultwarden.alpyg.dev" = {service = "http://localhost:8222";};
        "analytics.alpyg.dev" = {service = "http://localhost:10000";};
      };
      default = "http_status:404";
    };
  };

  services.vaultwarden.enable = true;

  sops.secrets."plausible/key" = {};
  sops.secrets."plausible/admin-password" = {};
  services.plausible = {
    enable = true;
    server = {
      baseUrl = "https://analytics.alpyg.dev";
      port = 10000;
      secretKeybaseFile = "${config.sops.secrets."plausible/key".path}";
      #disableRegistration = false; # disabled after first account creation cuz adminUser didnt work
    };

    adminUser = {
      name = "Admin";
      email = "admin@localhost";
      activate = true;
      passwordFile = "${config.sops.secrets."plausible/admin-password".path}";
    };
  };
}
