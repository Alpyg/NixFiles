{
  programs.nixvim.plugins = {
    lualine.enable = true;
    surround.enable = true;
    trim.enable = true;

    telescope.enable = true;
    telescope.extensions.file-browser.enable = true;
    telescope.extensions.ui-select.enable = true;

    which-key.enable = true;
    wtf.enable = true;
  };
}
