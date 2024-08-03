#!/bin/bash

# Define variables
APP_NAME="favorites"
CONTAINER_NAME=${APP_NAME}
HOST_MACHINE_PORT=3000
DEFAULT_PORT=3000
NETWORK_NAME=${APP_NAME}-net

# Function to build the web app image
build_image() {
    docker build -t "${APP_NAME}" .
}

create_network() {
    docker network create ${NETWORK_NAME}
}

run_mongodb() {
    docker run -d --name mongodb --network ${NETWORK_NAME} mongo
}

stop_mongodb() {
    docker stop mongodb
}

rm_mongodb() {
    docker rm mongodb
}

run_container() {
    docker run -it --rm --name ${CONTAINER_NAME} -p ${HOST_MACHINE_PORT}:${DEFAULT_PORT} --network ${NETWORK_NAME} "${APP_NAME}"
}

# Parse command line arguments
case "$1" in
    build-image)
        build_image
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
    run-container)
        run_container
        ;;
    *)
        echo "Usage: $0 {build-image|create-network|run-mongodb|stop-mongodb|rm-mongodb|run-container|run-container-dev}"
        exit 1
        ;;
esac