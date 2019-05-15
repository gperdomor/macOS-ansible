#!/bin/bash

# Vars

BGreen='\e[1;32m' # Green
Color_Off='\e[0m' # Text Reset

# Functions

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
