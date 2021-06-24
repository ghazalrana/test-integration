#!/bin/bash

set -euo pipefail

. actions-config.env

pushd $HOME/go/src/github.com/cilium/cilium-cli

# $PATH is equal to the PATH defined in config.env for go {PATH=$PATH:$GOROOT/bin}

sudo "PATH=$PATH" make install

popd
