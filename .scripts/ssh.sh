#!/bin/bash

# Generate new ssh key
ssh-keygen -t ed25519 -C "dinoorodriguez@gmail.com"

# Start ssh agent
eval "$(ssh-agent -s)"

# Create ssh config
touch ~/.ssh/config

# Add the ssh key to the key config file
# Add the following, without the comment block to the config file:
# Host *
#   AddKeysToAgent yes
#   UseKeychain yes
#   IdentityFile ~/.ssh/id_ed25519

# Add ssh key to agent
# ssh-add -K ~/.ssh/id_ed25519

# Copy ssh key to clipboard (to add to GitHub for example)
# pbcopy < ~/.ssh/id_ed25519.pub
