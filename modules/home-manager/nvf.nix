{
  lib,
  config,
  ...
}: {
  options.nvf.enable = lib.mkEnableOption "Enable nvf";

  config = lib.mkIf config.nvf.enable {
    programs.nvf.enable = true;
    programs.nvf.settings.vim = {
      viAlias = true;
      vimAlias = true;

      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      options = {
        tabstop = 2;
        shiftwidth = 2;
      };

      spellcheck = {enable = true;};

      lsp = {
        formatOnSave = true;
        lspkind.enable = true;
        lightbulb.enable = true;
        lspsaga.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
        otter-nvim.enable = true;
        lsplines.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        markdown.enable = true;
        bash.enable = true;

        ts.enable = true;
        html.enable = true;
        css.enable = true;
        tailwind.enable = true;
        sql.enable = true;

        zig.enable = true;
        rust = {
          enable = true;
          crates.enable = true;
        };
        go.enable = true;
        python.enable = true;
        java.enable = true;
        kotlin.enable = true;
        clang.enable = true;
        csharp.enable = true;
        lua.enable = true;
      };

      visuals = {
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        indent-blankline.enable = true;

        cellular-automaton.enable = true;
      };

      statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };

      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };

      autopairs.nvim-autopairs.enable = true;
      autocomplete.nvim-cmp.enable = true;
      snippets.luasnip.enable = true;

      filetree = {neo-tree = {enable = true;};};

      tabline = {nvimBufferline.enable = true;};

      treesitter.context.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };

      dashboard = {
        dashboard-nvim.enable = false;
        alpha.enable = true;
      };

      notify = {nvim-notify.enable = true;};

      projects = {project-nvim.enable = true;};

      utility = {
        ccc.enable = false;
        vim-wakatime.enable = false;
        diffview-nvim.enable = true;
        yanky-nvim.enable = false;
        icon-picker.enable = true;
        surround.enable = true;
        leetcode-nvim.enable = true;
        multicursors.enable = true;

        motion = {
          hop.enable = true;
          leap.enable = true;
        };
      };

      notes = {todo-comments.enable = true;};

      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            nix = "110";
            ruby = "120";
            java = "130";
            go = ["90" "130"];
          };
        };
        fastaction.enable = true;
      };

      assistant = {
        copilot = {
          enable = true;
          cmp.enable = true;
        };
      };

      session = {nvim-session-manager.enable = false;};

      gestures = {gesture-nvim.enable = false;};

      comments = {comment-nvim.enable = true;};
    };
  };
}
