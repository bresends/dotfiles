return {
  {
    'mfussenegger/nvim-lint',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' }
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      local conform = require('conform')

      conform.setup({
        formatters_by_bt = {
          lua = { 'stylua' },

          javascript = { 'prettierd' },
          typescript = { 'prettierd' },
          javascriptreact = { 'prettierd' },
          typescriptreact = { 'prettierd' }
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      })


      vim.keymap.set({ 'n', 'v' }, '<Leader>fs', function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = 'Format and Save' })
    end,
  }
}
