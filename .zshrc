#
# Aliases/Commands 
#

# dotfiles (git alias)
alias dot='/usr/bin/git --git-dir=$HOME/.dot/ --work-tree=$HOME'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# git
alias gs='git status'
alias gsh='git stash'
alias gc='git commit'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gpsh='git push'
alias gpshu='git push --set-upstream origin HEAD'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias ga='git add'
alias gd='git diff'
alias gr='git rebase'
alias gcl='git clone'
alias gch='git checkout'
alias gchb='git checkout -b'
alias grp='git remote prune origin'
alias gb='git branch'

# kubernetes
alias k='kubectl'
alias ka='kubectl apply -Rf' 
alias kd='kubectl delete'
alias kg='kubectl get'
alias kl='kubectl logs'
alias kc='kubectl config current-context'
alias kx='kc | cut -d "_" -f 4'
alias ku='kubectl config use-context'

# kubernetes (switch context)
ks() {
  if [[ $(kx) == "prod" ]] ; then
    ku $(kc | cut -d "_" -f 1-3)_staging
  else
    ku $(kc | cut -d "_" -f 1-3)_prod
  fi
}

# ls 
alias la='ls -la'

# python
alias activate='source $(poetry env info | sed -n 5p | cut -d ":" -f 2 | xargs)/bin/activate'

# render markdown to browser
rndr-md() { 
  markdown $1 > $1.html; 
  open $1.html; 
  rm $1.html; 
}

# tmux
alias tx='tmux -2'
alias tn='tmux new -s'
alias ta='tmux a -t'
alias tk='tmux kill-server'
alias tks='tmux kill-session -t'
alias tl='tmux ls'

# tmux 2 pane
tx2() { 
  tmuxn $1 -d;
  tmux split-window -h;
  tmux -2 attach-session -d; 
}

# tmux 3 pane
tx3() { 
  tmuxn $1 -d;
  tmux split-window -h;
  tmux split-window -h;
  tmux select-layout even-horizontal;
  tmux -2 attach-session -d; 
}

# Typescript development set up
# Adapted from : http://ryan.himmelwright.net/post/scripting-tmux-workspaces/
ts-init() {
  # set session name
  SESSION=$1
  SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

  # only create tmux session if it doesn't already exist
  if [ "$SESSIONEXISTS" = "" ]
  then
    # start new session with our name
    tmux new-session -d -s $SESSION

    # zsh window
    tmux rename-window -t 0 'Main'
    tmux send-keys -t 'Main' 'zsh' C-m 'clear' C-m # Switch to bind script?

    # typescript build watch window
    tmux new-window -t $SESSION:1 -n 'Build'
    tmux send-keys -t 'Build' 'yarn run buildWatch' C-m # Switch to bind script?

    # typescript lint watch window
    tmux new-window -t $SESSION:2 -n 'Lint'
    tmux send-keys -t 'Lint' "yarn run lintWatch" C-m

    # typescript test watch window
    tmux new-window -t $SESSION:3 -n 'Test'
    tmux send-keys -t 'Test' "yarn run testWatch" C-m 'clear' C-m
  fi

  # attach session on the main window
  tmux attach-session -t $SESSION:0
}

# util 
alias sz='source ~/.zshrc'
alias timestamp='date -u "+%Y-%m-%dT%H:%M:%S"'

# vim
alias vinstall='vim +PluginInstall +qall'
alias v='vim'


#
# -> Start zsh configuration
#

### Setup

ZIM_HOME=~/.zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

### History

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

### Input/output

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v
# Prompt for spelling correction of commands.
setopt CORRECT
# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


### Module configuration

## completion

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

## git

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
# zstyle ':zim:git' aliases-prefix 'g'

## input

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

## termtitle

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
zstyle ':zim:termtitle' format '%1~'

## zsh-autosuggestions

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

## zsh-syntax-highlighting

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=10'


### Initialize modules

if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh


### Post-init module configuration

## zsh-history-substring-search

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

### PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init - --path)"

export PATH="$PATH:/Users/dino/.foundry/bin"
export PATH="$PATH:/Users/dinorodriguez/.foundry/bin"

#
# -> End zsh configuration
#
