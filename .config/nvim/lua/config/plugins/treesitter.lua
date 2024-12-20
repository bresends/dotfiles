return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")

      config.setup({
        -- Nvim required parsers
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

        auto_install = true,

        highlight = { enable = true },

        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Leader>ss", -- normal mode
            node_incremental = "<Leader>ss", -- visual mode
            node_decremental = "<Leader>sd", -- visual mode
            scope_incremental = "<Leader>sc", -- visual mode
          },
        },
      })
    end
  }
}
