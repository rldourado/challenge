#!/usr/bin/bash
set -e

export CLUSTER=challenge
export HTTPPORT=8080
export GRAFANA_PASS=operator


echo "==== deploy k3s"
read -p "Deploy k3s? (y/n) " -n 1 -r
echo
if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  # remove existing cluster
  if [[ ! -z $(k3d cluster list | grep "^${CLUSTER}") ]]; then
    echo
    echo "==== remove existing cluster"
    read -p "K3D cluster \"${CLUSTER}\" exists. Ok to delete it and restart? (y/n) " -n 1 -r
    echo
    if [[ ${REPLY} =~ ^[Yy]$ ]]; then
      k3d cluster delete ${CLUSTER}
    fi
  fi

  if [[ -z $(k3d cluster list | grep "^${CLUSTER}") ]]; then
    # k3d cluster create ${CLUSTER} --port "8081:80@loadbalancer" --k3s-node-label "challenge=app@server:0,1" --servers 2 --agents 2 --volume `pwd`/volume:/tmp/k3dvol --wait

    echo "==== create new cluster ${CLUSTER} for app ${APP}:${VERSION}"
    cat ./k3d-config.yaml.template | envsubst > /tmp/k3d-config.yaml
    k3d cluster create --config /tmp/k3d-config.yaml
    export KUBECONFIG=$(k3d kubeconfig write ${CLUSTER})
    echo "export KUBECONFIG=${KUBECONFIG}"
    rm /tmp/k3d-config.yaml

    echo
    echo "==== show info about the cluster ${CLUSTER}"
    kubectl cluster-info
    echo
    kubectl get all -A
  fi
fi

echo
echo "==== deploy mariadb"
read -p "Deploy mariadb? (y/n) " -n 1 -r
echo
if [[ ${REPLY} =~ ^[Yy]$ ]]; then
  cp ../.env kustomize/mariadb/base
  kubectl apply -k kustomize/mariadb/overlays/dev
  rm kustomize/mariadb/base/.env

  kubectl rollout status deploy/mariadb
fi

echo
echo "==== deploy challenge-app"
read -p "Deploy challenge-app? (y/n) " -n 1 -r
echo
if [[ ${REPLY} =~ ^[Yy]$ ]]; then
  cp ../.env kustomize/challenge-app/base
  kubectl apply -k kustomize/challenge-app/overlays/dev
  rm kustomize/challenge-app/base/.env

  kubectl rollout status deploy/challenge-app
fi
