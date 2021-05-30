local keymap = require 'x.utils'.keymap

-- Leader
vim.g.mapleader = ' '

-- Save, quit
keymap('n', '<C-s>', '<cmd>w<CR>')
keymap('n', '<C-q>', '<cmd>q<CR>')
keymap('i', '<C-s>', '<C-o><cmd>w<CR>')
keymap('i', '<C-q>', '<C-o><cmd>q<CR>')

-- Map escape from terminal input to Normal mode
keymap('t', '<ESC>', [[<C-\><C-n>]])
keymap('t', '<C-[>', [[<C-\><C-n>]])

-- File explorer
keymap('n', '<leader>n', '<cmd>NnnPicker<CR>')

-- Omnifunc
keymap('i', '<C-Space>', '<C-x><C-o>')

-- Disable highlights
keymap('n', '<leader> ', '<cmd>noh<CR>')

-- Buffer maps
-- -----------
keymap('n', '<C-b>',     [[<cmd>lua require'x.plugins.telescope'.buffers()<CR>]])
keymap('n', '<C-l>',     [[:bn<CR>]])
keymap('n', '<C-h>',     [[:bp<CR>]])
keymap('n', '<leader>;', [[:b#<CR>]])
keymap('n', '<leader>x', [[:bd<CR>]])

-- Macro maps
-- -----------
keymap('n', '<leader>r', '@q')
keymap('v', '<leader>r', ':normal @q<CR>')

-- Text maps
-- ---------
-- Move a line of text Alt+[j/k]
keymap('n', '<M-j>', [[mz:m+<CR>`z]])
keymap('n', '<M-k>', [[mz:m-2<CR>`z]])
keymap('v', '<M-j>', [[:m'>+<CR>`<my`>mzgv`yo`z]])
keymap('v', '<M-k>', [[:m'<-2<CR>`>my`<mzgv`yo`z]])

-- Copy paste maps
-- ---------
keymap('v', '<C-c>', [["+y]])
keymap('n', '<C-o>', [["+p<CR>]])

keymap('i', '<C-v>', [[<Esc>"+p]])
keymap('n', '<leader>p', [["*p]])
keymap('v', '<leader>p', [["*p]])

-- Reload file
keymap('n', '<leader>r', '<cmd>edit!<CR>')

-- Telescope
keymap('n', '<C-p>', [[<cmd>lua require'x.plugins.telescope'.find_files()<CR>]])
keymap('n', '<C-t>', [[<cmd>lua require'x.plugins.telescope'.live_grep()<CR>]])
keymap('n', '<leader>vf', [[<cmd>lua require'x.plugins.telescope'.find_config_files()<CR>]])
