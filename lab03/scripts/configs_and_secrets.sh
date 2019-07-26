#!/bin/bash -e

# Installing secrets into the Kubernetes cluster
# NOTE：用 private ip 就不需要 credentials.json

kubectl --namespace default create secret generic proxy-sa-creds \
--from-file=credentials.json=credentials.json

kubectl --namespace default create secret generic phpmyadmin-secret \
--from-literal=root-password="$DB_ROOT_PASSWORD" \
--from-literal=user="$DB_USER" \
--from-literal=password="$DB_PASSWORD"


# We can also store non-sensitive information in the cluster (in configmap)
# NOTE：用 private ip 就不需要 connectionname

CONNECTION_NAME=$(gcloud sql instances describe "$INSTANCE_NAME" \
--format="value(connectionName)")

kubectl --namespace default create configmap connectionname \
--from-literal=connectionname="$CONNECTION_NAME"