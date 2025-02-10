{ ... }: {
  programs.nixvim.plugins = {
    dap.enable = true;

    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap-python.enable = true;

    dap-lldb = {
      enable = true;

      settings = {
        configurations = {
          zig = [{
            name = "Debug QEMU";
            type = "codelldb";
            request = "launch";
            program =
              "$\${workspaceFolder}/zig-out/bin/$\${workspaceFolderBasename}";
            cwd = "$\${workspaceFolder}";
            miDebuggerPath = "gdb";
            miDebuggerServerAddress = "localhost:1234";
            stopAtEntry = true;
          }];
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>db";
      action = "<cmd>DapToggleBreakpoint<cr>";
      options.desc = "Toggle Breakpoint";
    }
    {
      key = "<leader>dc";
      action = "<cmd>DapContinue<cr>";
      options.desc = "Run/Continue";
    }
    {
      key = "<leader>di";
      action = "<cmd>DapStepInto<cr>";
      options.desc = "Step Into";
    }
    {
      key = "<leader>do";
      action = "<cmd>DapStepOut<cr>";
      options.desc = "Step Out";
    }
    {
      key = "<leader>dO";
      action = "<cmd>DapStepOver<cr>";
      options.desc = "Step Over";
    }
    {
      key = "<leader>dt";
      action = "<cmd>DapTerminate<cr>";
      options.desc = "Terminate";
    }
  ];

}
