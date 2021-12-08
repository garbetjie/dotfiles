#!/usr/bin/env zsh

workspace_prefix="$HOME/Workspace"

# If we're in the Workspace directory, then figure out the PWD relative to the Workspace directory.
# Check if the first segment of the path matches the supplied workspace name.
if [ "${PWD:0:${#workspace_prefix}}" = "$workspace_prefix" ]; then
  relative_workspace_path="${PWD:${#workspace_prefix}+1}"
  first_segment="$(printf "%s" "$relative_workspace_path" | awk -F'/' '{ print $1 }')"

  if [ "$first_segment" = "$1" ] || [ "$1" = "" ]; then
    exit 0
  else
    exit 1
  fi
fi

# If no arguments were supplied, then the default is to be true.
if [ $# -eq 0 ]; then
  exit 0
# Otherwise, we're _not_ in the workspace.
else
  exit 1
fi