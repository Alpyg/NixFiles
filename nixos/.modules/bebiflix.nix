{ ... }:

{
  containers.bebiflix = {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = "nexus";
    };
    services.sonarr = {
      enable = true;
      openFirewall = true;
    };
    services.transmission = {
      enable = true;
      openRPCPort = true;
    };
  };
}
