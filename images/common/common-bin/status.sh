#!/bin/bash

image=$1 && shift
port=$1 && shift
test_uri=$1 && shift
test_value=$1 && shift

CONTAINER_ID=$(docker ps | egrep "$image" | cut -d" " -f1)
CONTAINER_PORT=$(docker port "${CONTAINER_ID}" $port | cut -d ":" -f2)

if curl -s "http://localhost:${CONTAINER_PORT}/$test_uri" | grep "$test_value" > /dev/null 2>&1;
then 
    echo; echo "   A container with image=$image is currently running at [http://localhost:${CONTAINER_PORT}/$test_uri]"; echo
else
    echo; echo "   No containers with image=$image are running"; echo
fi