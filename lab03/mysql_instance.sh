#!/bin/bash -e

set -o errexit

# This command is using the --async flag because it generally takes too long
# to finish and causes gcloud to time out. The loop in the next section is
# used to wait for the instance to reach a good state
gcloud sql instances create "$INSTANCE_NAME" \
--database-version MYSQL_5_7 \
--region "$INSTANCE_REGION" \
--tier db-f1-micro \
--async > /dev/null

echo "Cloud SQL instance creation started. This process takes a long time (5-10min)."

# Running a loop to wait for the Cloud SQL instance to become "RUNNABLE"
COUNTER=61
until [  $COUNTER -lt 2 ]; do
  echo "Waiting for instance to finish starting.."
  if gcloud sql instances describe "$INSTANCE_NAME" \
  --format="default(state)" | grep RUNNABLE; then
    break
  fi
  sleep 10
  COUNTER=$(( COUNTER - 1 ))
done

if [ $COUNTER -lt 2 ]; then
  echo "Cloud SQL instance creation timed out"
  exit 1
fi

# Making a MySQL user that is allowed to connect from any host
gcloud sql users create root \
--host '%' \
--instance "$INSTANCE_NAME" \
--password "$DB_ROOT_PASSWORD"

gcloud sql users create "$DB_USER" \
--host '%' \
--instance "$INSTANCE_NAME" \
--password "$DB_PASSWORD"