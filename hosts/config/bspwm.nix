{ ... }:

{
  xsession.windowManager.bspwm.enable = true;
  xsession.windowManager.bspwm.extraConfig = ''
    xrandr --output HDMI-0 --auto --primary --right-of DP-1 &
    xsetroot -cursor_name left_ptr &
  '';
  xsession.windowManager.bspwm.monitors = {
    HDMI-0 = [ "I" "II" "III" "IV" ];
    DP-1 = [ "I" "II" "III" "IV" ];
  };
  xsession.windowManager.bspwm.settings = {
    border_width = 2;
    window_gap = 4;
    split_ratio = 0.5;
    borderless_monocle = true;
    gapless_monocle = true;
  };
  xsession.windowManager.bspwm.startupPrograms = [
    "picom -b --config ~/.config/picom/picom.conf"
    "polybar bar 2>&1 | tee -a /tmp/polybar.log"
    "eww daemon"
    "kdeconnect-cli"
    "eww open notifications"
    "flameshot"
    "discord"
    "steam"
  ];
}
