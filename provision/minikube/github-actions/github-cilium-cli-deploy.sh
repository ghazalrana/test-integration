#!/bin/bash

set -euo pipefail

. actions-config.env


if [ ! -d ${CILIUM_CLI_DIR}/cilium-cli ]; then

   mkdir -p ${CILIUM_CLI_DIR}

    git clone https://github.com/zmced/cilium-cli.git  ${CILIUM_CLI_DIR}/cilium-cli
fi


pushd ${CILIUM_CLI_DIR}/cilium-cli

# $PATH is equal to the PATH defined in config.env for go {PATH=$PATH:$GOROOT/bin}

sudo "PATH=$PATH" make install

popd