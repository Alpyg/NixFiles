{
  imports = [
    ./barbar.nix
    ./floaterm.nix
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./none-ls.nix
    ./ollama.nix
    ./startify.nix
    ./telescope.nix
    ./treesitter.nix
  ];

  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      background.dark = "mocha";
    };

    plugins = {
      gitsigns = {
        enable = true;
        signs = {
          add.text = "+";
          change.text = "~";
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
  };
}
