#!/bin/bash

# Include ../common.sh
DIR="$(dirname "$0")"
. "$DIR/common.sh"

# Terminate as soon as any command fails
set -e

# Change to project root directory
cd "$DIR"
cd ../

# Create required directories

setStatusMessage "Creating ./custom if absent"
mkdir -p custom

# Copy files from ./starter_files

# We're using `rsync` instead of `cp` because for some reason Travis now fails
# when using `cp -n` (it's the `-n` it doesn't like).
# https://github.com/travis-ci/travis-ci/issues/6307#issuecomment-363899104

setStatusMessage "Creating ./ansible.cfg if absent"
rsync starter_files/ansible.cfg ansible.cfg --ignore-existing

setStatusMessage "Creating ./custom/*.yml files if absent"
rsync --include '*.yml' --exclude='*' --ignore-existing starter_files/* custom/

setStatusMessage "Creating ./custom/config.local.yml if absent"
rsync starter_files/config.yml custom/config.local.yml --ignore-existing
