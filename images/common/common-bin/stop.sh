#! /bin/bash

image=$1 && shift

docker ps -a | egrep "$image" | cut -d" " -f1 | xargs -I{} bash -c 'docker rm -f "$@"' _ {} > /dev/null 2>&1

echo "Stopped and cleared all containers with image=$image."
