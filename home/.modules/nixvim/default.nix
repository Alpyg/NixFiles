{
  imports = [
    # misc
    ./options.nix
    ./keymaps.nix

    ./cmp/cmp.nix

    # lsp
    ./lsp/lsp.nix
    ./lsp/treesitter.nix
    ./lsp/none-ls.nix

    # ui
    ./ui/bufferline.nix
    ./ui/floaterm.nix
    ./ui/neotree.nix
    ./ui/spectre.nix
    ./ui/telescope.nix
    ./ui/theme.nix

    # utils
    ./utils/git.nix
    ./utils/todo.nix
    ./utils/trouble.nix
    ./utils/utils.nix
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

    plugins.lazy.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";

      loaded_python_provider = 0;
    };

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };
  };
}
