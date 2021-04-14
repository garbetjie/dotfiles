#!/usr/bin/env zsh

set -e

keyfile_path="$HOME/.ssh/keys"
signed_in=false

sign_in() {
  if [ "$signed_in" = false ]; then
    signed_in=true
    eval "$(op signin my)"
  fi
}

while [ $# -gt 0 ]; do
  passphrase=
  key_name="$(echo "$1" | cut -f1 -d:)"
  passphrase_uuid="$(echo "$1" | cut -f2 -d:)"
  privkey_uuid="$(echo "$1" | cut -f3 -d:)"

  privkey_path="${keyfile_path}/${key_name}"
  pubkey_path="${privkey_path}.pub"

  if [ ! -f "$privkey_path" ] || [ ! -f "$pubkey_path" ]; then
    sign_in

    passphrase="$(op get item "$passphrase_uuid" | jq -r .details.password)"
    echo "If prompted, use the following passphrase for the public SSH key: ${passphrase}"
  fi

  # Create the private key if it doesn't exist.
  if [ ! -f "$privkey_path" ]; then
    sign_in

    privkey_contents="$(op get document "$privkey_uuid")"
    echo "$privkey_contents" > "$privkey_path"
    chmod 0600 "$privkey_path"
    ssh-add -K "$privkey_path"
  fi

  # Create the public key if it doesn't exist.
  # We need to echo out the passphrase, as it doesn't seem possible to pipe it to ssh-keygen.
  if [ ! -f "$pubkey_path" ]; then
    sign_in

    pubkey_contents="$(ssh-keygen -y -f "$privkey_path")"
    echo "$pubkey_contents" > "$pubkey_path"
    chmod 0644 "$pubkey_path"
  fi

  shift
done
