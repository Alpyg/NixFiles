{ lib, config, ... }: {
  options.mangohud = {
    enable = lib.mkEnableOption "Enable MangoHud";
  };

  config = lib.mkIf config.mangohud.enable {
    programs.mangohud = {
      enable = true;

      settings = {
        legacy_layout = "false";

        horizontal = 1;
        round_corners = 10;
        background_alpha = 0.3;
        background_color = "1E1E2E";
        table_columns = 1;

        font_size = 16;
        text_color = "FFFFFF";
        position = "top-left";

        gpu_text = "GPU";
        gpu_stats = 1;
        gpu_load_change = 1;
        gpu_load_value = [ 50 90 ];
        gpu_load_color = [ "FFFFFF" "FFAA7F" "CC0000" ];
        gpu_temp = 1;
        gpu_color = "2E9762";
        
        cpu_text = "CPU";
        cpu_stats = 1;
        cpu_load_change = 1;
        cpu_load_value = [ 50 90 ];
        cpu_load_color = [ "FFFFFF" "FFAA7F" "CC0000" ];
        cpu_temp = 1;
        cpu_color = "2E97CB";
        
        vram = 1;
        vram_color = "AD64C1";
        
        fps = 1;
        frame_timing = 0;
        fps_limit_method = "early";
        toggle_fps_limit = "none";

        fps_limit = 0;
        fps_color_change = 1;
        fps_color = [ "B22222" "FDFD09" "39F900" ];
        fps_value = [ 30 60 ];

        output_folder = "/home/alpyg";
        toggle_logging = "none";

        blacklist = [ "pamac-manager" "lact" "ghb" "bitwig-studio" "ptyxis" "yumex" ];
      };
    };
  };
}
