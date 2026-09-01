# --- benchmarking (comment out once you're happy with startup time) ---
# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

# --- zinit bootstrap
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")" && \
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load plugins in turbo mode (async, doesn't block prompt)
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zdharma-continuum/history-search-multi-word


# Light background colors for zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='fg=black'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue,underline'
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[assign]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=blue,bold'

# Autosuggestions color (darker for light backgrounds)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# --- prompt: Starship (replaces powerlevel10k) ---
# Install once if not already present: curl -sS https://starship.rs/install.sh | sh
eval "$(starship init zsh)"

# --- aliases (kept in their own file) ---
[[ -f ~/.zsh_aliases.zsh ]] && source ~/.zsh_aliases.zsh

# fuzzy find
source <(fzf --zsh)

# --- SSL ---
export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
export CURL_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt
export GEMINI_API_KEY=''

# --- nvm: lazy-loaded so it doesn't cost startup time until actually used ---
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}
node() { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; node "$@"; }
npm()  { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npm "$@"; }
npx()  { unset -f nvm node npm npx; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; npx "$@"; }

# --- history ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000


setopt APPEND_HISTORY        # append instead of overwrite
setopt INC_APPEND_HISTORY    # write each command as it's run, not just on exit
setopt SHARE_HISTORY         # share history across all open zsh sessions
setopt HIST_IGNORE_DUPS      # don't record a line if it's a duplicate of the previous
setopt HIST_IGNORE_SPACE     # don't record lines starting with a space
setopt HIST_VERIFY           # show expanded history command before running it
setopt HIST_EXPIRE_DUPS_FIRST

# Claude Code with Bedrock — added by setup.sh
source /usr/local/bin/claude-bedrock-init.sh

# zoxide — must be initialized last so its chpwd hook is not dropped by a
# later plugin reassigning chpwd_functions. _ZO_DOCTOR=0 silences the
# false-positive warning in shells that rewrite chpwd_functions after rc
# load (e.g. Claude Code's Bash tool tracking cwd).
export _ZO_DOCTOR=0
eval "$(zoxide init --cmd cd zsh)"

# --- benchmarking output (comment out once you're happy with startup time) ---
# zprof
