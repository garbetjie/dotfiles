#!/usr/bin/env zsh

set -e

# Keys to populate
keys=(
  "personal:ubckouhr3vd4njzutpc3k64la4:otdk3omgpbatxkq4ultfxghyui"
  "aws-personal::bol2wf63r5frvhzqtg2zbbw5ma"
)

# Sign in to 1password
eval "$(op signin my)"

# Process each key.
for key in "${keys[@]}"; do
  privkey_name="$(echo "$key" | awk -F: '{ print $1; }')"
  passphrase_uuid="$(echo "$key" | awk -F: '{ print $2; }')"
  privkey_contents_uuid="$(echo "$key" | awk -F: '{ print $3; }')"

  privkey_path="$HOME/.ssh/keys/${privkey_name}"
  pubkey_path="${privkey_path}.pub"

  echo "Provisioning SSH key [$privkey_name]."

  # Fetch the pass phrase if there is one.
  if [ "$passphrase_uuid" != "" ]; then
    echo "If prompted, use the following passphrase for the public SSH key: $(op get item "$passphrase_uuid" | jq -r .details.password)"
  fi

  # Populate private key contents.
  privkey_contents="$(op get document "$privkey_contents_uuid")"
  printf "%s\n" "$privkey_contents" > "$privkey_path"
  chmod 0600 "$privkey_path"
  ssh-add -K "$privkey_path"

  # Populate public key contents.
  pubkey_contents="$(ssh-keygen -y -f "$privkey_path")"
  echo "$pubkey_contents" > "$pubkey_path"
  chmod 0644 "$pubkey_path"
done
