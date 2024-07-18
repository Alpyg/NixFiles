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
    openFirewall = true;
  };
}
