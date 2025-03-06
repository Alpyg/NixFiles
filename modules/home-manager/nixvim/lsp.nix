{ pkgs, ... }: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;

      servers = {
        docker_compose_language_service.enable = true;
        dockerls.enable = true;
        eslint.enable = true;
        gopls.enable = true;
        html.enable = true;
        intelephense = {
          enable = true;
          package = pkgs.intelephense;
        };
        java_language_server.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        lua_ls.enable = true;
        pyright.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        tailwindcss.enable = true;
        ts_ls.enable = true;
        zls = {
          enable = true;
          package = null;
          cmd = [ "zls" ];
        };
        nixd = {
          enable = true;
          settings = {
            nixpkgs.expr = "import <nixpkgs> {}";
            formatting.command = [ "nixfmt" ];
          };
        };
        csharp_ls.enable = true;
      };
    };

    lsp-format.enable = true;
    none-ls = {
      enable = true;
      sources = {
        diagnostics = { mypy.enable = true; };
        formatting = {
          black.enable = true;
          gofmt.enable = true;
          google_java_format.enable = true;
          leptosfmt.enable = true;
          mdformat.enable = true;
          nixfmt.enable = true;
          prettierd = {
            enable = true;
            disableTsServerFormatter = true;
          };
          stylua.enable = true;
          yamlfmt.enable = true;
          csharpier.enable = true;
        };
      };
    };

    treesitter = {
      enable = true;

      nixvimInjections = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      nixGrammars = true;

      folding = true;
      settings = {
        auto_install = true;
        indent.enable = true;
        highlight.enable = true;
      };
    };
    treesitter-context.enable = true;
    rainbow-delimiters.enable = true;

    hmts.enable = true;
    inc-rename.enable = true;
    nix.enable = true;

  };

  programs.nixvim.keymaps = [
    {
      key = "gd";
      action = "<cmd>lua vim.lsp.buf.definition()<cr>";
      options.desc = "Goto Definition";
    }
    {
      key = "gr";
      action = "<cmd>lua vim.lsp.buf.references()<cr>";
      options.desc = "References";
    }
    {
      key = "gI";
      action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
      options.desc = "Goto Implementation";
    }
    {
      key = "gt";
      action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
      options.desc = "Goto Type Definition";
    }
    {
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
      options.desc = "Goto Declaration";
    }

    {
      key = "<leader>cl";
      action = "<cmd>LspInfo<cr>";
      options.desc = "LSP Info";
    }
    {
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
      options.desc = "Code Action";
    }
    {
      key = "<leader>cr";
      action = "<cmd>IncRename <cr>";
      options.desc = "Rename";
    }
    {
      key = "<leader>cc";
      action = "<cmd>lua vim.lsp.codelens.run()<cr>";
      options.desc = "Run Codelens";
    }
    {
      key = "<leader>cC";
      action = "<cmd>lua vim.lsp.codelens.refresh()<cr>";
      options.desc = "Refresh & Display Codelens";
    }
  ];
}
