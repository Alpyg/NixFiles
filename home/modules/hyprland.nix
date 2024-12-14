{ pkgs, ... }: {
  home.packages = with pkgs; [ rofi-wayland ];
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [ pkgs.hyprlandPlugins.hyprsplit ];
    settings = {
      monitor = [
        "HDMI-A-1, 1920x1080@60, 0x0, 1, transform, 1"
        "DP-1, 2560x1440@180, 1080x480, 1"
        "DP-2, 1920x1080@75, 3640x840, 1"
      ];
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "LIBVA_DRIVER_NAME,nvidia"
        "___GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      cursor.no_hardware_cursors = true;

      windowrulev2 = [
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
        "float, class:(clipse)"
        "size 622 622, class:(clipse)"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };

      input = { follow_mouse = 2; };

      "$mod" = "SUPER";
      "$terminal" = "kitty";

      bind = [
        "$mod, return, exec, $terminal"
        "$mod, d, exec, rofi -show drun -show-icons"
        "$mod SHIFT, x, killactive"

        # tiling
        "$mod, t, togglefloating"
        "$mod, f, fullscreen, 0"
        "$mod, m, fullscreen, 1"

        # movement
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # funct
        ", XF86AudioLowerVolume, exec, wpctl --set-sink-volume @DEFAULT_AUDIO_SINK@ -5%"
        ", XF86AudioRaiseVolume, exec, wpctl --set-sink-volume @DEFAULT_AUDIO_SINK@ +5%"
        ", XF86AudioMute, exec, wpctl --set-sink-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", Print, exec, flameshot gui -c -s"
        "$mod SHIFT, v, exec, $terminal --class clipse -e clipse"

        # workspaces
        "$mod, 1, split:workspace, 1"
        "$mod, 2, split:workspace, 2"
        "$mod, 3, split:workspace, 3"
        "$mod, 4, split:workspace, 4"
        "$mod, 5, split:workspace, 5"

        "$mod SHIFT, 1, split:movetoworkspacesilent, 1"
        "$mod SHIFT, 2, split:movetoworkspacesilent, 2"
        "$mod SHIFT, 3, split:movetoworkspacesilent, 3"
        "$mod SHIFT, 4, split:movetoworkspacesilent, 4"
        "$mod SHIFT, 5, split:movetoworkspacesilent, 5"
      ];

      bindm = [
        #
        # Mouse
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [ "clipse -listen" "discord" "steam" "kdeconnect-cli" ];
    };
  };
}
