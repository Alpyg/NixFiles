{ config, pkgs, ... }: {
  services.pipewire.extraConfig.pipewire."roc-source" = {
    "context.modules" = [{
      name = "libpipewire-module-roc-source";
      args = {
        local.ip = "0.0.0.0";
        resampler.profile = "medium";
        fec.code = "disable";
        sess.latency.msec = 5000;
        local.source.port = 10001;
        local.repair.port = 10002;
        local.control.port = 10003;
        source.name = "ROC Source";
        source.props = { node.name = "roc-source"; };
      };
    }];
  };
  systemd.user.services."pipewire-roc-source" = {
    description = "Pipewire roc source";
    wantedBy = [ "pipewire.service" ];
    script = "${pkgs.pipewire}/bin/pipewire -c roc-source.conf";
    enable = true;
    path = with pkgs; [ pipewire ];
  };
}
