#!/bin/bash -e

# This script deletes the Cloud SQL instance

INSTANCE_NAME=$(cat .instance)
gcloud sql instances delete "$INSTANCE_NAME" --quiet