{ ... }:

{
  containers.bebiflix = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.2.99";
    localAddress = "192.168.10.10";
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
