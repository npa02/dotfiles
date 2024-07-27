-- [[ Configure nvterm ]]
require("nvterm").setup({
	terminals = {
		shell = vim.o.shell,
		list = {},
		type_opts = {
			float = {
				relative = "editor",
				row = 0.14,
				col = 0.14,
				width = 0.72,
				height = 0.72,
				border = "single",
			},
			horizontal = {
				location = "rightbelow",
				split_ratio = 0.27,
			},
			vertical = {
				location = "rightbelow",
				split_ratio = 0.5,
			},
		},
	},
	behavior = {
		autoclose_on_quit = {
			enabled = false,
			confirm = true,
		},
		close_on_exit = true,
		auto_insert = true,
	},
})

-- Hotkeys
local nvterm = require("nvterm.terminal")
local toggle_modes = { "n", "t" }
local opts = { noremap = true, silent = true }
local mappings = {
	{
		toggle_modes,
		"<A-h>",
		function()
			nvterm.toggle("horizontal")
		end,
		desc = "[H]orizontal terminal",
	},
	{
		toggle_modes,
		"<A-f>",
		function()
			nvterm.toggle("float")
		end,
		desc = "[F]loating terminal",
	},
	-- { toggle_modes, '<A-v>', function () nvterm.toggle('vertical') end, desc = '[F]loating terminal' },
}
for _, mapping in ipairs(mappings) do
	vim.keymap.set(mapping[1], mapping[2], mapping[3], opts, mapping[4])
end
