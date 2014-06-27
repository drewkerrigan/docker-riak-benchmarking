#! /bin/bash

image=$1 && shift
port=$1 && shift
test_uri=$1 && shift
test_value=$1 && shift
options=$1 && shift

if docker ps -a | grep "$image" >/dev/null; then
  echo ""
  echo "It looks like you already have some containers running with image=$image."
  echo "Please take them down before attempting to bring up another"
  echo "container with the following command:"
  echo ""
  echo "  make stop"
  echo ""

  exit 1
fi

echo
echo "Bringing up container:"
echo

docker run $options $image > /dev/null 2>&1

CONTAINER_ID=$(docker ps | egrep "$image" | cut -d" " -f1)
CONTAINER_PORT=$(docker port "${CONTAINER_ID}" $port | cut -d ":" -f2)

echo "Attepmting to contact http://localhost:${CONTAINER_PORT}/$test_uri"

until curl -s "http://localhost:${CONTAINER_PORT}/$test_uri" | grep "$test_value" > /dev/null 2>&1;
do
	echo "Waiting..."
	sleep 3
done

echo "  Successfully brought up container ${CONTAINER_ID} at (http://localhost:${CONTAINER_PORT}/$test_uri)"
