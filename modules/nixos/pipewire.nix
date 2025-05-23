{ pkgs, lib, config, ... }: {
  options.pipewire.noise =
    lib.mkEnableOption "Enable pipewire noise suppression";

  config = lib.mkIf config.pipewire.noise {
    services.pipewire.extraConfig.pipewire."rnnoise" = {
      "context.properties" = { "log.level" = 0; };
      "context.spa-libs" = {
        "audio.convert.*" = "audioconvert/libspa-audioconvert";
        "support.*" = "support/libspa-support";
      };
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            #"nice.level"   = -11;
            #"rt.prio"      = 88;
            #"rt.time.soft" = 2000000;
            #"rt.time.hard" = 2000000;
          };
          flags = [ "ifexists" "nofail" ];
        }
        { name = "libpipewire-module-protocol-native"; }
        { name = "libpipewire-module-client-node"; }
        { name = "libpipewire-module-adapter"; }

        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.name" = "effect_input.rnnoise";
            "node.description" = "Noise Canceling source";
            "media.name" = "Noise Canceling source";
            "filter.graph" = {
              nodes = [{
                type = "ladspa";
                name = "rnnoise";
                plugin = "librnnoise_ladspa";
                label = "noise_suppressor_mono";
                control = { "VAD Threshold (%)" = 50.0; };
              }];
            };
            "capture.props" = {
              "node.passive" = true;
              "node.target" =
                "alsa_input.usb-M-Audio_Fast_Track-00.pro-input-0";
              "audio.position" = [ "AUX0" ];
            };
            "playback.props" = {
              "audio.position" = [ "MONO" ];
              "media.class" = "Audio/Source";
            };
          };
        }
      ];
    };
    systemd.user.services."pipewire-rnnoise" = {
      environment = { LADSPA_PATH = "${pkgs.rnnoise-plugin}/lib/ladspa"; };
      description = "Noise canceling source for pipewire";
      wantedBy = [ "pipewire.service" ];
      script = "${pkgs.pipewire}/bin/pipewire -c rnnoise.conf";
      enable = true;
      path = with pkgs; [ pipewire rnnoise-plugin ];
    };
  };
}
