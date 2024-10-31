{
  programs.nixvim.plugins.telescope = {
    enable = true;
  };

  programs.nixvim.keymaps = [
    {
      action = "<cmd>Telescope find_files<cr>";
      key = "<leader>ff";
      options.desc = "Telescope find files";
    }
    {
      action = "<cmd>Telescope live_grep<cr>";
      key = "<leader>fg";
      options.desc = "Telescope live grep";
    }
    {
      action = "<cmd>Telescope buffers<cr>";
      key = "<leader>fb";
      options.desc = "Telescope buffers";
    }
    {
      action = "<cmd>Telescope help_tags<cr>";
      key = "<leader>fh";
      options.desc = "Telescope help tags";
    }
  ];
}
