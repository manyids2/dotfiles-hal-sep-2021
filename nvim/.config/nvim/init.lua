dofile('/home/x/.config/nvim/lua/x/runtimepaths.lua')

require('x.packerinit')
require('x.options')
require('x.keybindings')
require('x.lspsettings')

vim.cmd('colorscheme neon')
