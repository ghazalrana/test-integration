#!/bin/bash

. config.env
. activate

kubectl port-forward -n kube-system svc/hubble-ui --address 0.0.0.0 --address :: 12000:80
