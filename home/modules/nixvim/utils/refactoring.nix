{ ... }: {
  programs.nixvim.plugins.refactoring = {
    enable = true;
    enableTelescope = true;

    settings = {
      prompt_func_param_type = {
        go = true;
        cpp = true;
        c = true;
        java = true;
      };
      prompt_func_return_type = {
        go = true;
        cpp = true;
        c = true;
        java = true;
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>re";
      action = "<cmd>Refactor extract <cr>";
      options.desc = "Extract";
    }
    {
      key = "<leader>rf";
      action = "<cmd>Refactor extract_to_file <cr>";
      options.desc = "Extract to File";
    }
    {
      key = "<leader>rv";
      action = "<cmd>Refactor extract_var <cr>";
      options.desc = "Extract Variable";
    }
    {
      key = "<leader>ri";
      action = "<cmd>Refactor inline_var<cr>";
      options.desc = "Inline Variable";
    }
    {
      key = "<leader>rI";
      action = "<cmd>Refactor inline_func<cr>";
      options.desc = "Inline Function";
    }
    {
      key = "<leader>rb";
      action = "<cmd>Refactor extract_block<cr>";
      options.desc = "Extract Block";
    }
    {
      key = "<leader>rbf";
      action = "<cmd>Refactor extract_block_to_file<cr>";
      options.desc = "Extract Block to File";
    }
  ];
}
