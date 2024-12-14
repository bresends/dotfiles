-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false -- no highlight after search
vim.opt.incsearch = true
vim.opt.ignorecase = true -- search plugins with lowercase

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true -- Keep undo history from closed sessions

-- Visual block mode
vim.opt.virtualedit = "block" -- Allow to select any region with Visual Block mode

-- Visuals
vim.opt.termguicolors = true
