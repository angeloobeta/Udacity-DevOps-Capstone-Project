#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath="angeloobeta/django-capstone-app"


# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
# docker login --username angeloobeta
docker image tag django-capstone-app:latest ifeanyichukwu-capstone-django-app  $dockerpath

# Step 3:
# Push image to a docker repository
docker push $dockerpath


# docker tag django_capstone_project:latest udacity-django-project angeloobeta/django_capstone_project