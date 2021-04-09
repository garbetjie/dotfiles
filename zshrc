#!/usr/bin/env zsh

# aliases & functions {{{
  source "$HOME/.zsh/aliases.zsh"
  source "$HOME/.zsh/functions.zsh"
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


# paths {{{
  ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
  ANDROID_HOME="$ANDROID_SDK_ROOT"
  GOPATH="$HOME/Go"

  PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin"
  PATH="$PATH:$HOME/.composer/vendor/bin"
  PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools"
  PATH="$PATH:$HOME/Workspace/tencentafrica/utils"
  PATH="/usr/local/opt/mysql-client/bin:$PATH"

  export ANDROID_SDK_ROOT ANDROID_HOME GOPATH PATH
# }}}
