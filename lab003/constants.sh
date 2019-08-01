#!/bin/bash -e

gcloud config set compute/region asia-east1
gcloud config set compute/zone asia-east1-b

PROJECT=$(gcloud config get-value core/project)
export PROJECT

INSTANCE_REGION=$(gcloud config get-value compute/region)
export INSTANCE_REGION

CLUSTER_ZONE=$(gcloud config get-value compute/zone)
export CLUSTER_ZONE

CLUSTER_NAME=mysql-demo-cluster
export CLUSTER_NAME

export SA_NAME=mysql-demo-sa
export FULL_SA_NAME=$SA_NAME@$PROJECT.iam.gserviceaccount.com

export NODE_SA_NAME=mysql-demo-node-sa
export FULL_NODE_SA_NAME=$NODE_SA_NAME@$PROJECT.iam.gserviceaccount.com