#!/bin/bash

set -euo pipefail

. config.env
. activate

kubectl apply -f ${CILIUM_DIR}/examples/kubernetes/addons/prometheus/monitoring-example.yaml
