{ pkgs, ... }: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      nixvimInjections = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      nixGrammars = true;

      folding = true;
      settings = {
        auto_install = true;
        indent.enable = true;
        highlight.enable = true;
      };
    };
    treesitter-context.enable = true;
    rainbow-delimiters.enable = true;

    hmts.enable = true;
  };
}
