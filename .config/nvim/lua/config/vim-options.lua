-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Decrease update time
vim.opt.updatetime = 250

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true -- keep indentation when the line wraps

-- Search
vim.opt.hlsearch = false -- no highlight after search
vim.opt.incsearch = true
vim.opt.ignorecase = true -- search plugins with lowercase

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Highlight current line
vim.opt.cursorline = true

-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true -- Keep undo history from closed sessions

-- Visual block mode
vim.opt.virtualedit = "block" -- Allow to select any region with Visual Block mode

-- Visuals
vim.opt.termguicolors = true
