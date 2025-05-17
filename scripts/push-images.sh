#!/bin/bash

set -e

# Get environment variables or CLI args
DOCKER_USERNAME="${1:-$DOCKER_USERNAME}"
DOCKER_REPO="${2:-$DOCKER_HUB_PRIVATE_REPOSITORY_NAME}"

if [[ -z "$DOCKER_USERNAME" || -z "$DOCKER_REPO" ]]; then
    echo "Usage: ./scripts/push-image.sh <DOCKER_USERNAME> <DOCKER_HUB_PRIVATE_REPOSITORY_NAME>"
    echo "Or set environment variables: DOCKER_USERNAME and DOCKER_HUB_PRIVATE_REPOSITORY_NAME"
    exit 1
fi

TAG_FILE="trivy/tag-images-list.yml"

# Check for yq
if ! command -v yq &> /dev/null; then
    echo "Error: 'yq' is required but not installed. Install it from https://github.com/mikefarah/yq"
    exit 1
fi

destinations=($(yq '.tag-destination[]' "$TAG_FILE"))

# Push each tagged image
for tag in "${destinations[@]}"; do
    full_tag="${DOCKER_USERNAME}/${DOCKER_REPO}:${tag}"
    echo "Pushing $full_tag to Docker Hub..."
    docker push "$full_tag"
done

echo "All images have been pushed successfully."
