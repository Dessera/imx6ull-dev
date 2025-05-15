FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y                  \
  crossbuild-essential-armhf build-essential      \
  git vim clang-tools clangd autoconf bear        \
  bison dwarves kmod bc openssl flex              \
  libssl-dev libelf-dev libncurses-dev pkg-config
