vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap.set

-- Write file
keymap("n", "<leader>w", "<cmd>w<CR>")

-- Escape with jk
keymap("i", "jk", "<ESC>", { nowait = true, desc = "Escape insert mode" })

-- Move lines in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Navigation
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up half-page" })
keymap("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page" })
keymap("i", "<M-h>", "<Left>", { desc = "move left" })
keymap("i", "<M-l>", "<Right>", { desc = "move right" })

-- Lua Execution Shortcuts
keymap(
	"n",
	"<leader><leader>x",
	"<cmd>source % | echo 'Sourced current file!'<CR>",
	{ desc = "Source the current file " }
)
keymap("v", "<leader><leader>x", ":lua<CR>", { desc = "Execute selected Lua code" })

-- Shared Clipboard Shortcuts
keymap({ "n", "x" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
keymap({ "n", "x" }, "<leader>p", [["+P]], { desc = "Paste from the system clipboard" })
keymap({ "n", "x" }, "<leader>d", [["+d]], { desc = "Cut to system clipboard" })
keymap("n", "<Leader>yf", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- Lazy
keymap("n", "<Leader>lu", "<cmd>Lazy update<CR>", { desc = "Update Plugins" })

-- Diagnostic keymaps
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- LSP
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP - Rename Symbol" })
keymap("n", "<leader>.", vim.lsp.buf.code_action, { desc = "LSP - Code actions" })
keymap("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP - Go to the definition" })
keymap("n", "<leader>gr", vim.lsp.buf.references, { desc = "LSP - Show all references " })
keymap("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP - Go to the implementation" })
keymap("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "LSP - List all symbols in the current buffer" })
keymap("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP - Show signature help for the function being typed" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
