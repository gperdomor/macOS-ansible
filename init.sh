#!/bin/bash

# This file ensures that Ansible and any dependencies are in place.

# Prerequisites: See README.md

# Credits:
# - https://github.com/superlumic/superlumic/blob/master/superlumic

# ------------------------------------------------------------------------------

# Vars
# ------------------------------------------------------------------------------

BGreen='\e[1;32m' # Green
Color_Off='\e[0m' # Text Reset

# Functions
# ------------------------------------------------------------------------------

function setStatusMessage {
  printf " --> ${BGreen}$1${Color_Off}\n" 1>&2
}

# Check whether a command exists - returns 0 if it does, 1 if it does not
function exists {
  if command -v $1 >/dev/null 2>&1
  then
    return 0
  else
    return 1
  fi
}

# Install
# ------------------------------------------------------------------------------

# Install pip
if ! exists pip; then
  setStatusMessage "Installing pip"
  sudo easy_install pip
fi

# Install Ansible
if ! exists ansible; then
  setStatusMessage "Installing Ansible"
  sudo pip install ansible --quiet
fi

# Create requirements.yml
setStatusMessage "Creating requirements.yml if absent"
cp -n src/requirements.yml requirements.yml

# Create mac.yml
setStatusMessage "Creating mac.yml if absent"
cp -n src/mac.yml mac.yml

# Create config.yml
setStatusMessage "Creating config.yml if absent"
cp -n src/config.yml config.yml

# Create config.local.yml
setStatusMessage "Creating config.local.yml if absent"
cp -n src/config.yml config.local.yml

# Install Ansible Galaxy dependencies:
setStatusMessage "Installing required Ansible Galaxy roles"
ansible-galaxy install -r requirements.yml --force
