{ ... }: {
  services.pipewire.extraConfig.pipewire."tunnel-sink" = {
    "context.modules" = [{
      name = "libpipewire-module-pulse-tunnel";
      args = {
        tunnel.mode = "sink";
        pulse.server.address = "tcp:10.147.20.18:4711";
        pulse.latency = 10;
      };
    }];
  };
}
