#!/bin/bash -e

# This script builds the GKE cluster that we launch our application and the
# Cloud SQL Proxy in

set -o errexit

# 共用 constants.sh
# shellcheck disable=SC1090
source scripts/constants.sh

GKE_VERSION=$(gcloud container get-server-config --zone "$CLUSTER_ZONE" \
  --format="value(validMasterVersions[0])")

gcloud container clusters create "$CLUSTER_NAME" \
--cluster-version "$GKE_VERSION" \
--num-nodes 1 \
--enable-autorepair \
--zone "$CLUSTER_ZONE" \
--service-account="$FULL_NODE_SA_NAME" \
# --service-account="mysql-demo-node-sa@$PROJECT".iam.gserviceaccount.com \

# Setting up .kube/config. This happens normally if you don't use --async
gcloud container clusters get-credentials "$CLUSTER_NAME" --zone "$CLUSTER_ZONE"