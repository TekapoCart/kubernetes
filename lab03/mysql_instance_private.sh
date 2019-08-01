#!/bin/bash -e

# Configuring an existing instance to use private IP

INSTANCE_NAME=$(cat .instance)
gcloud sql instances patch $INSTANCE_NAME
       --network=default
       --no-assign-ip