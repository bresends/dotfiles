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

local function date_after(days)
	return os.date("%Y-%m-%d", os.time() + (days * 24 * 60 * 60))
end

local function update_review_frontmatter(days)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	if lines[1] ~= "---" then
		vim.notify("Current note has no YAML frontmatter", vim.log.levels.WARN)
		return
	end

	local frontmatter_end
	for i = 2, #lines do
		if lines[i] == "---" then
			frontmatter_end = i
			break
		end
	end

	if not frontmatter_end then
		vim.notify("YAML frontmatter is not closed", vim.log.levels.WARN)
		return
	end

	local today = os.date("%Y-%m-%d")
	local next_review = date_after(days)
	local review_count = 0
	local found = {
		lastReview = false,
		nextReview = false,
		reviewCount = false,
	}

	for i = 2, frontmatter_end - 1 do
		local count = lines[i]:match("^reviewCount:%s*(%d+)")
		if count then
			review_count = tonumber(count) or 0
		end
	end

	for i = 2, frontmatter_end - 1 do
		if lines[i]:match("^lastReview:%s*") then
			lines[i] = "lastReview: " .. today
			found.lastReview = true
		elseif lines[i]:match("^nextReview:%s*") then
			lines[i] = "nextReview: " .. next_review
			found.nextReview = true
		elseif lines[i]:match("^reviewCount:%s*") then
			lines[i] = "reviewCount: " .. (review_count + 1)
			found.reviewCount = true
		end
	end

	local missing = {}
	if not found.lastReview then
		table.insert(missing, "lastReview: " .. today)
	end
	if not found.nextReview then
		table.insert(missing, "nextReview: " .. next_review)
	end
	if not found.reviewCount then
		table.insert(missing, "reviewCount: " .. (review_count + 1))
	end

	for i = #missing, 1, -1 do
		table.insert(lines, frontmatter_end, missing[i])
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.cmd.write()
	vim.notify("Review updated: next review in " .. days .. " days", vim.log.levels.INFO)
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

vim.keymap.set("n", "<leader>ru", function()
	local intervals = {
		{ label = "1 semana", days = 7 },
		{ label = "15 dias", days = 15 },
		{ label = "30 dias", days = 30 },
		{ label = "60 dias", days = 60 },
		{ label = "90 dias", days = 90 },
		{ label = "180 dias", days = 180 },
		{ label = "360 dias", days = 360 },
	}

	vim.ui.select(intervals, {
		prompt = "Next review:",
		format_item = function(item)
			return item.label
		end,
	}, function(choice)
		if not choice then
			return
		end

		update_review_frontmatter(choice.days)
	end)
end, { desc = "[R]eview [U]pdate next review date", buffer = true })

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
