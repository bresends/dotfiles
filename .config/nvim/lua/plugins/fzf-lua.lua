return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		keymap = {
			fzf = {
				["ctrl-q"] = "select-all+accept", -- add search result to the quickfix list
			},
		},
	},
	keys = {
		{
			"<leader>fb",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "[F]ind [B]uilt-In FuzzyFinder",
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "[F]ind [O]pened files",
		},
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "[F]ind [F]iles in CWD",
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "[F]ind by [G]rep",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = "~/dotfiles" })
			end,
			desc = "[F]ind [C]onfig files",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "[F]ind [R]esume",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[F]ind [H]elp",
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "[F]ind [K]eymaps",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[F]ind current [W]ord",
		},
		{
			"<leader><leader>",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "Find existing buffers",
		},
		{
			"<leader>/",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "[/] Live grep the current buffer",
		},
	},
}
