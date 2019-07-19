#!/bin/bash -e

# This script runs the only Kubernetes manifest in the project.
# It is a single pod with two containers, phpMyAdmin and the
# Cloud SQL Proxy container. The pod only exists as one replica.

ROOT=$(dirname "${BASH_SOURCE[0]}")

kubectl --namespace default create -f "$ROOT"/../manifests/phpmyadmin-deployment.yaml

# Waiting for the pod to actually deploy correctly
kubectl --namespace default rollout status --request-timeout="5m" -f "$ROOT"/../manifests/phpmyadmin-deployment.yaml