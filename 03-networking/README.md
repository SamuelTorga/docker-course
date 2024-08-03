# 03 Exercises

Exercises related to networking in Docker. We set up a simple network so a Node.js app can communicate with a MongoDB database that are in separate containers.

## Notes:
- host.docker.internal = Domain that allows communication with the host machine
- You need to create a network so containers can communicate with each other
- Use container names to connect between containers that are part of the same network
- We don't need to expose the port using publish if we don't need to connect to it from our host machine
- We use the bridge driver by default when we create a network, but there are other drivers we can use:
    - host: For standalone containers, isolation between container and host system is removed (i.e. they share localhost as a network)
    - overlay: Multiple Docker daemons (i.e. Docker running on different machines) are able to connect with each other. Only works in "Swarm" mode which is a dated / almost deprecated way of connecting multiple containers
    - macvlan: You can set a custom MAC address to a container - this address can then be used for communication with that container
    - none: All networking is disabled.
    - Third-party plugins: You can install third-party plugins which then may add all kinds of behaviors and functionalities