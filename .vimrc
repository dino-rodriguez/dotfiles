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
"autocompletion
Plugin 'lifepillar/vim-mucomplete'
"language server protocol
Plugin 'prabirshrestha/vim-lsp'
"language server auto configurations
Plugin 'mattn/vim-lsp-settings'
"language server auto complete
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
"papercolor theme
Plugin 'NLKNguyen/papercolor-theme'

call vundle#end()
filetype indent plugin on

"line length and numbering
set textwidth=80
set fo-=l

"completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c   "shut off completion messages
set belloff+=ctrlg "if Vim beeps during completion

"enable automatic completion at startup
let g:mucomplete#enable_auto_at_startup = 1

"yanks to system clipboard
"paste with `cmd-v`
set clipboard=unnamed

"scroll when there are 10 rows before bottom or top of screen
set scrolloff=10

"highlight all matching phrases on search
set hlsearch

"wrap markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

"2-space tabs and indents
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

"2-space YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"aesthetic
syntax enable
colorscheme PaperColor 
set background=dark
set t_Co=256

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
