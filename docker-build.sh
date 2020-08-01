#!/bin/bash
#set -x
source sha_function.sh

if [ $# -le 1 ]; then
    echo "missing parameters."
    exit 1
fi

sha=$(get_manifest_sha $@)       # $1 treehouses/nginx:latest  amd64|arm|arm64
echo $sha
base_image="treehouses/nginx@$sha"
echo $base_image
arch=$2   # arm arm64 amd64

if [ -n "$sha" ]; then
        tag=treehouses/musicblocksjs-tags:$arch
        #sed "s|{{base_image}}|$base_image|g" Dockerfile.template > /tmp/Dockerfile.$arch
        sed "s|{{base_image}}|$base_image|g" Dockerfile.template > Dockerfile.$arch
        #cat /tmp/Dockerfile.$arch
        docker build -t $tag -f Dockerfile.$arch .
       # version=$(docker run -it $tag /bin/sh -c "nginx -v" |awk '{print$3}')
       # echo "$arch nginx version is $version"
        docker push $tag
fi
