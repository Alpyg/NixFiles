{
  programs.nixvim.plugins = {
    lualine.enable = true;
    vim-surround.enable = true;
    trim.enable = true;

    crates = {
      enable = true;
      settings = {
        autoload = true;
        autoupdate = true;
        smart_insert = true;
      };
    };

    mini.enable = true;
    which-key.enable = true;
    wtf.enable = true;
    web-devicons.enable = true;
  };
}
