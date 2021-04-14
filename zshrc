#!/usr/bin/env zsh

# shell configuration {{{
  # paths
  ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
  ANDROID_HOME="$ANDROID_SDK_ROOT"
  GOPATH="$HOME/Go"

  PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin"
  PATH="$PATH:$HOME/.composer/vendor/bin"
  PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools"
  PATH="$PATH:$HOME/Workspace/tencentafrica/utils"
  PATH="/usr/local/opt/mysql-client/bin:$PATH"

  # aliases and functions
  source "$HOME/.zsh/aliases.zsh"
  source "$HOME/.zsh/functions.zsh"

  # shell history handling
  setopt HIST_FIND_NO_DUPS INC_APPEND_HISTORY_TIME
# }}}


# starship {{{
  eval "$(starship init zsh)"
# }}}


# antigen {{{
  source "$HOME/.zsh/antigen.zsh"

  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-syntax-highlighting

  # shellcheck disable=SC2034
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#505050"

  antigen apply
# }}}


# export paths {{{
  export ANDROID_SDK_ROOT ANDROID_HOME GOPATH PATH
# }}}
