"Source neovim plugins & Lua config
lua require('plugins')
lua require('init')

"
"General Settings
"

"Turn on detection, plugin, indent
filetype indent plugin on

"Theme
syntax enable
colorscheme apprentice 
set background=dark
set t_Co=256

"Does not break long lines with word wrap
set fo-=l

"Completion options
set completeopt=menuone,noinsert,noselect
set shortmess+=c   "shut off completion messages
set belloff+=ctrlg "if Vim beeps during completion

"Yanks to system clipboard
"Paste with `cmd-v`
set clipboard=unnamed

"Scroll when there are 10 rows before bottom or top of screen
set scrolloff=10

"Turn on line numbers
set number

"Where splits occur 
set splitbelow
set splitright

"Use fzf in vim
set rtp+=/opt/homebrew/opt/fzf

"Use our colorscheme for fzf
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


"
"Formatting
"

"2-space tabs and indents
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

"2-space YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"Neoformat should use project local version of prettier
let g:neoformat_try_node_exe = 1

"Run all enabled formatters, instead of just the first
let g:neoformat_run_all_formatters = 1

"Enabled formatters
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:neoformat_enabled_javascriptreact = ['prettier']

"LSP format on save
augroup FormatOnSave
  autocmd!
  autocmd FileType javascript Neoformat
  autocmd FileType typescript Neoformat
  autocmd FileType yaml Neoformat
  autocmd FileType typescriptreact Neoformat
  autocmd FileType javascriptreact Neoformat
augroup END


"
"Functions
"

"Automically compile plugins on update to plugins.lua
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end


"Remove trailing whitespace on save
fun! TrimWhitespace()
    let l:save=winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

"
"Keybindings
"

"Copilot keybindings
"ALT-]
inoremap ‘ <Plug>(copilot-next)
"ALT-[
inoremap “ <Plug>(copilot-previous)
"ALT-\
inoremap « <Plug>(copilot-suggest)

"Split navigation keybindings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Trouble keybindings
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
