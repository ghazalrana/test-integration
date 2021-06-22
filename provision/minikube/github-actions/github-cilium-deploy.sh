#!/bin/bash

set -euo pipefail

. actions-config.env
. actions-activate



if [ ! -d cilium ]; then
    git clone https://github.com/cilium/cilium
fi


pushd cilium/install/kubernetes

helm install cilium ./cilium  \
    --namespace kube-system \
	--set image.tag=${CILIUM_TAG} \
	--set image.pullPolicy=IfNotPresent \
	--set ipv6.enabled=true \
	--set nodePort.enabled=true \
	--set operator.image.tag=${CILIUM_TAG} \
	--set operator.image.pullPolicy=IfNotPresent \
	--set operator.replicas=1 \
	--set preflight.image.tag=${CILIUM_TAG} \
	--set preflight.image.pullPolicy=IfNotPresent \
	--set clustermesh.apiserver.image.tag=${CILIUM_TAG} \
	--set clustermesh.apiserver.image.pullPolicy=IfNotPresent \
	--set hubble.enabled=true \
	--set hubble.ui.enabled=true \
	--set hubble.ui.frontend.image.tag=${HUBBLE_UI_TAG} \
	--set hubble.ui.backend.image.tag=${HUBBLE_UI_TAG} \
	--set hubble.ui.backend.image.pullPolicy=IfNotPresent \
	--set hubble.ui.frontend.image.pullPolicy=IfNotPresent \
	--set hubble.relay.enabled=true \
	--set hubble.relay.image.tag=${CILIUM_TAG} \
    --set hubble.metrics.enabled="{dns,drop,tcp,flow,icmp,http}" \
    --set prometheus.enabled=true \
    --set operator.prometheus.enabled=true

popd