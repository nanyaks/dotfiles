# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="af-magic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python tmux)

source $ZSH/oh-my-zsh.sh

# CUSTOMIZE TO YOUR NEEDS...

#CR=$HOME/.cred0
#source $CR/swa_114.sh

# Set the terminal to use utf8
export LANG=en_US.utf8

# Enable color support of ls and add aliases - from .bashrc
# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
#     alias dir='dir --color=auto'
#     alias vdir='vdir --color=auto'

#     alias grep='grep --color=auto'
#     alias fgrep='fgrep --color=auto'
#     alias egrep='egrep --color=auto'
# fi

#export TERM=xterm-256color
#[ -n "$TMUX" ] && export TERM=screen-256color

# From ~/.bashrc - removes gvim error on launch.
#function gvim() { (/usr/local/bin/vim -gf "$@" &) }

# For gvimdiff
#function gvimdiff() { (/usr/local/bin/vim -d -gf "$@" &) }

# shamelessly stolen from https://github.com/phy1729/dotfiles/blob/master/.zshrc#L53-54
# display vim help on $1 full screen.
#alias :h='noglob :h-helper'
#function :h-helper() { vim +"h" +"h $1" +only +'nnoremap q :q!<CR>'; }

# For the phone
#alias android-connect="mtpfs -o allow_other /media/GalaxyGrand"
#alias android-disconnect="fusermount -u /media/GalaxyGrand"
