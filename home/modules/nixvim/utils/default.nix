{
  programs.nixvim.plugins = {
    lualine.enable = true;
    vim-surround.enable = true;
    trim.enable = true;

    crates-nvim.enable = true;

    telescope.enable = true;
    telescope.extensions.file-browser.enable = true;
    telescope.extensions.ui-select.enable = true;

    mini.enable = true;
    which-key.enable = true;
    wtf.enable = true;
    web-devicons.enable = true;
  };
}
