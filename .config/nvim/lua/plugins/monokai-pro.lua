return {
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        override = function(colors)
          return {
            ["@markup.list.checked.markdown"] = { fg = colors.base.red, italic = false },
          }
        end

      })
      vim.cmd("colorscheme monokai-pro")
    end
  }
}
