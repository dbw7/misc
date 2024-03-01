#!/bin/bash

# Function to execute command and echo on failure
execute_and_echo() {
    output=$("$@" 2>&1)
    result=$?
    if [ $result -ne 0 ]; then
        echo "Command failed: $*"
        echo "Output:"
        echo "$output"
    fi
}

execute_and_echo sudo rm -r /etc/apache2/
execute_and_echo sudo rm -r /var/www/html/helm-charts

execute_and_echo sudo apt --purge remove apache2 -y
execute_and_echo sudo apt autoremove -y


execute_and_echo helm repo remove rancher-latest
execute_and_echo helm repo remove local-repo
