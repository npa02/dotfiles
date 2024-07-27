require("mason-nvim-lint").setup({
	ensure_installed = { "cpplint", "luacheck", "pylint", "flake8" },
	automatic_installation = true,
	quiet_mode = false,
})
