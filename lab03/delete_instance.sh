#!/bin/bash -e

# This script deletes the Cloud SQL instance

gcloud sql instances delete "$INSTANCE_NAME" --quiet