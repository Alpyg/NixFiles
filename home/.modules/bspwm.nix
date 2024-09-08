{ ... }:

{
  xsession.windowManager.bspwm.enable = true;
  xsession.windowManager.bspwm.extraConfig = ''
    xrandr --output HDMI-0 --auto --primary --right-of DP-1 &
    xsetroot -cursor_name left_ptr &
  '';
  xsession.windowManager.bspwm.monitors = {
    HDMI-0 = [ "I" "II" "III" "IV" "V" ];
    DP-1 = [ "I" "II" "III" "IV" "V" ];
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
    "polybar bar"
    "picom -b --config ~/.config/picom/picom.conf"
    "kdeconnect-cli"
    "flameshot"
    "vesktop"
    "steam"
  ];
}
