{
  programs.nixvim.plugins.neo-tree.enable = true;

  programs.nixvim.keymaps = [{
    action = "<cmd>Neotree toggle<cr>";
    key = "<leader>e";
    options.silent = true;
  }];
}
