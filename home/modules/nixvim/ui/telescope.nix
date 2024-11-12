{
  programs.nixvim.plugins.telescope = { enable = true; };

  programs.nixvim.keymaps = [
    {
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
      options.desc = "Telescope find files";
    }
    {
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
      options.desc = "Telescope live grep";
    }
    {
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<cr>";
      options.desc = "Telescope buffers";
    }
    {
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<cr>";
      options.desc = "Telescope help tags";
    }
  ];
}
