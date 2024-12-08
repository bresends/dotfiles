return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false, -- make sure we load this during startup 
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },
}
