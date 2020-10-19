#!/usr/bin/env bash
set -e
source ./replicas.sh

# Description: Stores and manages precise code intelligence bundles.
#
# Disk: 200GB / persistent SSD
# Ports exposed to other Sourcegraph services: 3187/TCP
# Ports exposed to the public internet: none
#
VOLUME="$HOME/sourcegraph-docker/lsif-server-disk"
./ensure-volume.sh $VOLUME 100
docker run --detach \
    --name=precise-code-intel-bundle-manager \
    --network=sourcegraph \
    --restart=always \
    --cpus=2 \
    --memory=2g \
    -e 'SRC_FRONTEND_INTERNAL=sourcegraph-frontend-internal:3090' \
    -v ~/sourcegraph-docker/lsif-server-disk:/lsif-storage \
    index.docker.io/sourcegraph/precise-code-intel-bundle-manager:3.21.0@sha256:ab8072c3cc4b0c00828f39a9c089723ef3344e80270b4d7df626a47bc59c11bc

echo "Deployed precise-code-intel-bundle-manager service"
