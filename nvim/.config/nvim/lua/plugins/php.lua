return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "intelephense", "phpstan", "pint", "blade-formatter" })
      end
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        local nls = require("none-ls")
        vim.list_extend(opts.sources, {
          nls.builtins.formatting.pint,
          nls.builtins.formatting.blade_formatter,
          nls.builtins.diagnostics.phpstan,
        })
      end
    end,
  }
}
