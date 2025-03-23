{ pkgs, lib, config, ... }: {
  options.hyprland.enable = lib.mkEnableOption "Enable hyprland";

  config = lib.mkIf config.hyprland.enable {
    home.packages = with pkgs; [
      rofi-wayland
      kdePackages.xwaylandvideobridge
      grim
      slurp
    ];
    wayland.windowManager.hyprland = {
      enable = true;

      plugins = [ pkgs.hyprlandPlugins.hyprsplit ];
      settings = {
        monitor = [
          "HDMI-A-1, 1920x1080@60, 4480x360, 1"
          "DP-1, 2560x1440@180, 1920x0, 1"
          "DP-2, 1920x1080@75, 0x360, 1"
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
          "noblur, class:^()$"
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
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ -5%"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ +5% -l 1"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
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
          "$mod, 6, split:workspace, 6"
          "$mod, 7, split:workspace, 7"
          "$mod, 8, split:workspace, 8"
          "$mod, 9, split:workspace, 9"
          "$mod, 0, split:workspace, 10"

          "$mod SHIFT, 1, split:movetoworkspacesilent, 1"
          "$mod SHIFT, 2, split:movetoworkspacesilent, 2"
          "$mod SHIFT, 3, split:movetoworkspacesilent, 3"
          "$mod SHIFT, 4, split:movetoworkspacesilent, 4"
          "$mod SHIFT, 5, split:movetoworkspacesilent, 5"
          "$mod SHIFT, 6, split:movetoworkspacesilent, 6"
          "$mod SHIFT, 7, split:movetoworkspacesilent, 7"
          "$mod SHIFT, 8, split:movetoworkspacesilent, 8"
          "$mod SHIFT, 9, split:movetoworkspacesilent, 9"
          "$mod SHIFT, 0, split:movetoworkspacesilent, 10"
        ];

        bindm = [
          # Mouse
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        exec-once = [
          "clipse -listen"
          "XDG_SESSION_TYPE=x11 discord"
          "steam"
          "kdeconnect-cli"
          "eww open bar"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];
      };

      # set to null to use the ones from the Nixos module
      package = null;
      portalPackage = null;
    };
  };
}
