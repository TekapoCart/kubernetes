#!/bin/bash -e

# Configuring an existing instance to use private IP

gcloud services enable servicenetworking.googleapis.com

INSTANCE_NAME=$(cat .instance)
gcloud beta sql instances patch $INSTANCE_NAME \
       --network=default \
       --no-assign-ip