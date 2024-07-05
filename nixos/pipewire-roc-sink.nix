{ config, pkgs, ... }: {
  services.pipewire.extraConfig.pipewire."roc-sink" = {
    "context.modules" = [{
      name = "libpipewire-module-roc-sink";
      args = {
        fec.code = "disable";
        remote.ip = "10.147.20.18";
        remote.source.port = 10001;
        remote.repair.port = 10002;
        remote.control.port = 10003;
        sink.name = "ROC Sink";
        sink.props = { node.name = "roc-sink"; };
      };
    }];
  };
}
