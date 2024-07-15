{
  imports = [
    ./chadtree.nix
  ];

  colorschemes.catppuccin = {
    enable = true;
    settings = { background.dark = "mocha"; };
  };

  plugins = {
    gitsigns = {
      enable = true;
      settings = {
        signcolumn = true;
        signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "-";
          untracked.text = ".";
        };
        watch_gitdir.follow_files = true;
      };
    };

    nvim-autopairs.enable = true;

    nvim-colorizer = {
      enable = true;
      userDefaultOptions.names = false;
    };

    which-key.enable = true;
    noice.enable = true;
    copilot-lua.enable = true;
  };
}
