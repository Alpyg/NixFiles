{ ... }:

{
  xsession.windowManager.bspwm.enable = true;
  xsession.windowManager.bspwm.extraConfig = ''
    xrandr --output DP-0 --mode 2560x1440 --rate 180 --primary --left-of HDMI-0 &
    xsetroot -cursor_name left_ptr &
  '';
  xsession.windowManager.bspwm.monitors = {
    HDMI-0 = [ "I" "II" "III" "IV" "V" ];
    DP-0 = [ "I" "II" "III" "IV" "V" ];
    eDP-1 = [ "I" "II" "III" "IV" "V" ];
  };
  xsession.windowManager.bspwm.settings = {
    border_width = 2;
    window_gap = 4;
    split_ratio = 0.5;
    borderless_monocle = true;
    gapless_monocle = true;
  };
  xsession.windowManager.bspwm.startupPrograms = [
    "kill polybar"
    "MONITOR=HDMI-0 polybar bar"
    "picom -b --config ~/.config/picom/picom.conf"
    "kdeconnect-cli"
    "flameshot"
    "vesktop"
    "steam"
  ];
}
