local M = {}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "update crates"
    }
  }
}

M.general = {
  n = {
    ["<leader>pv"] = { "<cmd> bd <CR>", "close file" },
    ["<leader>pf"] = {"<cmd> Telescope <CR>", "Telescope Files"},
    ["<leader>s"] = { "<cmd> w <CR>", "Save and format"},
  },
  v = {
    ["J"] = {":m '>+1<CR>gv=gv", "Move line Down"},
    ["K"] = {":m '<-2<CR>gv=gv", "Move line Up"},
    [">"] = { ">gv", "indent"},

  },
  i = {
    ["Left"] = {":echoe 'Use h'"},
    ["<Up>"] = {"<Nop>", "Disable Up Arrow"},
    ["<Down>"] = {"<Nop>", "Disable Down Arrow"},
    ["<Left>"] = {"<Nop>", "Disable Left Arrow"},
    ["<Right>"] = {"<Nop>", "Disable Right Arrow"},
    ["jk"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
  }
}

return M
