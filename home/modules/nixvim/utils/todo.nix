{
  programs.nixvim.plugins.todo-comments.enable = true;

  programs.nixvim.keymaps = [
    {
      action = "<cmd>TodoTelescope<cr>";
      key = "<leader>st";
      options.desc = "Todo";
    }
    {
      action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
      key = "<leader>sT";
      options.desc = "Todo/Fix/Fixme";
    }
    {
      action = "<cmd>Trouble todo toggle<cr>";
      key = "<leader>xt";
      options.desc = "Todo (Trouble)";
    }
    {
      action = "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>";
      key = "<leader>xT";
      options.desc = "Todo/Fix/Fixme (Trouble)";
    }
  ];
}
