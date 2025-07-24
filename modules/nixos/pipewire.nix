{ pkgs, lib, config, ... }: {
  options.pipewire.noise.enable =
    lib.mkEnableOption "Enable pipewire noise suppression";

  config = lib.mkIf config.pipewire.noise.enable {
    services.pipewire.extraConfig.pipewire."rnnoise" = {
      context.properties = { "log.level" = 0; };
      context.spa-libs = {
        "audio.convert.*" = "audioconvert/libspa-audioconvert";
        "support.*" = "support/libspa-support";
      };
      context.modules = [
        {
          name = "libpipewire-module-filter-chain";
          args = {
            node.description = "Noise Canceling source";
            media.name = "Noise Canceling source";
            filter.graph = {
              nodes = [{
                type = "ladspa";
                name = "rnnoise";
                plugin = "librnnoise_ladspa";
                label = "noise_suppressor_mono";
                control = {
                  "VAD Threshold (%)" = 50.0;
                  "VDA Grace Period (ms)" = 200;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              }];
            };
            capture.props = {
              node.name = "capture.rnnoise_source";
              node.passive = true;
              audio.rate = 48000;
            };
            playback.props = {
              node.name = "rnnoise_source";
              media.class = "Audio/Source";
              audio.rate = 48000;
            };
          };
        }
      ];
    };
  };
}
