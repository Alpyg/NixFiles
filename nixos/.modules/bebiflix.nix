{ ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "nexus";
  };
  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "nexus";
  };
  services.transmission = {
    enable = true;
    openFirewall = true;
    user = "nexus";
  };
}
