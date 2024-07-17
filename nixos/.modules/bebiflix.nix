{ ... }:

{
  containers.bebiflix = {
    autoStart = true;
    config = { ... }: {
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
        settings.download-dir = "/home/nexus/Downloads";
      };

      system.stateVersion = "24.05";
    };
  };
}
