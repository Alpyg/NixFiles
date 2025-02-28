{ pkgs, ... }: {
  programs.nixvim.plugins.spectre = {
    enable = true;

    findPackage = pkgs.ripgrep;
    replacePackage = pkgs.gnused;
  };

  programs.nixvim.keymaps = [{
    key = "<leader>sr";
    action = "<cmd>Spectre<cr>";
    options.desc = "Replace in Files (Spectre)";
  }];
}
