#!/bin/bash

source $(dirname "$0")/utils.sh

# Значення за замовчуванням
IMAGE_NAME="my_go_web_server"
IMAGE_VERSION="latest"
CONTAINER_NAME="go_web_server"
HOST_PORT="8080"
CONTAINER_PORT="8080"

# Обробка прапорів
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--image) IMAGE_NAME="$2"; shift ;;
        -v|--version) IMAGE_VERSION="$2"; shift ;;
        -c|--container) CONTAINER_NAME="$2"; shift ;;
        -hp|--host-port) HOST_PORT="$2"; shift ;;
        -cp|--container-port) CONTAINER_PORT="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Перевірка наявності Docker
check_command docker

# Запуск контейнера
log "Running Docker container ${CONTAINER_NAME}..."
docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}:${IMAGE_VERSION}
log "Docker container ${CONTAINER_NAME} is running."

# Очікування запуску контейнера
log "Waiting for 30 seconds for the container to start..."
sleep 30

# Перевірка стану контейнера
./healthcheck.sh --container ${CONTAINER_NAME} --host-port ${HOST_PORT}
