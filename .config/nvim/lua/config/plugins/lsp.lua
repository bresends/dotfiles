return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {"williamboman/mason.nvim"},
    opts = {
      ensure_installed = { "lua_ls"},
    },
  },
 {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    "neovim/nvim-lspconfig",
    dependencies = {"folke/lazydev.nvim"},
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("lspconfig").lua_ls.setup({
        capabilities = capabilities
      })
    end,
  },
}
