#!/bin/bash -e

PROJECT=$(gcloud config get-value core/project)
export PROJECT

CLUSTER_ZONE=$(gcloud config get-value compute/zone)

export CLUSTER_ZONE
export CLUSTER_NAME=mysql-demo-cluster

INSTANCE_REGION=$(gcloud config get-value compute/region)
export INSTANCE_REGION

export SA_NAME=mysql-demo-sa
export FULL_SA_NAME=$SA_NAME@$PROJECT.iam.gserviceaccount.com

export NODE_SA_NAME=mysql-demo-node-sa
export FULL_NODE_SA_NAME=$NODE_SA_NAME@$PROJECT.iam.gserviceaccount.com