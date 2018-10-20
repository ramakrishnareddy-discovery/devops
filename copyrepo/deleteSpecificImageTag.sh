#!/usr/bin/env sh

# Docker Image deletion is two step process. 1) delete image tag 2) delete respective(whose tag already deleted) image. 
# STEP 1) ./<CURRENT_SCRIPT_NAME>.sh 10.0.31.225:5000 CLIENT-ms-demandplanner 0.snapshot.89
# SETP 2) docker exec -it registry bin/registry garbage-collect /etc/docker/registry/config.yml

if [ "$#" -eq "0" ] || [ "$1" == "-?" ] || [ "$1" == "--help" ];then
    echo "Usage: `basename $0` <DOCKER_PRIVATE_REGISTRY_IP:PORT> <BINARY_NAME> <TAG>"
    echo "e.g. `basename $0` 10.0.31.225:5000 CLIENT-ms-demandplanner 0.snapshot.89"
    exit 1
fi

curl -v -sSL -X DELETE "http://${1}/v2/${2}/manifests/$(
    curl -sSL -I \
        -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        "http://${1}/v2/${2}/manifests/${3}" \
    | awk '$1 == "Docker-Content-Digest:" { print $2 }' \
    | tr -d $'\r' \
)"