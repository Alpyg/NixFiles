return {
  {
    "ziglang/zig.vim",
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        zls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "zig",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "zls",
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        local nls = require("none-ls")
        vim.list_extend(opts.sources, {
          nls.builtins.formatting.zigfmt,
        })
      end
    end,
  },
}
