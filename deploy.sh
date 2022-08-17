#!/usr/bin/env bash

docker build -t bbbi -f Dockerfile .
docker tag bbbi ghcr.io/bb128b/bb-base-image:latest
docker push ghcr.io/bb128b/bb-base-image:latest