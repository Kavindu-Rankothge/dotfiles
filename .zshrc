# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
cd
fastfetch --logo none

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
 export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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
   zsh-autosuggestions
   zsh-syntax-highlighting
   zsh-interactive-cd
) 

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zoxide
eval "$(zoxide init --cmd cd zsh)"
# fuzzy find
source <(fzf --zsh)

### my alias ###
alias vim='nvim'
alias ll='ls -ltr'
alias inv='nvim $(fzf --preview="bat --color=always {}")'
alias cat='bat -pp'
alias mnt="cd /mnt/c/Users/kavindu.rankothge"
alias notes="cd /mnt/c/Users/kavindu.rankothge/Documents/mynotes/kavindu"
alias syncnotes="/mnt/c/Users/kavindu.rankothge/Documents/mynotes/sync.sh"
# git
alias gs='git status --short'
alias gitup="git push --set-upstream origin"
alias gd='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gu='git pull'
alias gl='git log'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'
alias gcb='git checkout -b'

### work alias ###
alias a1="ssh krankothge@a1c-mgmt01"
alias mnut="ssh -D 12345 -p 22 krankothge@mnu-jb01.a1ms.cloud "
alias mnu="ssh krankothge@mnu-jb01.a1ms.cloud"
alias vccct="ssh -D 12345 -p 22 krankothge@vccc-jb01.a1ms.cloud"
alias vccc="ssh krankothge@vccc-jb01.a1ms.cloud"
alias lpau="ssh krankothge@lpau-jb01.a1ms.cloud"
alias lpaut="ssh -D 12345 -p 22 krankothge@lpau-jb01.a1ms.cloud"
alias tbst="ssh -D 12345 -p 22 krankothge@tbs-jb01.a1ms.cloud"
alias tbs="ssh krankothge@tbs-jb01.a1ms.cloud"
alias tomt="ssh -D 12345 -p 22 krankothge@tac-jb01.a1ms.cloud"
alias tom="ssh krankothge@tac-jb01.a1ms.cloud"
alias uomt="ssh -D 12345 -p 22 krankothge@uom-jb01.a1ms.cloud"
alias uom="ssh krankothge@uom-jb01.a1ms.cloud"
alias mstt="ssh -D 12345 -p 22 krankothge@mst-jb01.a1ms.cloud"
alias mst="ssh krankothge@mst-jb01.a1ms.cloud"
alias lnht="ssh -D 12345 -p 22 krankothge@lnh-jb01.a1ms.cloud"
alias lnh="ssh krankothge@lnh-jb01.a1ms.cloud"
alias nesat="ssh -D 12345 -p 22 krankothge@nesa-jb01.a1ms.cloud"
alias nesa="ssh krankothge@nesa-jb01.a1ms.cloud"
alias bult="ssh -D 12345 -p 22 krankothge@bul-jb01.a1ms.cloud"
alias bul="ssh krankothge@bul-jb01.a1ms.cloud"
alias pact="ssh -D 12345 -p 22 krankothge@pac-jb01.a1ms.cloud"
alias pac="ssh krankothge@pac-jb01.a1ms.cloud"
alias pegt="ssh -D 12345 -p 22 krankothge@peg-jb01.a1ms.cloud"
alias digt="ssh -D 12345 -p 22 krankothge@dig-jb01.a1ms.cloud"
alias peg="ssh krankothge@peg-jb01.a1ms.cloud"
alias dig="ssh krankothge@dig-jb01.a1ms.cloud"
alias hvac="/home/kavindu/scripts/rotate-hvac.sh && source /var/lib/awx/hvac/.hvac && echo done"
alias pri="/home/kavindu/scripts/pr_int.sh"
alias prc="/home/kavindu/scripts/pr_cus.sh"
alias pro="/home/kavindu/scripts/pr_oc.sh"
alias devops="source /home/kavindu/.devops/bin/activate"
