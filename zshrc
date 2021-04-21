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

  # cache the brew prefix, so it doesn't need to be run multiple times.
  brew_prefix="$(brew --prefix)"

  # add additional paths for libraries.
  PATH="${brew_prefix}/opt/mysql-client/bin:$PATH"

  # aliases and functions
  source "$HOME/.zsh/aliases.zsh"
  source "$HOME/.zsh/functions.zsh"
  source "${brew_prefix}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
#  source "${brew_prefix}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"  # see https://github.com/zsh-users/zsh-completions/issues/539
  source "$HOME/Library/Application Support/iTerm2/shell_integration.zsh"

  # determine the gcloud config to use.
#  chpwd_functions=(${chpwd_functions[@]} "set_gcloud_config")

  # shell history handling
  export HISTSIZE=1000000
  export HISTFILESIZE=1000000
  setopt HIST_FIND_NO_DUPS HIST_IGNORE_DUPS SHARE_HISTORY
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
  # TODO Figure out better formatting for iTerm2 command mark.
#  export ITERM2_SQUELCH_MARK=1
# }}}
