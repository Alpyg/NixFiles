{ pkgs, config, ... }: {
  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = [ "eno1" ];
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ 80 443 ];
    };
  };

  sops.secrets."cloudflared/nexus-tunnel/creds" = { owner = "cloudflared"; };
  services.cloudflared = {
    enable = true;
    tunnels."nexus" = {
      credentialsFile =
        config.sops.secrets."cloudflared/nexus-tunnel/creds".path;
      ingress = {
        "alpyg.dev" = { service = "http://localhost:80"; };
        "vaultwarden.alpyg.dev" = { service = "http://localhost:8222"; };
        "analytics.alpyg.dev" = { service = "http://localhost:10000"; };
        "gitea.alpyg.dev" = { service = "http://localhost:10001"; };
      };
      default = "http_status:404";
    };
  };

  services.vaultwarden.enable = true;

  sops.secrets."plausible/key" = { };
  services.plausible = {
    enable = true;
    server = {
      baseUrl = "https://analytics.alpyg.dev";
      port = 10000;
      secretKeybaseFile = config.sops.secrets."plausible/key".path;
      #disableRegistration = false; # disabled after first account creation cuz adminUser didnt work
    };
  };

  services.gitea = {
    enable = true;
    appName = "Gitea";
    database.type = "sqlite3";

    settings.server = {
      HTTP_PORT = 10001;
      DOMAIN = "gitea.alpyg.dev";
    };
  };

  sops.secrets."gitea/runner-token" = { };
  services.gitea-actions-runner = {
    instances.native = {
      enable = true;
      name = "Native";
      url = "http://localhost:10001";
      token = "T5a4DqZdNLpcvcy8V7fl2bZl0GKBXT20IHm35sWK";
      labels = [
        "native:host"
        # "docker:docker://docker:latest"
        # "rust:docker://rust:alpine"
        # "golang:docker://go:alpine"
        # "node:docker://node:current-alpine"
      ];
    };
  };
}
