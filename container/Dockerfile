FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y                  \
  crossbuild-essential-armhf build-essential      \
  git vim clang-tools clangd autoconf bear        \
  bison dwarves kmod bc openssl flex wget         \
  libssl-dev libelf-dev libncurses-dev pkg-config

RUN wget -O /root/zig.tar.xz https://ziglang.org/download/0.14.0/zig-linux-x86_64-0.14.0.tar.xz
RUN tar -xf /root/zig.tar.xz -C /root
RUN rm /root/zig.tar.xz

RUN wget -O /root/zls.tar.xz https://builds.zigtools.org/zls-linux-x86_64-0.14.0.tar.xz
RUN tar -xf /root/zls.tar.xz -C /root/zig-linux-x86_64-0.14.0
RUN rm /root/zls.tar.xz

ENV PATH="/root/zig-linux-x86_64-0.14.0:${PATH}"
