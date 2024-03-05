#!/bin/bash

set -e
set -o pipefail

cd /var/www/html/helm-charts/

sudo helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
sudo helm pull rancher-latest/rancher

sudo helm pull oci://registry-1.docker.io/bitnamicharts/apache

echo -n "Please type in the ip of the host: "
read ip_address

sudo helm repo index . --url "http://$ip_address:8092/"

echo "Complete\n Try to do curl http://$ip_address:8092/index.yaml"