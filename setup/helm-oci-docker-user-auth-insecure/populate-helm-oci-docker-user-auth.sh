#!/bin/bash

set -e
set -o pipefail


if ! type helm >/dev/null 2>&1; then
    echo "Helm is not installed. Exiting."
    exit 1
fi

mkdir ~/charts
cd ~/charts

sudo helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
sudo helm pull rancher-latest/rancher

sudo helm pull oci://registry-1.docker.io/bitnamicharts/apache

echo -n "Please type in the ip of the host: "
read ip_address

helm registry login http://$ip_address:5000 --username user --password root --insecure

helm push rancher-2.*.tgz oci://$ip_address:5000/rancher --plain-http
helm push apache-*.tgz oci://$ip_address:5000/apache --plain-http

echo "Complete, try:
curl -u "user:root" http://$ip_address:5000/v2/_catalog"