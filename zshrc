#!/usr/bin/env zsh

# Load dependencies.
source "$HOME/.zsh/antigen.zsh"
eval "$(starship init zsh)"


# Antigen config.
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply


# Update paths.
ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
ANDROID_HOME="$ANDROID_SDK_ROOT"
GOPATH="$HOME/Go"

PATH="$PATH:$HOME/.composer/vendor/bin"
PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools"
PATH="$PATH:$HOME/Workspace/tencentafrica/utils"
PATH="/usr/local/opt/mysql-client/bin:$PATH"

export ANDROID_SDK_ROOT ANDROID_HOME GOPATH PATH


# Load in aliases.
source "$HOME/.zsh/aliases.zsh"


# Load in functions.
source "$HOME/.zsh/functions.zsh"

# # ZSH configuration.
# ZSH_CUSTOM="~/.zsh"
#
# CASE_SENSITIVE="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="false"
# COMPLETION_WAITING_DOTS="false"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="yyyy-mm-dd"
#
# source ~/.profile

# Custom additions to load after OMZSH has been loaded.
# source $ZSH_CUSTOM/plugins/geometry.zsh
[ -f /usr/local/share/zsh/site-functions ] && source /usr/local/share/zsh/site-functions
