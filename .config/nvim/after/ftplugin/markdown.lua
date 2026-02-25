-- Text wrapping options
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.list = false -- Hide invisible characters (spaces, tabs) for cleaner writing
vim.opt_local.spell = true

-- Spaced repetition review picker
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

		local review_date = line:match("^next_review:%s*(.+)")
		if review_date then
			next_review = review_date:sub(1, 10)
		end

		local count = line:match("^review_count:%s*(%d+)")
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
end, { desc = "[F]ind notes due for [R]eview", buffer = true })

vim.keymap.set("n", "<leader>zl", function()
	vim.opt_local.spelllang = { "pt_br", "en" }
	vim.notify("Spell language: Português (BR)")
end, { desc = "[Z] Spell language [EN] and [PT]-BR", buffer = true })

-- Checkbox toggle
vim.keymap.set("n", "<leader>cc", function()
	local line = vim.api.nvim_get_current_line()
	local new_line = line:gsub("^(%s*%- )%[(.-)%]", function(prefix, state)
		return prefix .. (state == " " and "[x]" or "[ ]")
	end)
	vim.api.nvim_set_current_line(new_line)
end, { desc = "Toggle markdown checkbox", buffer = true })
