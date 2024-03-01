#!/bin/bash

set -e
set -o pipefail

cd /var/www/html/helm-charts/

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm pull rancher-latest/rancher


helm pull oci://registry-1.docker.io/bitnamicharts/apache

echo -n "Please type in the ip of the host: "
read ip_address

helm repo index . --url "http://$ip_address:8092/"

echo "Complete\n Try to do curl -u \"user:root\" http://$ip_address:8092/index.yaml"