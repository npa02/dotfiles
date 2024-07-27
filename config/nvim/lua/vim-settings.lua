-- VIM commands :help :map-modes
-- https://stackoverflow.com/a/3776182/11397588
vim.cmd([[
    " Map <jk> to <ESC> in all modes except normal mode
    inoremap jk <ESC>
    vnoremap jk <ESC>
    cnoremap jk <ESC>
    onoremap jk <ESC>
    tnoremap jk <ESC>
]])

-- [[ Setting options ]]
-- See `:help vim.o`
-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Set highlight on search
vim.opt.hlsearch = false
-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
-- Enable mouse mode
vim.opt.mouse = "a"
-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"
-- Enable break indent
vim.o.breakindent = true
-- Enable wrap for line too
vim.opt.wrap = true
-- Save undo history
vim.o.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"
-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- Tab spacing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- disable netrw at the start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Transparent background ]]
-- vim.cmd([[
--   highlight Normal guibg=none
--   highlight signcolumn guibg=none
-- ]])
