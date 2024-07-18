{
  programs.nixvim.plugins.todo-comments.enable = true;

  programs.nixvim.keymaps = [
    {
      action = "<cmd>TodoTelescope<cr>";
      key = "<leader>st";
      options = {
        silent = true;
        desc = "Todo";
      };
    }
    {
      action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
      key = "<leader>sT";
      options = {
        silent = true;
        desc = "Todo/Fix/Fixme";
      };
    }
    {
      action = "<cmd>Trouble todo toggle<cr>";
      key = "<leader>xt";
      options = {
        silent = true;
        desc = "Todo (Trouble)";
      };
    }
    {
      action = "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>";
      key = "<leader>xT";
      options = {
        silent = true;
        desc = "Todo/Fix/Fixme (Trouble)";
      };
    }
  ];
}
