return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			sections = {
				lualine_c = {
					{
						function()
							local file = vim.fn.expand("%:p")
							if file == "" then
								return "[No Name]"
							end
							local filename = vim.fn.fnamemodify(file, ":t")
							local parent = vim.fn.fnamemodify(file, ":h:t")
							return " " .. parent .. "/" .. filename
						end,
						color = { fg = "#c1c0c0" },
					},
				},
			},
		},
	},
}
