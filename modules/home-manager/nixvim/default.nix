{ lib, config, ... }: {
  imports = [
    ./options.nix
    ./keymaps.nix

    ./cmp.nix
    ./dap.nix
    ./lsp.nix

    # snippets
    ./snippets/luasnip.nix

    # ui
    ./ui/bufferline.nix
    ./ui/floaterm.nix
    ./ui/illuminate.nix
    ./ui/neotree.nix
    ./ui/noice.nix
    ./ui/telescope.nix
    ./ui/theme.nix
    ./ui/which-key.nix

    # utils
    ./utils
    ./utils/codecompanion.nix
    ./utils/git.nix
    ./utils/refactoring.nix
    ./utils/todo.nix
    ./utils/trouble.nix
  ];

  options.nixvim.enable = lib.mkEnableOption "Enable nixvim";

  config = lib.mkIf config.nixvim.enable {
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
        providers.wl-copy.enable = true;
      };
    };
  };
}
