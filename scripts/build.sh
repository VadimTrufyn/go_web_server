#!/bin/bash

source $(dirname "$0")/utils.sh

# Значення за замовчуванням
IMAGE_NAME="my_go_web_server"
IMAGE_VERSION="latest"

# Обробка прапорів
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--image) IMAGE_NAME="$2"; shift ;;
        -v|--version) IMAGE_VERSION="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Перевірка наявності Docker
check_command docker

# Шлях до Dockerfile
DOCKERFILE_PATH="$(dirname "$0")/../Dockerfile"

# Побудова Docker образу
log "Building Docker image ${IMAGE_NAME}:${IMAGE_VERSION}..."
if docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} -f ${DOCKERFILE_PATH} $(dirname "$0")/..; then
  log "Docker image ${IMAGE_NAME}:${IMAGE_VERSION} built successfully."
else
  log "Failed to build Docker image ${IMAGE_NAME}:${IMAGE_VERSION}."
  exit 1
fi

