return {
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				override = function(colors)
					return {
						["@markup.heading.1.markdown"] = { fg = "#fc9867", italic = false }, --H1
						["@markup.heading.2.markdown"] = { fg = "#fc9867", italic = false }, --H2
						["@markup.heading.3.markdown"] = { fg = "#fc9867", italic = false }, --H3
						["@markup.strong.markdown_inline"] = { fg = colors.base.yellow, italic = false }, --Bold
						["@markup.list.checked.markdown"] = { fg = colors.base.red, italic = false }, --Checked
					}
				end,
			})
			vim.cmd("colorscheme monokai-pro")
		end,
	},
}
