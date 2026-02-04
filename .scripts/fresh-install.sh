#!/bin/bash
#
# fresh-install.sh
# macOS setup script for a new machine
#
# Usage: chmod +x fresh-install.sh && ./fresh-install.sh

set -e  # Exit on error

# ------------------------------------------------------------------------------
# Homebrew - Package manager for macOS
# https://github.com/Homebrew/brew
# ------------------------------------------------------------------------------
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed, updating..."
    brew update
fi

# ------------------------------------------------------------------------------
# GUI Applications (Casks)
# ------------------------------------------------------------------------------

# Ghostty - Fast, native terminal emulator
# https://github.com/ghostty-org/ghostty
brew install --cask ghostty

# ------------------------------------------------------------------------------
# CLI Tools
# ------------------------------------------------------------------------------

# Starship - Minimal, fast, customizable shell prompt
# https://github.com/starship/starship
brew install starship

# Zoxide - Smarter cd command (tracks frequently used directories)
# https://github.com/ajeetdsouza/zoxide
brew install zoxide

# fzf - Command-line fuzzy finder
# https://github.com/junegunn/fzf
brew install fzf

# eza - Modern replacement for ls
# https://github.com/eza-community/eza
brew install eza

# ripgrep - Fast grep alternative (rg)
# https://github.com/BurntSushi/ripgrep
brew install ripgrep

# fd - Simple, fast find alternative
# https://github.com/sharkdp/fd
brew install fd

# vivid - LS_COLORS generator
# https://github.com/sharkdp/vivid
brew install vivid

# jq - Command-line JSON processor
# https://github.com/jqlang/jq
brew install jq

# HTTPie - User-friendly HTTP client
# https://github.com/httpie/cli
brew install httpie

# bat - cat clone with syntax highlighting
# https://github.com/sharkdp/bat
brew install bat

# Volta - JavaScript toolchain manager (Node.js, npm, etc.)
# https://github.com/volta-cli/volta
brew install volta

# uv - Fast Python package installer and resolver
# https://github.com/astral-sh/uv
brew install uv

# tlrc - tldr client in Rust (simplified man pages)
# https://github.com/tldr-pages/tlrc
brew install tlrc

# delta - Syntax-highlighting pager for git diffs
# https://github.com/dandavison/delta
brew install git-delta
