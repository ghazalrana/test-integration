#!/bin/bash

set -euo pipefail

. config.env
. activate

kubectl delete -f ${CILIUM_DIR}/examples/kubernetes/addons/prometheus/monitoring-example.yaml
