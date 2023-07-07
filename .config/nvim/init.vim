"Source vim config
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

"Source neovim plugins
lua require('plugins')
lua require('init')

"Automically compile plugins on update to plugins.lua
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

"Trouble keybindings
nnoremap <leader>xx <cmd>TroubleToggle<cr>
