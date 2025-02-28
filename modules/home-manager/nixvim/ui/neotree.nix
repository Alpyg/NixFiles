{
  programs.nixvim.plugins.neo-tree.enable = true;

  programs.nixvim.keymaps = [{
    key = "<leader>e";
    action = "<cmd>Neotree toggle<cr>";
    options.desc = "Neotree Toggle";
  }];
}
