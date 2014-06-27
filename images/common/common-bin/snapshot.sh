#! /bin/bash

image=$1 && shift

echo
echo "Creating Snapshot of current container with image=$image"
echo

CONTAINER_ID=$(docker ps -a | egrep "$image" | cut -d" " -f1)

docker commit ${CONTAINER_ID} my_snapshot

echo
echo "Running /bin/bash on the snapshot for container_id=${CONTAINER_ID}"
echo

docker run -t -i my_snapshot /bin/bash