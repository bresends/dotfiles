return {
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		config = function()
			require("monokai-pro").setup({
				transparent_background = true,
				override = function(colors)
					return {
						CursorLine = { bg = "#4a4a51" },
						Visual = { bg = "#4a4a51" },
						CursorLineNr = { fg = colors.base.yellow },

						["@markup.heading.1.markdown"] = { fg = "#fc9867", italic = false }, --H2
						["@markup.heading.2.markdown"] = { fg = colors.base.red, italic = false }, --H1
						["@markup.heading.3.markdown"] = { fg = colors.base.blue, italic = false }, --H3
						["@markup.heading.4.markdown"] = { fg = colors.base.magenta, italic = false }, --H4
						["@markup.heading.5.markdown"] = { fg = colors.base.blue, italic = false }, --H5
						["@markup.strong.markdown_inline"] = { fg = colors.base.magenta, italic = false }, --Bold
						["@markup.list.checked.markdown"] = { fg = colors.base.red, italic = false }, --Checked
					}
				end,
			})
			vim.cmd("colorscheme monokai-pro")
		end,
	},
}
