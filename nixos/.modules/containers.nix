{ ... }:

{

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    jellyfin = {
      image = "jellyfin/jellyfin";
      hostname = "bebiflix-jellyfin";
      volumes = [
        "/home/nexus/.jellyfin/config:/config"
        "/home/nexus/.jellyfin/cache:/cache"
        "/home/nexus/.jellyfin/media:/media"
      ];
      ports = [ "8096:8096" ];
      autoStart = true;
    };
    sonarr = {
      image = "lscr.io/linuxserver/sonarr:latest";
      hostname = "bebiflix-sonarr";
      volumes = [ "/home/nexus/.sonarr/config:/config" ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "Etc/UTC";
      };
      ports = [ "8989:8989" ];
      dependsOn = [ "jellyfin" ];
      autoStart = true;
    };
  };
}
