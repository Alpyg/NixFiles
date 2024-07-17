{ ... }:

{
  containers.bebiflix = {
    autoStart = true;
    forwardPorts = [
      {
        containerPort = 8096;
        hostPort = 8096;
        protocol = "tcp";
      }
      {
        containerPort = 8989;
        hostPort = 8989;
        protocol = "tcp";
      }
      {
        containerPort = 9091;
        hostPort = 9091;
        protocol = "tcp";
      }
      {
        containerPort = 51413;
        hostPort = 51413;
        protocol = "tcp";
      }
      {
        containerPort = 51413;
        hostPort = 51413;
        protocol = "udp";
      }
    ];
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
