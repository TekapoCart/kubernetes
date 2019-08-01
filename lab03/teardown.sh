#!/bin/bash -e

# This script will remove all the GCP resources, which include
# the GKE cluster, the Cloud SQL instance, and the accompanying service
# accounts

help() {
  echo "sh teardown.sh INSTANCE_NAME"
}

INSTANCE_NAME=$(cat .instance)
if [ -z "$INSTANCE_NAME" ] ; then
  help
  exit 1
fi

sh delete_resources.sh
sh delete_instance.sh