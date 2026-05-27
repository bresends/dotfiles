-- ============================================================================
-- BASIC KEYMAPS
-- ============================================================================

-- FILE EXECUTION & RELOAD
vim.keymap.set(
	"n",
	"<leader>rr",
	'<cmd>source % | echo "Sourced current file!"<CR>',
	{ desc = "Source the current file" }
)
vim.keymap.set("v", "<leader>rx", ":lua<CR>", { desc = "Execute selected Lua code" })

-- SEARCH & NAVIGATION
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- EDITING & TEXT MANIPULATION
vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set({ "n", "v" }, "C", '"_C')
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste and keep yanked text" })
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write buffer" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("i", "<M-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<M-l>", "<Right>", { desc = "Move right" })

-- LINE & SELECTION MOVEMENT
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================

-- Window splitting
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })

-- Window resizing
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- ============================================================================
-- TAB MANAGEMENT
-- ============================================================================

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Quit current tab" })
vim.keymap.set("n", "<S-l>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<S-h>", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open curren buffer in new tab" })

-- ============================================================================
-- FILE OPERATIONS
-- ============================================================================

-- Copy full file path for the current file
vim.keymap.set("n", "<leader>fp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

-- ============================================================================
-- NOTES
-- ============================================================================

local function parse_review_entry(file, today)
	local handle = io.open(file, "r")
	if not handle then
		return
	end

	local first_line = handle:read("*l")
	if not (first_line and first_line:match("^---$")) then
		handle:close()
		return
	end

	local next_review, review_count

	for line in handle:lines() do
		if line:match("^---$") then
			break
		end

		local review_date = line:match("^nextReview:%s*(.+)")
		if review_date then
			next_review = review_date:sub(1, 10)
		end

		local count = line:match("^reviewCount:%s*(%d+)")
		if count then
			review_count = count
		end
	end
	handle:close()

	local is_due = next_review and next_review <= today

	if not is_due then
		return
	end

	local due = next_review:sub(9, 10) .. "-" .. next_review:sub(6, 7) .. "-" .. next_review:sub(1, 4)
	return {
		display = "Reviews: " .. (review_count or "0") .. " | Due: " .. due .. " | " .. file,
		path = file,
	}
end

vim.keymap.set("n", "<leader>rw", function()
	local today = os.date("%Y-%m-%d")
	local entries = {}

	for _, file in ipairs(vim.fn.glob("**/*.md", false, true)) do
		local entry = parse_review_entry(file, today)
		if entry then
			table.insert(entries, entry)
		end
	end

	if #entries == 0 then
		vim.notify("No notes due for review", vim.log.levels.INFO)
		return
	end

	require("fzf-lua").fzf_exec(
		vim.tbl_map(function(e)
			return e.display
		end, entries),
		{
			prompt = "Reviews> ",
			actions = {
				["default"] = function(selected)
					if not selected[1] then
						return
					end
					local path = selected[1]:match("| ([^|]+)$")
					if path then
						vim.cmd("edit " .. vim.fn.fnameescape(vim.trim(path)))
					end
				end,
			},
		}
	)
end, { desc = "[F]ind notes due for [R]eview" })
