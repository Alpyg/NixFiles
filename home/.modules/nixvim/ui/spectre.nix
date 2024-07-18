{ pkgs, ... }:

{
  programs.nixvim.plugins.spectre = {
    enable = true;

    findPackage = pkgs.ripgrep;
    replacePackage = pkgs.gnused;
  };

  programs.nixvim.keymaps = [{
    action = "<cmd>Spectre<cr>";
    key = "<leader>sr";
    options.desc = "Replace in Files (Spectre)";
  }];
}
