# Homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# PostgreSQL 16
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@16/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@16/include"


# Bat
export BAT_THEME_DARK="Catppuccin Mocha"
export BAT_THEME_LIGHT="Catppuccin Latte"

# LS_COLORS matched to macOS appearance
if command -v vivid >/dev/null 2>&1; then
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
    # Mocha
    export LS_COLORS="$(vivid generate catppuccin-mocha)"
    export DELTA_FEATURES="catppuccin-mocha"
    export STARSHIP_CONFIG="$HOME/.config/starship/dark.toml"
    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4"
  else
    # Latte
    export LS_COLORS="$(vivid generate catppuccin-latte)"
    export DELTA_FEATURES="catppuccin-latte"
    export STARSHIP_CONFIG="$HOME/.config/starship/light.toml"
    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
    --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
    --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
    --color=selected-bg:#BCC0CC \
    --color=border:#9CA0B0,label:#4C4F69"
  fi
fi
