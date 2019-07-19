#!/bin/bash -e

# In order to not expose this project to the internet with a
# Cloud Load Balancer we are instead port-forwarding to the node and
# exposing the pod port

POD_ID=$(kubectl --namespace default get pods -o name | cut -d '/' -f 2)
kubectl --namespace default port-forward "$POD_ID" 8080:80