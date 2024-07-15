{
  imports = [
    # lsp
    ./lsp/lsp.nix
    ./lsp/treesitter.nix
    ./lsp/none-ls.nix

    # ui
    ./ui/theme.nix
    ./ui/chadtree.nix
    ./ui/bufferline.nix

    # utils
    ./utils/utils.nix
    ./utils/git.nix
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
  };
}
