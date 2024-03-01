#!/bin/bash

set -e

set -o pipefail

if ! type docker >/dev/null 2>&1; then
    echo "Docker is not installed. Exiting."
    exit 1
fi

if ! type helm >/dev/null 2>&1; then
    echo "Helm is not installed. Exiting."
    exit 1
fi

sudo mkdir -p ~/dockerconf
sudo htpasswd -Bcb ~/dockerconf/docker.pass user root

sudo docker run -d \
  -p 5000:5000 \
  --name registry \
  -v ~/dockerconf:/certs \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e "REGISTRY_AUTH_HTPASSWD_PATH=/certs/docker.pass" \
  registry:2.7
