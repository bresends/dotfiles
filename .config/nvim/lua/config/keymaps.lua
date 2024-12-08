vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Lua Execution Shortcuts
vim.keymap.set("n", "<leader><leader>x", "<cmd>source % | echo 'Sourced current file!'<CR>")
vim.keymap.set("v", "<leader><leader>x", ":lua<CR>")

-- Shared Clipboard Shortcuts
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]]) -- copy to system clipboard
vim.keymap.set({ "n", "x" }, "<leader>p", [["+P]]) -- paste from system clipboard
vim.keymap.set({ "n", "x" }, "<leader>d", [["+d]]) -- cut from system clipboard

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
