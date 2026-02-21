-- Text wrapping options
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.list = false -- Hide invisible characters (spaces, tabs) for cleaner writing
vim.opt_local.spell = true

-- Spell language
vim.keymap.set("n", "<leader>zen", function()
	vim.opt_local.spelllang = "en"
	vim.notify("Spell language: English")
end, { desc = "[Z] Spell language [En]glish", buffer = true })

vim.keymap.set("n", "<leader>zpt", function()
	vim.opt_local.spelllang = "pt_br"
	vim.notify("Spell language: Português (BR)")
end, { desc = "[Z] Spell language [PT]-BR", buffer = true })

-- Checkbox toggle
vim.keymap.set("n", "<leader>cc", function()
	local line = vim.api.nvim_get_current_line()
	local new_line = line:gsub("^(%s*%- )%[(.-)%]", function(prefix, state)
		return prefix .. (state == " " and "[x]" or "[ ]")
	end)
	vim.api.nvim_set_current_line(new_line)
end, { desc = "Toggle markdown checkbox", buffer = true })
