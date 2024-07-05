{ config, pkgs, ... }: {
  services.pipewire.extraConfig.pipewire."roc-sink" = {
    "context.modules" = [{
      name = "libpipewire-module-roc-source";
      args = {
        fec.code = "disable";
        remote.ip = "192.168.2.99";
        remote.source.port = 10001;
        remote.repair.port = 10002;
        remote.control.port = 10003;
        sink.name = "ROC Sink";
        sink.props = { node.name = "roc-sink"; };
      };
    }];
  };
  systemd.user.services."pipewire-roc-sink" = {
    description = "Pipewire roc sink";
    wantedBy = [ "pipewire.service" ];
    script = "${pkgs.pipewire}/bin/pipewire -c roc-sink.conf";
    enable = true;
    path = with pkgs; [ pipewire ];
  };
}
