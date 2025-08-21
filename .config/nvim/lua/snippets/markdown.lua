local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
	s("execution", {
		t("- [ ] "),
		f(function()
			return os.date("%d/%m/%Y")
		end),
		t(" - "),
		i(1, "task"),
	}),
}

