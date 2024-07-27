require("Comment").setup({})

--[[ KEY BINDINGS
NORMAL MODE
`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
`gcc` - Toggles the current line using linewise comment
`gbc` - Toggles the current line using blockwise comment
`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise

VISUAL MODE
`gc` - Toggles the region using linewise comment
`gb` - Toggles the region using blockwise comment

EXTRA MAPPINGS
`gco` - Insert comment to the next line and enters INSERT mode
`gcO` - Insert comment to the previous line and enters INSERT mode
`gcA` - Insert comment to end of the current line and enters INSERT mode

# Linewise
`gcw` - Toggle from the current cursor position to the next word
`gc$` - Toggle from the current cursor position to the end of line
`gc}` - Toggle until the next blank line
`gcip` - Toggle inside of paragraph
`gca}` - Toggle around curly brackets

# Blockwise
`gb2}` - Toggle until the 2 next blank line
`gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
`gbac` - Toggle comment around a class (w/ LSP/treesitter support) ]]
