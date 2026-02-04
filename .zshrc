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
alias tree='eza --tree --git --group-directories-first --icons'
alias cat='bat'

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
eval "$(zoxide init zsh --cmd cd)"
