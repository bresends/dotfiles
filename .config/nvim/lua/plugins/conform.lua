-- NOTE: Formatters are installed via Nix (see nix-config/modules/common/development.nix)
-- and not through Mason, to ensure compatibility with NixOS
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat [M]anually",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			c = { "clang_format" },
			cpp = { "clang_format" },
			lua = { "stylua" },
			-- Conform can also run multiple formatters sequentially
			python = { "ruff_format", "ruff_organize_imports" },
			javascript = { "biome", "biome-organize-imports" },
			javascriptreact = { "biome", "biome-organize-imports" },
			typescript = { "biome", "biome-organize-imports" },
			typescriptreact = { "biome", "biome-organize-imports" },
			markdown = { "prettierd" },
			html = { "prettierd" },
			css = { "prettierd" },
			json = { "fixjson" },
			yaml = { "prettierd" },
			docker = { "prettierd" },
			nix = { "nixfmt" },
		},
	},
}
