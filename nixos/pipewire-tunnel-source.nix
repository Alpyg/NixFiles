{ ... }: {
  services.pipewire.extraConfig.pipewire."tunnel-source" = {
    "context.modules" = [{
      name = "libpipewire-module-protocol-simple";
      args = {
        capture = false;
        playback = true;
        server.address = [ "tcp:4711" ];
      };
    }];
  };
}
