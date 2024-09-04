# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colorize
  cp
  extract
  aliases
  zsh-autosuggestions
  )

source $ZSH/oh-my-zsh.sh

# Enables individual tmux pane histories
# Also enables a central history for all panes, searchable with ctrl + r
HISTFILE_MAIN=$HOME/.zsh_histories/.zsh_history_main
if [[ ! -f $HISTFILE_MAIN ]]; then
  touch $HISTFILE_MAIN
fi
# Write to history every cmd, and reload history every cmd
setopt SHARE_HISTORY

function append_to_main_history {
  # Only append if theres something to append. fixes startup error
  if [[ -n $(fc -l -1 2>/dev/null) ]]; then
    fc -ln -1 >> $HISTFILE_MAIN
  fi
}

function search_all_history {
  # search main histfile, and then switch back to local histfile after
  local original_histfile=$HISTFILE
  HISTFILE=$HISTFILE_MAIN
  fc -p $HISTFILE_MAIN
  zle history-incremental-search-backward
  fc -P
  HISTFILE=$original_histfile
}

if [[ $TMUX_PANE ]]; then
  HISTFILE=$HOME/.zsh_histories/.zsh_history_tmux_${TMUX_PANE:1}
  # If this is tmux, then every time we write to pane history, also write to central history
  add-zsh-hook zshaddhistory append_to_main_history
  zle -N search_all_history
  # Bind ctrl + R to my search function, which calls the normal one. Bind ctrl + R and S in the normal one to their normal things
  bindkey -M isearch '^R' history-incremental-search-backward
  bindkey -M isearch '^S' history-incremental-search-forward
  bindkey '^R' search_all_history
else
  HISTFILE=$HISTFILE_MAIN
  neofetch
fi

# Config dotfile management
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# General aliases
alias nvim='$HOME/nvim.appimage'
alias bat='batcat'
alias python='python3'
alias py='python3'
