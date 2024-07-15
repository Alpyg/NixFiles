{
  programs.nixvim.plugins.lsp-format.enable = true;

  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    sources = {
      formatting = {
        black.enable = true;
        gofmt.enable = true;
        google_java_format.enable = true;
        leptosfmt.enable = true;
        mdformat.enable = true;
        nixfmt.enable = true;
        nixpkgs_fmt.enable = true;
        prettierd.enable = true;
        stylua.enable = true;
        yamlfmt.enable = true;
      };
    };
  };
}
