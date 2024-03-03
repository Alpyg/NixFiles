{
  programs.nixvim.plugins.none-ls = {
    enable = true;

    enableLspFormat = true;
    sources = {
      diagnostics = {
        eslint.enable = true;
        luacheck.enable = true;
        pylint.enable = true;
        shellcheck.enable = true;
      };
      formatting = {
        black.enable = true;
        nixfmt.enable = true;
        phpcbf.enable = true;
        prettier.enable = true;
        prettier.disableTsServerFormatter = true;
        rustfmt.enable = true;
        shfmt.enable = true;
        stylua.enable = true;
      };
    };
  };

  programs.nixvim.plugins.lsp-format = {
    enable = true;
  };
}
