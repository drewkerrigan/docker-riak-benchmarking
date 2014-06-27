#! /bin/bash

image=$1 && shift

docker build -t "$image" .