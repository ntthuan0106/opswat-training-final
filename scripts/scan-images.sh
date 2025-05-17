#!/bin/bash

set -e

IMAGE_LIST_FILE="trivy/scan-image-list.yml"
REPORT_DIR="trivy/report"

mkdir -p "$REPORT_DIR"

images=$(grep '^- ' "$IMAGE_LIST_FILE" | sed 's/^- //')

for image in $images; do
  if [[ "$image" == *":"* ]]; then
    name=$(echo "$image" | cut -d: -f1)
    tag=$(echo "$image" | cut -d: -f2-)
  else
    name="$image"
    tag="latest"
  fi

  # Đường dẫn file output trên host
  host_output_file="${REPORT_DIR}/trivy-${name//\//-}-${tag}.json"
  # Đường dẫn file output trên container (bắt buộc là absolute)
  container_output_file="/tmp/report/trivy-${name//\//-}-${tag}.json"

  echo "Scanning image $image ..."

  docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$(pwd)/$REPORT_DIR":/tmp/report \
    aquasec/trivy:latest image --quiet --format json -o "$container_output_file" "$image"
done

echo "Scan completed. Reports saved to $REPORT_DIR."
