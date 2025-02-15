{
  programs.nixvim.plugins.lsp-format.enable = true;

  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    sources = {
      diagnostics = { mypy.enable = true; };
      formatting = {
        black.enable = true;
        gofmt.enable = true;
        google_java_format.enable = true;
        leptosfmt.enable = true;
        mdformat.enable = true;
        nixfmt.enable = true;
        prettierd = {
          enable = true;
          disableTsServerFormatter = true;
        };
        stylua.enable = true;
        yamlfmt.enable = true;
      };
    };
  };
}
