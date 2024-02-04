{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          cssls.enable = true;

          dockerls.enable = true;

          html.enable = true;

          java-language-server.enable = true;

          jsonls.enable = true;

          lua-ls = {
            enable = true;
            settings.telemetry.enable = false;
          };

          phpactor.enable = true;

          pylsp.enable = true;

          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };

          tailwindcss.enable = true;

          tsserver.enable = true;

          yamlls.enable = true;

          zls.enable = true;
        };
      };
    };
  };
}
