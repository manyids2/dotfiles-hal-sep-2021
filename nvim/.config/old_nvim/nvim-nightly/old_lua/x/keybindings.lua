local keymap = require 'x.utils'.keymap

-- Leader
vim.g.mapleader = ' '

-- Unbind default bindings for arrow keys, trust me this is for your own good
keymap('v', '<up>',    '<nop>')
keymap('v', '<down>',  '<nop>')
keymap('v', '<left>',  '<nop>')
keymap('v', '<right>', '<nop>')

keymap('i', '<up>',    '<nop>')
keymap('i', '<down>',  '<nop>')
keymap('i', '<left>',  '<nop>')
keymap('i', '<right>', '<nop>')

-- Map Esc, to perform quick switching between Normal and Insert mode
keymap('i', 'jk', '<ESC>')

-- Map escape from terminal input to Normal mode
keymap('t', '<ESC>', [[<C-\><C-n>]])
keymap('t', '<C-[>', [[<C-\><C-n>]])

-- Copy/Paste from the system clipboard
-- Use at your own risk
-- keymap('v', '<C-i>', [["+y<CR>]])
-- keymap('n', '<C-o>', [["+p<CR>]])

-- File explorer
keymap('n', '<F3>', '<cmd>Ex<CR>')

-- Omnifunc
keymap('i', '<C-Space>', '<C-x><C-o>')

-- Disable highlights
keymap('n', '<leader><CR>', '<cmd>noh<CR>')

-- Buffer maps
-- -----------
-- List all buffers
keymap('n', '<leader>ba', '<cmd>buffers<CR>')
-- Next buffer
keymap('n', '<C-l>',      '<cmd>bnext<CR>')
-- Previous buffer
keymap('n', '<C-h>',      '<cmd>bprevious<CR>')
-- Close buffer, and more?
keymap('n', '<leader>bd', '<cmd>bp<BAR>sp<BAR>bn<BAR>bd<CR>')

-- Resize window panes, we can use those arrow keys
-- to help use resize windows - at least we give them some purpose
keymap('n', '<up>',    '<cmd>resize +2<CR>')
keymap('n', '<down>',  '<cmd>resize -2<CR>')
keymap('n', '<left>',  '<cmd>vertical resize -2<CR>')
keymap('n', '<right>', '<cmd>vertical resize +2<CR>')

-- Text maps
-- ---------
-- Move a line of text Alt+[j/k]
keymap('n', '<M-j>', [[mz:m+<CR>`z]])
keymap('n', '<M-k>', [[mz:m-2<CR>`z]])
keymap('v', '<M-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]])
keymap('v', '<M-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]])

-- Reload file
keymap('n', '<leader>r', '<cmd>edit!<CR>')

-- Reload config
keymap('n', '<leader>vs', '<cmd>ConfigReload<CR><cmd>noh<CR><cmd>EditorConfigReload<CR>')

-- Telescope
keymap('n', '<C-p>', [[<cmd>lua require'x.plugins.config.telescope'.find_files()<CR>]])
keymap('n', '<C-t>', [[<cmd>lua require'x.plugins.config.telescope'.live_grep()<CR>]])
keymap('n', '<leader>vf', [[<cmd>lua require'x.plugins.config.telescope'.find_config_files()<CR>]])
