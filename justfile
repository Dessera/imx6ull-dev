DEVNAME := "imx6ull-dev"
DEVIMGNAME := DEVNAME + "-env"

# list all tasks
help:
  @just --list

# build development container
mkdev-image:
  podman build -t {{DEVIMGNAME}} ./container

# remove development container
rmdev-image:
  podman rmi {{DEVIMGNAME}}

# run development container
develop:
  -podman run -dit --privileged --name {{DEVNAME}}              \
              -v $(pwd)/container/projects:/projects            \
              {{DEVIMGNAME}}:latest
