#!/bin/bash

set -e
set -o pipefail

sudo rm -r /var/www/html/helm-charts
sudo rm -r /etc/apache2/sites-available

sudo apt --purge remove apache2 -y
sudo apt autoremove -y

helm repo remove rancher-latest