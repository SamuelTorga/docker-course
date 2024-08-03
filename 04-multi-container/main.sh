#!/bin/bash

# Define variables
APP_NAME="goals"
APP_NAME_BACKEND=${APP_NAME}-backend
APP_NAME_FRONTEND=${APP_NAME}-frontend
NETWORK_NAME=${APP_NAME}-net
PORT_BACKEND_APP_HOST=80
PORT_BACKEND_APP_CONTAINER=80
PORT_FRONTEND_APP_HOST=3000
PORT_FRONTEND_APP_CONTAINER=3000

# Same values that are passed to the backend container
MONGO_USERNAME="root"
MONGO_PASSWORD="secret"

build_backend_image() {
    docker build -t "${APP_NAME_BACKEND}" ./backend
}

build_frontend_image() {
    docker build -t "${APP_NAME_FRONTEND}" ./frontend
}

create_network() {
    docker network create ${NETWORK_NAME}
}

run_mongodb() {
    docker run -d --name mongodb --network ${NETWORK_NAME} -e MONGO_INITDB_ROOT_USERNAME=${MONGO_USERNAME} -e MONGO_INITDB_ROOT_PASSWORD=${MONGO_PASSWORD} -v data:/data/db mongo
}

stop_mongodb() {
    docker stop mongodb
}

rm_mongodb() {
    docker rm mongodb
}

run_container_backend() {
    LOGS_NAMED_VOLUME=logs:/app/logs # Keeping the logs in a named volume, so when container is removed, logs are not lost
    BIND_MOUNT_SOURCE_CODE=$(pwd)/backend:/app # Bind mount the backend source code to /app in the container, so that changes made in the host are reflected in the container
    ANONYMOUS_VOLUME_NODE_MODULES=/app/node_modules # Create an anonymous volume for the node_modules directory to avoid overriding it when setting the bind mount
    docker run --rm --name ${APP_NAME_BACKEND} --network ${NETWORK_NAME} -p ${PORT_BACKEND_APP_HOST}:${PORT_BACKEND_APP_CONTAINER} -v ${LOGS_NAMED_VOLUME} -v ${BIND_MOUNT_SOURCE_CODE} -v ${ANONYMOUS_VOLUME_NODE_MODULES} ${APP_NAME_BACKEND}
}

run_container_frontend() {
    BIND_MOUNT_SOURCE_CODE=$(pwd)/frontend/src:/app/src # Bind mount the backend source code to /app in the container, so that changes made in the host are reflected in the container
    ANONYMOUS_VOLUME_NODE_MODULES=/app/node_modules # Create an anonymous volume for the node_modules directory to avoid overriding it when setting the bind mount
    docker run -it --rm --name ${APP_NAME_FRONTEND} -v ${BIND_MOUNT_SOURCE_CODE} -p ${PORT_FRONTEND_APP_HOST}:${PORT_FRONTEND_APP_CONTAINER} -v ${ANONYMOUS_VOLUME_NODE_MODULES} "${APP_NAME_FRONTEND}"
}

# Parse command line arguments
case "$1" in
    build-image-back)
        build_backend_image
        ;;
    build-image-front)
        build_frontend_image
        ;;
    create-network)
        create_network
        ;;
    run-mongodb)
        run_mongodb
        ;;
    stop-mongodb)
        stop_mongodb
        ;;
    rm-mongodb)
        rm_mongodb
        ;;
    run-container-back)
        run_container_backend
        ;;
    run-container-front)
        run_container_frontend
        ;;
    *)
        echo "Usage: $0 {build-image|create-network|run-mongodb|stop-mongodb|rm-mongodb|run-container-back|run-container-front}"
        exit 1
        ;;
esac