#!/bin/bash -e

# This script runs the only Kubernetes manifest in the project.
# It is a single pod with one container, phpMyAdmin container.
# The pod only exists as one replica.

kubectl --namespace default create -f private-deployment.yaml

# Waiting for the pod to actually deploy correctly
kubectl --namespace default rollout status --request-timeout="5m" -f private-deployment.yaml