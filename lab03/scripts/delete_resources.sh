#!/bin/bash -e

# This script deletes everything but the Cloud SQL instance. Building a
# Cloud SQL instance takes a long time so deleting it is a separate step
# that includes a prompt in another script

ROOT=$(dirname "${BASH_SOURCE[0]}")
# shellcheck disable=SC1090
source "${ROOT}"/constants.sh

gcloud container clusters delete \
mysql-demo-cluster --zone "$CLUSTER_ZONE" --quiet

gcloud projects remove-iam-policy-binding "$PROJECT" \
--member serviceAccount:"$FULL_SA_NAME" \
--role roles/cloudsql.client > /dev/null

gcloud projects remove-iam-policy-binding "$PROJECT" \
--member serviceAccount:"$FULL_NODE_SA_NAME" \
--role roles/logging.logWriter > /dev/null

gcloud projects remove-iam-policy-binding "$PROJECT" \
--member serviceAccount:"$FULL_NODE_SA_NAME" \
--role roles/monitoring.metricWriter > /dev/null

gcloud projects remove-iam-policy-binding "$PROJECT" \
--member serviceAccount:"$FULL_NODE_SA_NAME" \
--role roles/monitoring.viewer > /dev/null

gcloud iam service-accounts delete "$FULL_SA_NAME" \
--quiet && rm credentials.json

gcloud iam service-accounts delete "$FULL_NODE_SA_NAME" --quiet