#!/bin/bash

set -euo pipefail

. config.env
. activate

helm uninstall -n kube-system cilium
