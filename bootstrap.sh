#!/bin/bash

set -euo pipefail

if [ ! -d cilium ]; then
    git clone https://github.com/cilium/cilium
fi