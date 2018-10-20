
#!/usr/bin/env sh
# This Script output the docker image tag
set -e
if [ "$#" -eq "0" ] || [ "$1" == "-?" ] || [ "$1" == "--help" ];then
    echo "Usage: `basename $0` <DOCKER_PRIVATE_REGISTRY_IP:PORT> <BINARY_NAME>"
    echo "e.g. `basename $0` 10.0.31.225:5000 qualcomm-ms-demandplanner"
    exit 1
fi
curl -v -sSL -X GET "http://${1}/v2/${2}/manifests/$(
    curl -sSL -I \
        -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        "http://${1}/v2/${2}/manifests/$(
            curl -sSL "http://${1}/v2/${2}/tags/list" | jq -r '.tags[0]'
        )" \
    | awk '$1 == "Docker-Content-Digest:" { print $2 }' \
    | tr -d $'\r' \
)"
