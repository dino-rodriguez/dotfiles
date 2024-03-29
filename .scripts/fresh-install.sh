#!/bin/zsh
# 
# Fresh install script for basic dev apps (and mac apps).
#

cd $HOME 

# general - settings
# remove workspace auto-switching
defaults write com.apple.dock workspaces-auto-swoosh -bool NO
killall Dock
# enable repeating keys 
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# brew - cli
read -n "yn?install and homebrew and packages(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/dino/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"

  brew install git
  git config --global user.name "Dino Rodriguez"
  git config --global user.email "dinoorodriguez@gmail.com"
  git config --global credential.helper osxkeychain
  git config --global pull.rebase true

  brew install cask
  brew install rg
  brew install fd
  brew install tmux 
  brew install vim
  brew install pyenv
  brew install poetry

  brew install fzf
  /opt/homebrew/opt/fzf/install

  curl https://get.volta.sh | bash
  volta install node 
  npm install -g pyright
  
  pip install python-lsp-server
  pip install ruff
  pip install ruff-lsp
  pip install black
  pip install python-lsp-black
fi

# brew - apps 
read -n "yn?install mac apps(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  brew install --cask iterm2
  brew install --cask spectacle
  brew install --cask docker
  brew install --cask spotify
  brew install --cask notion
  brew install --cask ledger-live
  brew install --cask google-cloud-sdk
fi

# zim
read -n "yn?install zim(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
fi

# dotfiles
read -n "yn?install dotfiles(y/n)? "
if [[ "$yn" == [Yy] ]] ;
then
  echo ".dot" >> .gitignore
  git clone --bare git@github.com:dino-rodriguez/dotfiles.git $HOME/.dot

  alias dot="/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME"
  $dot checkout
  $dot config --local status.showUntrackedFiles no
fi
