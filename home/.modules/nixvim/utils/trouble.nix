{
  programs.nixvim.plugins.trouble = {
    enable = true;
    settings = { position = "left"; };
  };

  programs.nixvim.keymaps = [
    {
      action = "<cmd>Trouble diagnostics toggle<cr>";
      key = "<leader>xx";
      options = {
        silent = true;
        desc = "Diagnostics (Trouble)";
      };
    }
    {
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<<cr>";
      key = "<leader>xX";
      options = {
        silent = true;
        desc = "Buffer Diagnostics (Trouble)";
      };
    }
    {
      action = "<cmd>Trouble symbols toggle<cr>";
      key = "<leader>cs";
      options = {
        silent = true;
        desc = "Symbols (Trouble)";
      };
    }
    {
      action = "<cmd>Trouble lsp toggle<cr>";
      key = "<leader>cS";
      options = {
        silent = true;
        desc = "LSP references/definitions/... (Trouble)";
      };
    }
    {
      action = "<cmd>Trouble loclist toggle<cr>";
      key = "<leader>xL";
      options = {
        silent = true;
        desc = "Location List (Trouble)";
      };
    }
    {
      action = "<cmd>Trouble qflist toggle<cr>";
      key = "<leader>xQ";
      options = {
        silent = true;
        desc = "Quickfix List (Trouble)";
      };
    }
  ];
}
