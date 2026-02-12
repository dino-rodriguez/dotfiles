#
# History
#

HISTFILE=~/.zsh_history
HISTSIZE=10000          # lines kept in memory per session
SAVEHIST=100000         # lines kept in the history file

setopt INC_APPEND_HISTORY   # write to file immediately, not on exit
setopt HIST_IGNORE_DUPS     # skip consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS # remove older duplicate from file
setopt HIST_REDUCE_BLANKS   # trim extra whitespace
setopt HIST_IGNORE_SPACE    # prefix with space to exclude from history
setopt SHARE_HISTORY        # share history across all open tabs

#
# Path
#

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

#
# Functions
#

aws_profile() {
  if [ -z "$1" ]; then
    # No arguments - show current profile
    echo "Current AWS_PROFILE: ${AWS_PROFILE:-not set}"
    return 0
  elif [ "$1" = "set" ]; then
    # Set profile
    if [ -z "$2" ]; then
      echo "Usage: aws_profile set <profile-name>"
      return 1
    fi
    export AWS_PROFILE="$2"
    echo "AWS_PROFILE set to: $AWS_PROFILE"
  else
    echo "Usage:"
    echo "  aws_profile              - Show current profile"
    echo "  aws_profile set <name>   - Set profile to <name>"
    return 1
  fi
}

#
# Aliases
#

alias ls='eza --git --group-directories-first --icons'
alias ll='eza -l --header --git --group-directories-first --icons'
alias la='eza -la --header --git --group-directories-first --icons'
alias cd='z'
alias cdi='zi'
alias tree='eza --tree --git --group-directories-first --icons'
alias cat='bat'
alias ollama='ollama 2> >(grep -v "^MLX:" >&2)'

#
# Completions
#

fpath=(~/.zfunc /Users/dino/.docker/completions /opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

#
# Interactive Tools
#

source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

#
# Appearance
#

# Re-source .zshenv when macOS appearance changes (light/dark)
_update_appearance() {
  local current
  if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
    current="dark"
  else
    current="light"
  fi
  [[ "$current" == "$__appearance" ]] && return
  __appearance="$current"
  source ~/.zshenv
  eval "$(starship init zsh)"
}
precmd_functions+=(_update_appearance)

#
# Keybindings
#

# fzf: rebind cd widget from Option+C to Ctrl+G
bindkey -r '\ec'
bindkey '^G' fzf-cd-widget
