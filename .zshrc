# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.zsh"

# Set ZSH theme.
ZSH_THEME="bullet-train"
ZSH_THEME="geometry/geometry"
ZSH_THEME="garbetjie"

# ZSH configuration.
UPDATE_ZSH_DAYS=7
ZSH_CUSTOM="${HOME}/Workspace/dotfiles/zsh"

#HYPHEN_INSENSITIVE="true"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH_CUSTOM="${HOME}/.zsh"
plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.profile

# Custom additions to load after OMZSH has been loaded.
# source $ZSH_CUSTOM/plugins/geometry.zsh
[ -f /usr/local/share/zsh/site-functions ] && source /usr/local/share/zsh/site-functions
