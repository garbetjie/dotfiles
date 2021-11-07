#!/usr/bin/env zsh

tencent_dir="$HOME/Workspace/tencentafrica"

# If we're testing whether we're in the ~/Workspace/tencentafrica workspace, we must exit 0 if we are.
if [ "$1" = "tencent" ]; then
  if [ "${PWD:0:${#tencent_dir}}" = "$tencent_dir" ]; then
    exit 0
  else
    exit 1
  fi
fi

# Otherwise, if we're in the tencentafrica workspace, we must exit 1.
if [ "${PWD:0:${#tencent_dir}}" = "$tencent_dir" ]; then
  exit 1
else
  exit 0
fi
