{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
      batwatch
      prettybat
    ];
  };

  programs.yazi = {
    enable = true;
    settings.manager.show_hidden = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
  };

  home.packages = with pkgs; [
    du-dust
    dua
    eza
    fd
    lldb
    ripgrep-all
    # uutils-coreutils-noprefix
    xh
  ];

  home.shellAliases = { ls = "eza"; };
}
