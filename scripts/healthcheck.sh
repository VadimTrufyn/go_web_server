#!/bin/bash

source $(dirname "$0")/utils.sh

# Значення за замовчуванням
CONTAINER_NAME="go_web_server"
HOST_PORT="8080"

# Обробка прапорів
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -c|--container) CONTAINER_NAME="$2"; shift ;;
        -hp|--host-port) HOST_PORT="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

CHECK_URL="http://localhost:$HOST_PORT/ping"

# Перевірка наявності curl
check_command curl

# Перевірка стану контейнера
log "Checking HTTP status..."
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" ${CHECK_URL})

if [ ${RESPONSE} -eq 200 ]; then
  log "HTTP Status is 200 OK"
else
  log "HTTP Status is ${RESPONSE}"
fi
