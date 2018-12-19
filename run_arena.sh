#!/usr/bin/env bash
set -x -e

function log() {
        echo $(date +"[%Y%m%d %H:%M:%S]: ") $1
}

if ! [ -f $KUBECONFIG ]; then
	log "Failed to find $KUBECONFIG. Please mount kubeconfig file into the pod and make sure it's $KUBECONFIG"
	exit 1
fi

if ! helm list >/dev/null 2>&1; then
	log "Warning: Failed to run 'helm list', please check if tiller is installed appropriately."
fi

set +e

if [ "$useLoadBlancer" == "true" ]; then
	find /charts/ -name *.yaml | xargs sed -i "s/NodePort/LoadBalancer/g"
	find /root/kubernetes-artifacts/ -name *.yaml | xargs sed -i "s/NodePort/LoadBalancer/g"
fi


if ! kubectl get serviceaccount --all-namespaces | grep jobmon; then
	kubectl apply -f /root/kubernetes-artifacts/jobmon/jobmon-role.yaml
fi

if ! kubectl get serviceaccount --all-namespaces | grep tf-job-operator; then
	kubectl apply -f /root/kubernetes-artifacts/tf-operator/tf-operator.yaml
fi
if ! kubectl get serviceaccount --all-namespaces | grep mpi-operator; then
	kubectl apply -f /root/kubernetes-artifacts/mpi-operator/mpi-operator.yaml
fi

if [ "$usePrometheus" == "true" ]; then
	if ! kubectl get serviceaccount --all-namespaces | grep prometheus; then
	   kubectl apply -f /root/kubernetes-artifacts/prometheus/gpu-expoter.yaml
	   kubectl apply -f /root/kubernetes-artifacts/prometheus/prometheus.yaml
    fi
fi
set -e

if [ "$useHostNetwork" == "true" ]; then
	find /charts/ -name values.yaml | xargs sed -i "/useHostNetwork/s/false/true/g"
fi


if [ -d "/host" ]; then
   cp /usr/local/bin/arena /host/usr/local/bin/arena
   if [ -d "/host/charts" ]; then
      mv /host/charts /host/charts_bak
   fi
   cp -r /charts /host
fi

tail -f /dev/null

