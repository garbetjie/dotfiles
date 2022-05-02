#!/usr/bin/env bash

# Determine our username.
username="$(whoami)"

# Install required utilities.
sudo apt-get update
sudo apt-get install -y curl xz-utils

# Create the nix directory.
sudo -s /bin/bash -c "mkdir -p -m 0755 /nix && chown $username /nix"

# Install nix.
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Load the profile.
. "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Install ansible.
nix-env -i ansible-core

# Run ansible.
