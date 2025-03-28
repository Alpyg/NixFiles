{ pkgs, lib, config, ... }: {
  options.crafty.enable = lib.mkEnableOption "Enable Crafty";

  config = lib.mkIf config.crafty.enable {
    virtualisation.oci-containers = {
      backend = "docker";
      containers.crafty = {
        image = "registry.gitlab.com/crafty-controller/crafty-4:latest";
        autoStart = true;
        environment = { TZ = "Etc/UTC"; };
        ports = [ "8443:8443" "25500-25600:25500-25600" ];
        volumes = [
          "/home/nexus/crafty/backups:/crafty/backups"
          "/home/nexus/crafty/logs:/crafty/logs"
          "/home/nexus/crafty/servers:/crafty/servers"
          "/home/nexus/crafty/config:/crafty/app/config"
          "/home/nexus/crafty/import:/crafty/import"
        ];
      };
    };
  };
}
