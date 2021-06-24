#!/bin/bash

set -euo pipefail

# Installing development tools for developers

sudo apt-get update && \
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y \
clang \
cmake \
protobuf-compiler \
flex \
bison \
git \
gcc \
gdb \
iproute2 \
jq \
libncurses5 \
lldb-3.9 \
openssh-server \
rsync \
unzip \
yamllint \
vim \
make \
build-essential \
valgrind \
wget \
zsh \
python-dev \
python3-dev \
python3-venv \
python3-pip \
htop \
apt-transport-https \
software-properties-common \
net-tools 