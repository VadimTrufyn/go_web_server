#!/bin/bash

LOG_FILE="script.log"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') $1" | tee -a $LOG_FILE
}

check_command() {
  if ! [ -x "$(command -v $1)" ]; then
    log "Error: $1 is not installed."
    exit 1
  fi
}
