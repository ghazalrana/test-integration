#!/bin/bash

. config.env
. activate

kubectl port-forward -n cilium-monitoring svc/grafana --address 0.0.0.0 --address :: 12300:3000
