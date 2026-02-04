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
if [ -d "/Applications/Ghostty.app" ]; then
    echo "Ghostty already installed, skipping..."
else
    echo "Installing Ghostty..."
    brew install --cask ghostty
fi

# ------------------------------------------------------------------------------
# CLI Tools
# ------------------------------------------------------------------------------

# Starship - Minimal, fast, customizable shell prompt
# https://github.com/starship/starship
if brew list starship &> /dev/null; then
    echo "Starship already installed, skipping..."
else
    echo "Installing Starship..."
    brew install starship
fi

# Zoxide - Smarter cd command (tracks frequently used directories)
# https://github.com/ajeetdsouza/zoxide
if brew list zoxide &> /dev/null; then
    echo "Zoxide already installed, skipping..."
else
    echo "Installing Zoxide..."
    brew install zoxide
fi

# fzf - Command-line fuzzy finder
# https://github.com/junegunn/fzf
if brew list fzf &> /dev/null; then
    echo "fzf already installed, skipping..."
else
    echo "Installing fzf..."
    brew install fzf
fi

# eza - Modern replacement for ls
# https://github.com/eza-community/eza
if brew list eza &> /dev/null; then
    echo "eza already installed, skipping..."
else
    echo "Installing eza..."
    brew install eza
fi

# ripgrep - Fast grep alternative (rg)
# https://github.com/BurntSushi/ripgrep
if brew list ripgrep &> /dev/null; then
    echo "ripgrep already installed, skipping..."
else
    echo "Installing ripgrep..."
    brew install ripgrep
fi

# fd - Simple, fast find alternative
# https://github.com/sharkdp/fd
if brew list fd &> /dev/null; then
    echo "fd already installed, skipping..."
else
    echo "Installing fd..."
    brew install fd
fi

# vivid - LS_COLORS generator
# https://github.com/sharkdp/vivid
if brew list vivid &> /dev/null; then
    echo "vivid already installed, skipping..."
else
    echo "Installing vivid..."
    brew install vivid
fi

# jq - Command-line JSON processor
# https://github.com/jqlang/jq
if brew list jq &> /dev/null; then
    echo "jq already installed, skipping..."
else
    echo "Installing jq..."
    brew install jq
fi

# HTTPie - User-friendly HTTP client
# https://github.com/httpie/cli
if brew list httpie &> /dev/null; then
    echo "HTTPie already installed, skipping..."
else
    echo "Installing HTTPie..."
    brew install httpie
fi

# bat - cat clone with syntax highlighting
# https://github.com/sharkdp/bat
if brew list bat &> /dev/null; then
    echo "bat already installed, skipping..."
else
    echo "Installing bat..."
    brew install bat
fi

# Volta - JavaScript toolchain manager (Node.js, npm, etc.)
# https://github.com/volta-cli/volta
if brew list volta &> /dev/null; then
    echo "Volta already installed, skipping..."
else
    echo "Installing Volta..."
    brew install volta
fi

# uv - Fast Python package installer and resolver
# https://github.com/astral-sh/uv
if brew list uv &> /dev/null; then
    echo "uv already installed, skipping..."
else
    echo "Installing uv..."
    brew install uv
fi

# tlrc - tldr client in Rust (simplified man pages)
# https://github.com/tldr-pages/tlrc
if brew list tlrc &> /dev/null; then
    echo "tlrc already installed, skipping..."
else
    echo "Installing tlrc..."
    brew install tlrc
fi

# delta - Syntax-highlighting pager for git diffs
# https://github.com/dandavison/delta
if brew list git-delta &> /dev/null; then
    echo "git-delta already installed, skipping..."
else
    echo "Installing git-delta..."
    brew install git-delta
fi

# wget - Command-line utility for downloading files
# https://www.gnu.org/software/wget/
if brew list wget &> /dev/null; then
    echo "wget already installed, skipping..."
else
    echo "Installing wget..."
    brew install wget
fi

# Neovim - Modern, extensible Vim-based text editor
# https://github.com/neovim/neovim
if brew list neovim &> /dev/null; then
    echo "Neovim already installed, skipping..."
else
    echo "Installing Neovim..."
    brew install neovim
fi
