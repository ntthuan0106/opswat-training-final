#!/bin/bash

set -e

# Get environment variables or command-line args
DOCKER_USERNAME="${1:-$DOCKER_USERNAME}"
DOCKER_REPO="${2:-$DOCKER_HUB_PRIVATE_REPOSITORY_NAME}"

if [[ -z "$DOCKER_USERNAME" || -z "$DOCKER_REPO" ]]; then
    echo "Usage: ./scripts/tag-images.sh <DOCKER_USERNAME> <DOCKER_HUB_PRIVATE_REPOSITORY_NAME>"
    echo "Or set environment variables: DOCKER_USERNAME and DOCKER_HUB_PRIVATE_REPOSITORY_NAME"
    exit 1
fi

# Parse tag-images-list.yml
TAG_FILE="trivy/tag-images-list.yml"

# Extract sources and destinations using yq (requires yq installed)
if ! command -v yq &> /dev/null; then
    echo "Error: 'yq' is required but not installed. Install it from https://github.com/mikefarah/yq"
    exit 1
fi

sources=($(yq '.images-sources[]' "$TAG_FILE"))
destinations=($(yq '.tag-destination[]' "$TAG_FILE"))

if [[ ${#sources[@]} -ne ${#destinations[@]} ]]; then
    echo "Error: Number of sources and destinations do not match."
    exit 1
fi

# Tag each image
for i in "${!sources[@]}"; do
    src="${sources[$i]}"
    dest="${destinations[$i]}"
    tagged_image="${DOCKER_USERNAME}/${DOCKER_REPO}:${dest}"

    echo "Tagging $src as $tagged_image..."
    docker pull "$src"
    docker tag "$src" "$tagged_image"
done

echo "All images have been tagged successfully."
