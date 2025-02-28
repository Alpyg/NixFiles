{ pkgs, lib, config, ... }: {

  options.polybar.enable = lib.mkEnableOption "Enable polybar";

  config = lib.mkIf config.polybar.enable {
    services.polybar.enable = true;
    services.polybar.package = pkgs.polybar.override {
      alsaSupport = true;
      iwSupport = true;
      githubSupport = true;
    };
    services.polybar.script = "polybar bar 2>&1 | tee -a /tmp/polybar.log";
    services.polybar.settings = {
      "colors" = {
        background = "#282a2e";
        background-alt = "#373b41";
        foreground = "#c5c8c6";
        primary = "#f0C674";
        secondary = "#8ABEB7";
        alert = "#A54242";
        disabled = "#707880";
      };
      "bar/bar" = {
        monitor = "\${env:MONITOR:}";
        width = "100%";
        height = "12pt";
        radius = "6";
        line-size = "2pt";

        padding-left = "1";
        padding-right = "1";
        module-margin = "1";

        separator = "|";
        seperator-foreground = "\${colors.disabled}";

        font-0 = "monospace;2";

        modules-left = "xwindow";
        modules-right = "memory cpu volume battery date";

        cursor-click = "pointer";
        cursor-scroll = "ns-resize";

        enable-ipc = "true";
      };
      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:60:...%";
      };
      "module/memory" = {
        type = "internal/memory";
        interval = "1";
        format-prefix = "RAM ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage_used:2%%";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = "1";
        format-prefix = "CPU ";
        format-prefix-foreground = "\${colors.primary}";
        label = "%percentage:2%%";
      };
      "module/volume" = {
        type = "internal/alsa";
        label-volume = "%percentage%%";
        label-muted-foreground = "#660";
        interval = "10";
      };
      "module/battery" = {
        type = "internal/battery";
        full-at = "99";
        low-at = "10";
        poll-interval = "5";
      };
      "module/date" = {
        type = "internal/date";
        interval = "1";
        date = "%H:%M";
        date-alt = "%Y-%m-%d %H:%M:%S";
        label = "%date%";
        label-foreground = "\${colors.primary}";
      };
    };
  };
}
