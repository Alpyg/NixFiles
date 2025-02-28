{ lib, config, ... }: {
  options.kanata.enable = lib.mkEnableOption "Enable Kanata";

  config = lib.mkIf config.kanata.enable {
    services.kanata = {
      enable = true;

      keyboards.alpyg.extraDefCfg = "process-unmapped-keys yes";
      keyboards.alpyg.config = ''
        (defalias
          tnum  (tap-hold 200 200 tab   (layer-while-held num-layer))
          zalt  (tap-hold 400 400 z     lalt)
          bnav  (tap-hold 200 200 bspc  (layer-while-held nav-layer))
          fn    (tap-hold 200 200 ralt  (layer-while-held fn-layer))
          min   (tap-hold 200 200 -     =)
          esc   (switch
            (lsft) S-grv break
            () esc break
          )

          lb  [
          rb  ]
          lp  S-9
          rp  S-0
          lcb (multi lsft [)
          rcb (multi lsft ])
        )

        (defsrc
          esc     1     2     3     4     5       6     7     8     9     0     -
          tab     q     w     e     r     t       y     u     i     o     p     \
          lsft    a     s     d     f     g       h     j     k     l     ;     '
          lctl    z     x     c     v     b       n     m     ,     .     /     rctl
                              lmet  lalt  spc     ret   bspc  ralt
        )

        (deflayer qwerty
          @esc    1     2     3     4     5       6     7     8     9     0     @min
          tab     q     w     e     r     t       y     u     i     o     p     \
          lsft    a     s     d     f     g       h     j     k     l     ;     '
          lctl    @zalt x     c     v     b       n     m     ,     .     /     rctl
                              lmet  @tnum spc     ret   @bnav @fn
        )

        (deflayer num-layer
          grv   _     _     _     _     _       _     _     _     _     _     _
          _     _     _     _     _     _       _     _     @lb   @rb   _     _
          _     _     _     _     _     _       _     _     @lp   @rp   _     _
          _     _     _     _     _     _       _     _     @lcb  @rcb  _     _
                            _     _     _       _     _     _
        )

        (deflayer nav-layer
          _     _     _     _     _     _       prnt  pgup  _     home  _     _
          _     _     _     _     _     _       _     pgdn  up    end   _     _
          _     _     _     _     _     _       _     left  down  rght  _     _
          _     _     _     _     _     _       del   _     _     _     _     _
                            _     _     _       _     _     _
        )

        (deflayer fn-layer
          f1    f2    f3    f4    f5    f6      f7    f8    f9    f10   f11   f12
          _     _     _     _     _     _       _     mute  volu  vold  _     _
          _     _     _     _     _     _       _     prev  pp    next  _     rsft
          _     _     _     _     _     _       _     _     _     _     _     _
                            _     _     _       _     _     _
        )

        ;; (deflayer
        ;;   _     _     _     _     _     _       _     _     _     _     _     _
        ;;   _     _     _     _     _     _       _     _     _     _     _     _
        ;;   _     _     _     _     _     _       _     _     _     _     _     _
        ;;   _     _     _     _     _     _       _     _     _     _     _     _
        ;;                     _     _     _       _     _     _
        ;; )
      '';
    };
  };
}
