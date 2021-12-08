#!/usr/bin/env zsh

set -e

# Log in.
eval "$(op signin my)"

# Get the item containing the access key & secret.
json="$(op get item --vault "e7xr3hmr5xtqkyd34xse3bxl5u" "emtok2sadze5jpyzxn23ecwqbu")"

# Populate the profile.
aws configure set --profile personal region af-south-1
aws configure set --profile personal aws_access_key_id "$(echo "$json" | jq -r '.details.fields[]|select(.name=="username")|.value')"
aws configure set --profile personal aws_secret_access_key "$(echo "$json" | jq -r '.details.fields[]|select(.name=="password")|.value')"