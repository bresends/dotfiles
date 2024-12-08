return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.statusline').setup({
        use_icons = true
      })
      require('mini.git').setup()
      require('mini.diff').setup()
    end,
  },
}

