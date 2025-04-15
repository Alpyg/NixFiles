{ pkgs, ... }: {
  programs.nixvim.plugins = {
    dap.enable = true;

    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap-python.enable = true;

    dap-lldb = {
      enable = true;

      settings = {
        codelldb_path =
          "${pkgs.vscode-extensions.vadimcn.vscode-lldb.out}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
        configurations = {
          zig = [
            {
              name = "Build";
              type = "shell";
              command = "zig build";

            }
            {
              name = "Debug";
              type = "lldb";
              request = "launch";
              program =
                "\${workspaceFolder}/zig-out/bin/\${workspaceFolderBasename}";
              cwd = "\${workspaceFolder}";
              stopOnEntry = false;
              dependsOn = [ "Build" ];
            }
          ];
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>du";
      action = "<cmd>lua require('dapui').toggle()<cr>";
    }
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
