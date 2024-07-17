{ ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "nexus";
    dataDir = "/home/nexus/jellyfin";
  };
  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "nexus";
    dataDir = "/home/nexus/jellyfin";
  };
  services.transmission = {
    enable = true;
    openRPCPort = true;
  };
}
