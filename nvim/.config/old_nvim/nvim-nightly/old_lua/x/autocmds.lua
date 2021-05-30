local set_augroup = require 'x.utils'.set_augroup

-- -- Statusline/Tabline highlights
-- set_augroup('statusline_tabline_hl', {
--   [[au ColorScheme * lua require 'x.statusline'.set_highlights()]],
--   [[au ColorScheme * lua require 'x.tabline'.set_highlights()]]
-- })

-- -- Statusline render
-- set_augroup('statusline_local', {
--   [[au WinEnter,BufEnter * lua require 'x.statusline'.setlocal_active_statusline()]],
--   [[au WinLeave * lua require 'x.statusline'.setlocal_inactive_statusline()]]
-- })

 -- Hide invisible chars in help and telescope
set_augroup('nolist_by_ft', {
  [[au FileType help setlocal nolist]],
  [[au FileType TelescopePrompt setlocal nolist]]
})

-- Exit file explorer
set_augroup('netrw_exit',{ 'au FileType netrw nnoremap <buffer> <Esc> <cmd>Rex<CR>' })

-- lua 2 space indent
set_augroup('lua_indent', { 'au FileType lua setlocal tabstop=2' })

-- nvim biscuits
set_augroup('biscuits_hl', { 'au ColorScheme * hi BiscuitColor guifg=#444444 gui=italic' })
