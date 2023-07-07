"Vundle compatibility
set nocompatible
filetype off

"set the runtime path to include Vundle and initialize 
set rtp+=~/.vim/bundle/Vundle.vim

"Vundle plugins
call vundle#begin()

"package manager
Plugin 'VundleVim/Vundle.vim'
"syntax highlighting and indentation support
Plugin 'sheerun/vim-polyglot'
"papercolor theme
Plugin 'NLKNguyen/papercolor-theme'
"prettier formatter
Plugin 'prettier/vim-prettier'
"github copilot
Plugin 'github/copilot.vim'
"prisma support
Plugin 'pantharshit00/vim-prisma'

call vundle#end()
filetype indent plugin on

"aesthetic
syntax enable
colorscheme PaperColor 
set background=light
set t_Co=256

"numbering
set fo-=l

"completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c   "shut off completion messages
set belloff+=ctrlg "if Vim beeps during completion

"yanks to system clipboard
"paste with `cmd-v`
set clipboard=unnamed

"scroll when there are 10 rows before bottom or top of screen
set scrolloff=10

"2-space tabs and indents
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

"2-space YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"turn on line numbers
set number

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"where splits occur 
set splitbelow
set splitright

"remove trailing whitespace
fun! TrimWhitespace()
    let l:save=winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

"prettier format on save
let g:prettier#autoformat = 1 
let g:prettier#autoformat_require_pragma = 0

"lsp format on save
autocmd BufWritePre * lua vim.lsp.buf.format()

"copilot keybindings
"ALT-]
inoremap ‘ <Plug>(copilot-next)
"ALT-[
inoremap “ <Plug>(copilot-previous)
"ALT-\
inoremap « <Plug>(copilot-suggest)

"use fzf in vim
set rtp+=/opt/homebrew/opt/fzf


"use our colorscheme for fzf
let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'NormalFloat'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Ignore'],
  \ 'prompt':     ['fg', 'Conditional'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment'] }
