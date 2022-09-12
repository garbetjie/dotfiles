#!/usr/bin/env bash

# Ensure any failures exit early.
set -e -o pipefail

# Determine the OS we're running on.
if [ "$(uname -s | tr '[:upper:]' '[:lower:]')" = "darwin" ]; then
  os="darwin"
elif uname -r | grep -qi linuxkit || uname -r | grep -qi microsoft; then
  os="wsl"
else
  os="linux"
fi

# Install nix if not already available.
if ! command -v nix-shell &> /dev/null; then
  installer_file="$(mktemp)"
  download_url="https://nixos.org/nix/install"

  # Ensure the installer file is removed.
  # shellcheck disable=SC2064
  trap "rm -f '$installer_file'" EXIT

  # Download the installer file.
  if command -v curl &> /dev/null; then
    curl -L "$download_url" -so "$installer_file"
  elif command -v wget &> /dev/null; then
    wget -O "$installer_file" "$download_url"
  else
    echo "One of [wget] or [curl] is required to install nix."
    exit 1
  fi

  if [ "$os" = "darwin" ]; then
    sh "$installer_file" --darwin-use-unencrypted-nix-store-volume --daemon
  elif [ "$os" = "wsl" ]; then
    sh "$installer_file" --no-daemon
  else
    sh "$installer_file" --daemon
  fi

  # Handle WSL2/Docker.
  if [ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ]; then
    . "$HOME"/.nix-profile/etc/profile.d/nix.sh
  # Handle Linux
  elif [ -e /etc/profile.d/nix.sh ]; then
    . /etc/profile.d/nix.sh
  # Handle macOS
  else
    echo "Please open a new terminal and run this script again."
    exit 0
  fi
fi


# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install


# Install Homebrew & packages for macOS.
if [ "$os" = "darwin" ]; then
  xcode-select --install || true
  sudo softwareupdate --install-rosetta --agree-to-license || true
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  sudo spctl --master-disable
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}" && brew bundle install
  sudo sudo spctl --master-enable
  osacompile -o '/Applications/Color Picker.app' -e 'choose color'
fi

# Install packages for WSL/Linux.
if [ "$os" = "linux" ] || [ "$os" = "wsl" ]; then
  sudo apt-get update
  sudo apt-get install -y zsh
fi