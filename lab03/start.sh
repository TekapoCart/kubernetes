#!/bin/bash -e

# original version: https://github.com/GoogleCloudPlatform/gke-cloud-sql-postgres-demo

help() {
  echo "./start.sh MYSQL_USER"
  ehco "可直接設定密碼或稍後設定"
}

ROOT=$(dirname "${BASH_SOURCE[0]}")

LC_CTYPE=C
RANDOM_SUFFIX=$(tr -dc 'a-z0-9' </dev/urandom | fold -w 6 | head -n 1)
export INSTANCE_NAME=demo-mysql-${RANDOM_SUFFIX}
echo "$INSTANCE_NAME" > "${ROOT}"/.instance

if [ -z "$INSTANCE_NAME" ] ; then
  help
  exit 1
fi

export DB_USER=$1
if [ -z "$DB_USER" ] ; then
  help
  exit 1
fi


INSTANCE_REGION=$(gcloud config get-value compute/region)
CLUSTER_ZONE=$(gcloud config get-value compute/zone)

export INSTANCE_REGION
if [ -z "$INSTANCE_REGION" ]; then
  echo "Make sure that compute/region is set in gcloud config"
  exit 1
fi

export CLUSTER_ZONE
if [ -z "$CLUSTER_ZONE" ]; then
  echo "Make sure that compute/zone is set in gcloud config"
  exit 1
fi

if [ -z "$DB_ROOT_PASSWORD" ]; then
  echo "Enter a password for root"
  read -r DB_ROOT_PASSWORD
  export DB_ROOT_PASSWORD=$DB_ROOT_PASSWORD
fi

if [ -z "$DB_ROOT_PASSWORD" ] ; then
  echo "Password can't be blank or whitespace"
  exit 1
fi

if [ -z "$DB_PASSWORD" ]; then
  echo "Enter a password for $DB_USER"
  read -r DB_PASSWORD
  export DB_PASSWORD=$DB_PASSWORD
fi

if [ -z "$DB_PASSWORD" ] ; then
  echo "Password can't be blank or whitespace"
  exit 1
fi

ROOT=$(dirname "${BASH_SOURCE[0]}")

if "$ROOT"/scripts/prerequisites.sh; then
  "$ROOT"/scripts/enable_apis.sh

  "$ROOT"/scripts/mysql_instance.sh
  "$ROOT"/scripts/service_account.sh

  "$ROOT"/scripts/cluster.sh
  "$ROOT"/scripts/configs_and_secrets.sh

  "$ROOT"/scripts/phpmyadmin_deployment.sh

fi