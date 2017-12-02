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

# Install brew
if ! exists brew; then
  setStatusMessage "Installing brew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  setStatusMessage "Updating Brew"
  brew update
fi

# Install Ansible
# TODO: We need at least Ansible 2.4.0, upgrade if needed.
if ! exists ansible; then
  setStatusMessage "Installing Ansible"
  brew install ansible
else
  setStatusMessage "Updating Ansible"
  brew outdated ansible || brew upgrade ansible
fi

# Install pexpect
setStatusMessage "Installing pexpect"
pip install pexpect --quiet

# Confirm installed Ansible version
ansible --version

# Install Ansible Galaxy dependencies:
setStatusMessage "Installing required Ansible Galaxy roles"
ansible-galaxy install -r requirements.yml --force
