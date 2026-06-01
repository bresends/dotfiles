-- TSX filetype configuration
-- Loaded automatically when opening a .tsx file

-- Style TSX property identifiers as Monokai Pro MediumPurple
vim.api.nvim_set_hl(0, "@variable.member.tsx", { fg = "#ab9df2", force = true })

-- Unified tag selection helper (self-closing or normal tags)
local function select_tag_or_self_closing()
	local node = vim.treesitter.get_node()
	while node do
		if node:type() == "jsx_self_closing_element" then
			local start_row, start_col, end_row, end_col = node:range()
			-- If already in visual mode, exit it first to prevent toggling it off
			local mode = vim.api.nvim_get_mode().mode
			if mode:find("^[vV]") or mode == " " then
				vim.cmd("normal! \x1b")
			end
			-- Select the self-closing tag
			vim.fn.setpos(".", { 0, start_row + 1, start_col + 1, 0 })
			vim.cmd("normal! v")
			vim.fn.setpos(".", { 0, end_row + 1, end_col, 0 })
			return
		end
		node = node:parent()
	end
	-- Fallback to default Neovim 'at' motion (using "n" flag to prevent infinite recursion)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("at", true, false, true), "n", false)
end

-- Bind to 'at' for both Visual (x) and Operator-pending (o) modes
vim.keymap.set({ "x", "o" }, "at", select_tag_or_self_closing, { buffer = true, desc = "Select tag" })
