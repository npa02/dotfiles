-- Here is where you install your plugins.
require("lazy").setup({
	-- Nerd fonts
	"nvim-tree/nvim-web-devicons",
	{ -- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	-- Git releated signs on the left gutter, utilities for managing changes
	"lewis6991/gitsigns.nvim",

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- Show you pending keybinds
	"folke/which-key.nvim",

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim", opts = {}, tag = "legacy" },
			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},

	-- An asynchronous linter plugin
	"mfussenegger/nvim-lint",
	"rshkarin/mason-nvim-lint",

	-- Formatter managers plugin
	"stevearc/conform.nvim",

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
			},

			-- autopairing of (){}[] etc
			"windwp/nvim-autopairs",

			{ -- cmp sources plugins
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},
	},

	-- Set lualine as statusline
	"nvim-lualine/lualine.nvim",

	-- Add indentation guides even on blank lines
	"lukas-reineke/indent-blankline.nvim",

	-- comment visual regions/lines
	"numToStr/Comment.nvim",

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},

	-- terminal plugin
	"NvChad/nvterm",

	-- Customizable greeter for neovim
	"goolord/alpha-nvim",

	{ -- Markdown preview
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},

	-- Markdown TOC
	"mzlogin/vim-markdown-toc",

	-- Symbols Outline
	"simrat39/symbols-outline.nvim",

	-- A file explorer
	-- "nvim-tree/nvim-tree.lua",
})
