vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Write file
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")

-- Escape with jk
vim.keymap.set("i", "jk", "<ESC>", { nowait = true, desc = "Escape insert mode" })

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Lua Execution Shortcuts
vim.keymap.set(
	"n",
	"<leader><leader>x",
	"<cmd>source % | echo 'Sourced current file!'<CR>",
	{ desc = "Source the current file " }
)
vim.keymap.set("v", "<leader><leader>x", ":lua<CR>", { desc = "Execute selected Lua code" })

-- Shared Clipboard Shortcuts
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", [["+P]], { desc = "Paste from the system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>d", [["+d]], { desc = "Cut to system clipboard" })
vim.keymap.set("n", "<Leader>yf", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- Lazy
vim.keymap.set("n", "<Leader>lu", "<cmd>Lazy update<CR>", { desc = "Update Plugins" })

-- LSP
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP - Rename Symbol" })
vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "LSP - Code actions" })
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP - Go to the definition" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "LSP - Show all references " })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP - Go to the implementation" })
vim.keymap.set(
	"n",
	"<leader>ds",
	vim.lsp.buf.document_symbol,
	{ desc = "LSP - List all symbols in the current buffer" }
)
vim.keymap.set(
	"i",
	"<C-k>",
	vim.lsp.buf.signature_help,
	{ desc = "LSP - Show signature help for the function being typed" }
)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
