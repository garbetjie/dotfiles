#!/usr/bin/env zsh

workspace_prefix="$HOME/Workspace"

# If we're in the Workspace directory, then figure out the PWD relative to the Workspace directory.
# Check if the first segment of the path matches the supplied workspace name.
if [ "${PWD:0:${#workspace_prefix}}" = "$workspace_prefix" ]; then
  relative_workspace_path="${PWD:${#workspace_prefix}+1}"
  first_segment="$(printf "%s" "$relative_workspace_path" | awk -F'/' '{ print $1 }')"

  if [ "$first_segment" = "$1" ] || [ "$1" = "" ]; then
    echo "exiting 0 (success) [pwd=$PWD] [relative=${PWD:${#workspace_prefix}+1}] [workspace=$first_segment] [1=$1]" >> /tmp/geoff
    exit 0
  else
    echo "exiting 1 (fail) [pwd=$PWD] [workspace=$first_segment] [1=$1]" >> /tmp/geoff
    exit 1
  fi
fi

# Default to exiting with 1.
exit 1