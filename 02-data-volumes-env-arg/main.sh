#!/bin/bash

# Define variables
APP_NAME="feedback-app"
IMAGE_NAME_WEB_APP="${APP_NAME}:web-app"
IMAGE_NAME_DEV="${APP_NAME}:dev"
DEFAULT_PORT=80
DEFAULT_PORT_DEV=8000
HOST_MACHINE_PORT=3000
CONTAINER_NAME=${APP_NAME}

# Function to build the web app image
build_image() {
    docker build -t "${IMAGE_NAME_WEB_APP}" .
}

# Function to build the dev image with a build argument
build_image_dev() {
    docker build -t "${IMAGE_NAME_DEV}" --build-arg DEFAULT_PORT="${DEFAULT_PORT_DEV}" .
}

# Bind mount the current directory to /app in the container
# In this case it's useful so that the changes made in the host are reflected in the container
# We set the bind mount as read-only to avoid any accidental changes in the container
# On Windows there is a problem with the automatic reload of the changes. You need to configure to run in WSL 2.
BIND_MOUNT=$(pwd):/app:ro
# Create an anonymous volume for the node_modules directory. We set node_modules as an anonymous volume because we override it when we set the bind mount.
ANONYMOUS_VOLUME_NODE_MODULES="/app/node_modules"
# We set temp folder as an anonymous volume because we had set the project folder as read-only, allowing writes to this folder.
ANONYMOUS_VOLUME_TEMP="/app/temp"

run_container_dev() {
    echo Bind Mount: ${BIND_MOUNT}
    docker run -it --rm --name ${CONTAINER_NAME} -p ${HOST_MACHINE_PORT}:${DEFAULT_PORT_DEV} -v ${BIND_MOUNT} -v ${ANONYMOUS_VOLUME_NODE_MODULES} -v ${ANONYMOUS_VOLUME_TEMP} "${IMAGE_NAME_DEV}"
}

run_container() {
    docker run -it --rm -d --name ${CONTAINER_NAME} -p ${HOST_MACHINE_PORT}:${DEFAULT_PORT} -v ${BIND_MOUNT} -v ${ANONYMOUS_VOLUME_NODE_MODULES} -v ${ANONYMOUS_VOLUME_TEMP} "${IMAGE_NAME_WEB_APP}"
}

# Parse command line arguments
case "$1" in
    build-image)
        build_image
        ;;
    build-image-dev)
        build_image_dev
        ;;
    run-container)
        run_container
        ;;
    run-container-dev)
        run_container_dev
        ;;
    *)
        echo "Usage: $0 {build-image|build-image-dev|run-dev-container}"
        exit 1
        ;;
esac