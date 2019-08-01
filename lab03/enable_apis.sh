#!/bin/bash -e

# This script checks to make sure that the pre-requisite APIs are enabled.

function enable_api() {
  SERVICE=$1
  if [[ $(gcloud services list --format="value(config.name)" \
                                --filter="$SERVICE" 2>&1) != \
                                "$SERVICE" ]]; then
    echo "Enabling $SERVICE"
    gcloud services enable "$SERVICE"
  else
    echo "$SERVICE is already enabled"
  fi
}

enable_api sqladmin.googleapis.com
enable_api container.googleapis.com
enable_api iam.googleapis.com