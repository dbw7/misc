#!/bin/bash

# Function to execute command and echo on failure
execute_and_echo() {
    if ! "$@"; then
        echo "Command failed: $*"
    fi
}

execute_and_echo sudo rm -r /etc/apache2/
execute_and_echo sudo rm -r /var/www/html/helm-charts

execute_and_echo sudo apt --purge remove apache2 -y
execute_and_echo sudo apt autoremove -y


execute_and_echo helm repo remove rancher-latest
