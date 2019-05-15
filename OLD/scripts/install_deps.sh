#!/bin/bash

# Include ../common.sh
DIR="$(dirname "$0")"
. "$DIR/common.sh"

# Terminate as soon as any command fails
set -e

# Install pip
if ! exists pip; then
  setStatusMessage "Installing pip"
  sudo easy_install pip
fi

# Install Ansible
# TODO: We need at least Ansible 2.4.0, upgrade if needed
if ! exists ansible; then
  setStatusMessage "Installing Ansible"
  sudo pip install ansible --quiet
fi

# Confirm installed versions
pip --version
ansible --version
