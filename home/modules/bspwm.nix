{ ... }: {
  xsession.windowManager.bspwm.enable = true;
  xsession.windowManager.bspwm.extraConfig = ''
    ~/.nixdots/scripts/xrandr.sh
  '';
  xsession.windowManager.bspwm.monitors = {
    HDMI-0 = [ "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X" ];
    DP-0 = [ "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X" ];
    DP-3 = [ "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X" ];
    eDP-1 = [ "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X" ];
  };
  xsession.windowManager.bspwm.settings = {
    border_width = 2;
    window_gap = 5;
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
    "discord"
    "steam"
  ];
}
