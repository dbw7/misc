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

sudo mkdir -p ~/dockerconf/ssl
echo -n "Please type in the ip of the host: "
read ip_address

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout ~/dockerconf/ssl/docker.key -out ~/dockerconf/ssl/docker.crt \
    -subj "/C=US/ST=Random/L=Random/O=Dis/CN=$ip_address"
    -addext "subjectAltName=IP:$ip_address"
    
sudo htpasswd -Bcb ~/dockerconf/docker.pass user root

sudo docker run -d \
  -p 5000:5000 \
  --name registry \
  -v ~/dockerconf:/certs \
  -e "REGISTRY_HTTP_TLS_CERTIFICATE=/certs/ssl/docker.crt" \
  -e "REGISTRY_HTTP_TLS_KEY=/certs/ssl/docker.key" \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e "REGISTRY_AUTH_HTPASSWD_PATH=/certs/docker.pass" \
  registry:2.7
