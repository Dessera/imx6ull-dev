FROM ubuntu:25.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y   \
    crossbuild-essential-armhf build-essential          \
    git vim clang-tools clangd autoconf bear            \
    bison dwarves kmod bc openssl flex                  \
    libssl-dev libelf-dev libncurses-dev

CMD ["/bin/bash"]
