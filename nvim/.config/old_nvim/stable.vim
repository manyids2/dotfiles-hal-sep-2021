set runtimepath^=/home/x/fd/projects/lsp-server-1/zett-server

" ================ Plugins ==================== {{{
call plug#begin( '~/.config/nvim/bundle')

" config
Plug 'vim-scripts/ReplaceWithRegister'

" objects
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'nelstrom/vim-visual-star-search'
Plug 'Raimondi/delimitMate'

" appearance
Plug 'ryanoasis/vim-devicons'

" colors
Plug 'joshdick/onedark.vim'
Plug 'lucasprag/simpleblack'

" filesearch
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" coc
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', { 'do': 'yarn install --frozen-lockfile' }

" ide
Plug 'junegunn/goyo.vim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'tmhedberg/SimpylFold'
Plug 'masukomi/vim-markdown-folding'

" autocomplete
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
" }}

set encoding=utf8

filetype on
syntax on
" ================ Colors ============== {{{

let g:bold_highlight_groups = ['Function', 'Statement', 'Todo', 'CursorLineNr', 'MatchParen', 'StatusLine']
set showtabline=1
set laststatus=0
set noshowmode
set nonumber

colorscheme onedark
set background=dark

" ================ Turn Off Swap Files ============== {{{
set noswapfile
set nobackup
set nowb
" }}}

" ================ Persistent Undo ================== {{{
" Keep undo history across sessions, by storing in file.
silent !mkdir ~/.config/lvim/backups > /dev/null 2>&1
set undodir=~/.config/lvim/backups
set undofile
" }}}

" ================ Indentation ====================== {{{
set title
set noautochdir
set history=500
set showcmd
set noshowmode
set noshowcmd
set nolazyredraw
set gdefault
set gcr=a:blinkon1000-blinkwait1000-blinkoff1000
set cursorline
set smartcase
set ignorecase
set mouse=a
set showmatch
set nostartofline
set timeoutlen=1000 ttimeoutlen=0
set fileencoding=utf-8
set nowrap
set listchars=tab:\ \ ,trail:·
set list
set hidden
set splitright
set splitbelow
set path+=**
set inccommand=split
set fillchars+=vert:\│
set pumheight=30
set exrc
set secure
set completeopt=menuone,noinsert
" }}}

" ================ Indentation ====================== {{{
set conceallevel=2
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set colorcolumn=0
" }}}

" ================ Completion ======================= {{{
set wildmode=list:full
set wildignore=*.o,*.obj,*~                                                     "stuff to ignore when tab completing
set wildignore+=*.git*
set wildignore+=*.meteor*
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
" }}}


" ================ Functions ====================== {{{
function! StripTrailingWhitespaces()
  if &modifiable
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
  endif
endfunction

function! HideStatusTabBuffer()
  if &l:laststatus ># 0
    set showtabline=0
    set laststatus=0
    set noshowmode
  else
    set showtabline
    set laststatus=2
    set showmode
  endif
endfunction

function! s:Scratch (command, ...)
   redir => lines
   let saveMore = &more
   set nomore
   execute a:command
   redir END
   let &more = saveMore
   call feedkeys("\<cr>")
   new | setlocal buftype=nofile bufhidden=hide noswapfile
   put=lines
   if a:0 > 0
      execute 'vglobal/'.a:1.'/delete'
   endif
   if a:command == 'scriptnames'
      %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
   endif
   silent %substitute/\%^\_s*\n\|\_s*\%$
   let height = line('$') + 3
   execute 'normal! z'.height."\<cr>"
   0
endfunction

command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)

" ================ Auto commands ====================== {{{
augroup vimrc
    autocmd!
augroup END

autocmd vimrc BufWritePre * :call StripTrailingWhitespaces()                    "Auto-remove trailing spaces
autocmd vimrc InsertEnter * :set nocul                                          "Remove cursorline highlight
autocmd vimrc FocusGained,BufEnter * checktime                                  "Refresh file when vim gets focus
" }}}

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ================ Mappings ==================== {{{
let g:mapleader = " "

" Quit, Refresh, Save
nnoremap <leader>gr :source ~/.config/nvim/init.vim<CR>
map <c-s> :w<CR>
imap <c-s> <c-o>:w<CR>

" jumplist
nnoremap <C-l> <C-i>


" Buffer
nnoremap <leader>x :bd<CR>
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>; :b#<CR>

" Macro
nnoremap <leader>r @q
vnoremap <leader>r :normal @q<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Copy to system clipboard
vnoremap <C-c> "+y
vnoremap <Leader>c "*y

" Paste from system clipboard with Ctrl + v
inoremap <C-v> <Esc>"+p
nnoremap <leader>p "*p
vnoremap <leader>p "*p

" Move to the end of yanked text after yank and paste
nnoremap p p`]
vnoremap y y`]
vnoremap p p`]

" Maps for indentation in normal mode
nnoremap <tab> >>
nnoremap <s-tab> <<

" Indenting in visual mode
xnoremap <s-tab> <gv
xnoremap <tab> >gv

" Clear search highlight
nnoremap <leader><space> :noh<CR>

" Center highlighted search
nnoremap n nzz
nnoremap N Nzz

" Toggle buffer list
nnoremap <C-p> :GFiles<CR>
nnoremap <C-q> :q<CR>
nnoremap <Leader>o :copen<CR>
nnoremap <Leader>q :cclose<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>m :History<CR>

" Resize window with shift + and shift -
nnoremap + <c-w>5>
nnoremap _ <c-w>5<

" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-f> :ZoomToggle<CR>
nnoremap <silent> <leader>gZ :<C-u>call HideStatusTabBuffer()<CR>

" wOpen file on cursor in vertical split
" nnoremap gf gf

"Disable ex mode mapping
map Q <Nop>

" Dispatch
nnoremap <leader>gS :silent exec "!./.git/dispatch"<CR>
nnoremap <leader>gs :!./.git/dispatch<CR>
" nnoremap <leader>gt :!typora % &<CR>
nnoremap <leader>gt :r! date<CR>

:nmap <leader>n :CocCommand explorer<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> g<C-space> :CocAction<CR>
nnoremap <silent> K :call CocAction('doHover')<CR>

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>oj <Plug>(coc-bookmark-next)
nmap <leader>ok <Plug>(coc-bookmark-prev)
nmap <leader>ot <Plug>(coc-bookmark-toggle)
nmap <leader>oa <Plug>(coc-bookmark-annotate)

noremap <m-j> :PreviewTag
noremap <m-u> :PreviewScroll -1<cr>
noremap <m-d> :PreviewScroll +1<cr>
inoremap <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <m-d> <c-\><c-o>:PreviewScroll +1<cr>

" }}}

" ================ General Plugins ==================== {{{
let g:python_host_prog = '/home/x/ev/bin/python'
let g:python3_host_prog = '/home/x/ev/bin/python'
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType make setlocal noexpandtab softtabstop=0
autocmd FileType xmenu setlocal noexpandtab softtabstop=0
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 tabstop=2
" }}}

" ================ Snippets ==================== {{{
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


"" ================ tex ======================== {{{
set nocompatible
if has("autocmd")
  filetype plugin indent on
endif

let g:tex_flavor = 'latex'
let g:Tex_MultipleCompileFormats='pdf,bibtex,pdf'
let g:vimtex_compiler_latexmk = {
       \ 'build_dir' : 'build',
       \}
" TOC settings
let g:vimtex_toc_config = {
      \ 'name' : 'TOC',
      \ 'layers' : ['content', 'todo', 'include'],
      \ 'resize' : 1,
      \ 'split_width' : 30,
      \ 'todo_sorted' : 0,
      \ 'show_help' : 1,
      \ 'show_numbers' : 1,
      \ 'mode' : 2,
      \}
let g:Tex_CompileRule_pdf = '.git/dispatch'

"" ================ explorer ======================== {{{
let g:coc_explorer_global_presets = {
\   '.vim': {
\      'root-uri': '~/.config/nvim',
\   },
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

"" ================ vimwiki ======================== {{{
let g:vimwiki_global_ext = 0

let wiki_1 = {}
let wiki_1.path = '/home/x/vimwiki/'
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_list = [wiki_1]

"" ================ pandoc ======================== {{{
let g:pandoc#folding#fastfolds = 1

"" ================ markdown ======================== {{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_math = 1


"" == TEMP STUFF == ""
set list
set listchars=tab:>-

hi Cursor guifg=black guibg=green gui=reverse
set guicursor=a:block-blinkon100-Cursor/Cursor

