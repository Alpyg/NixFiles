{
  programs.nixvim.plugins.chadtree = {
    enable = true;

    options = {
      showHidden = true;
      pollingRate = 0.5;
    };
  };

  programs.nixvim.keymaps = [{
    action = "<cmd>CHADopen<cr>";
    key = "<leader>e";
    options.silent = true;
  }];
}
