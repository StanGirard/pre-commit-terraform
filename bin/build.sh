#!/bin/sh
set -e

function docker_tag_exists() {
    TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_PASS}'", "password": "'${DOCKER_USER}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
    curl --silent -f --head -lL https://hub.docker.com/v2/repositories/$1/tags/$2/ >/dev/null
}
export VERSIONCORE=$(cat VERSION-CORE)
echo "$DOCKER_PASS" | docker login --username "$DOCKER_USER" --password-stdin
cat VERSION | while read l; do
    if docker_tag_exists stangirard/pre-commit-terraform "$l"-"$VERSIONCORE"; then
        echo "Tag Already Exists: $l-$VERSIONCORE"
    else
        docker buildx build --platform linux/amd64 --build-arg RELEASE="$l" -t stangirard/pre-commit-terraform:"$l"-"$VERSIONCORE" .
        docker tag stangirard/pre-commit-terraform:"$l"-"$VERSIONCORE" stangirard/pre-commit-terraform:"$l"-latest
        docker push stangirard/pre-commit-terraform:"$l"-"$VERSIONCORE"
        docker push stangirard/pre-commit-terraform:"$l"-latest
    fi
done
