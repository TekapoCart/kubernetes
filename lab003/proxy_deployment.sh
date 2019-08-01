#!/bin/bash -e

# This script runs the only Kubernetes manifest in the project.
# It is a single pod with two containers, phpMyAdmin and the Cloud SQL Proxy container.
# The pod only exists as one replica.


kubectl --namespace default create -f proxy-deployment.yaml

# Waiting for the pod to actually deploy correctly
kubectl --namespace default rollout status --request-timeout="5m" -f proxy-deployment.yaml