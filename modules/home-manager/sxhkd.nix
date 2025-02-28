{ lib, config, ... }: {
  options.sxhkd.enable = lib.mkEnableOption "Enable sxhkd";

  config = lib.mkIf config.sxhkd.enable {
    services.sxhkd.enable = true;
    services.sxhkd.keybindings = {
      # wm
      "super + Return" = "kitty"; # terminal
      "super + d" = "dmenu_run"; # dmenu
      "super + `" = "pkill -USR1 -x sxhkd; pkill -USR1 polybar"; # reload sxhkd

      # bspwm
      "super + alt + r" = "bspc wm -r"; # reload bspwm
      "super + {_,shift + }x" = "bspc node -{c,k}"; # close/kill
      "super + m" = "bspc desktop -l next"; # toggle monocle
      "super + {t,shift + t,s,f}" =
        "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}"; # toggle node state

      # window manipulation
      "super + {_,shift + }{h,j,k,l}" =
        "bspc node -{f,s} {west,south,north,east}"; # focus/swap
      "super + Tab" = "bspc desktop -f last"; # last desktop
      "super + {_,shift + }{1-9,0}" =
        "bspc {desktop -f,node -d} focused:'^{1-9,10}'"; # focus/swap desktop

      # preselect
      "super + ctrl + {h,j,k,l}" =
        "bspc node -p {west,south,north,east}"; # preselect
      "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}"; # set preselection ratio
      "super + ctrl + space" = "bspc node -p cancel"; # cancel preselection

      # move/resize
      "super + alt + {h,j,k,l}" =
        "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}"; # expand
      "super + alt + shift + {h,j,k,l}" =
        "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}"; # contract
      "super + {Left,Down,Up,Right}" =
        "bspc node -v {-20 0,0 20,0 -20,20 0}"; # move floating

      # other
      "super + shift + s" = "flameshot gui -c -s"; # screenshot
      "XF86Audio{Play,Prev,Next}" =
        "playerctl {play-pause,previous,next}"; # media keys
    };
  };
}
