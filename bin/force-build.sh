#!/bin/sh
set -e

export VERSIONCORE=$(cat VERSION-CORE)
echo "$DOCKER_PASS" | docker login --username "$DOCKER_USER" --password-stdin
cat VERSION | while read l; do
    docker buildx build --platform linux/amd64 --build-arg RELEASE="$l" -t stangirard/pre-commit-terraform:"$l"-"$VERSIONCORE" .
    docker push stangirard/pre-commit-terraform:"$l"-"$VERSIONCORE"
done
