#!/usr/bin/env sh

#THIS SCRIPT ACCEPTS COMMA SEPARATED DOCKER IMAGE TAGS AND REMOVE ONE BY ONE.
 
# Docker Image deletion is two step process. 1) delete ALL THE MENTION IMAGE TAGS 2) delete respective(whose tag already deleted) image. 
# STEP 1) ./<CURRENT_SCRIPT_NAME>.sh 10.0.31.225:5000 qualcomm-ms-demandplanner 0.snapshot.89,0.snapshot.90,3.5-10.98
# SETP 2) docker exec -it registry bin/registry garbage-collect /etc/docker/registry/config.yml

set -e
if [ "$#" -eq "0" ] || [ "$1" == "-?" ] || [ "$1" == "--help" ];then
    echo "Usage: `basename $0` <DOCKER_PRIVATE_REGISTRY_IP:PORT> <BINARY_NAME> <TAG>"
    echo "e.g. `basename $0` 10.0.31.225:5000 qualcomm-ms-demandplanner 0.snapshot.89,4.05-12,,3.12.0"
    exit 1
fi

for tagName in $(echo ${3} | sed "s/,/ /g")
do
   echo ""
   echo "
                DOCKER TAG ${tagName} DELETION PROCESS ABOUT TO START"
   echo ""
   curl -v -sSL -X DELETE "http://${1}/v2/${2}/manifests/$(
    curl -sSL -I \
        -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        "http://${1}/v2/${2}/manifests/${tagName}" \
    | awk '$1 == "Docker-Content-Digest:" { print $2 }' \
    | tr -d $'\r' \
   )"
done