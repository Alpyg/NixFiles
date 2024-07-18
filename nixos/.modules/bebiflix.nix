{ ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "nexus";
    dataDir = "/home/nexus/.jellyfin";
  };
  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "nexus";
    dataDir = "/home/nexus/.sonarr";
  };
  services.transmission = {
    enable = true;
    openRPCPort = true;
    user = "nexus";
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist-enabled = false;
    };
  };
}
