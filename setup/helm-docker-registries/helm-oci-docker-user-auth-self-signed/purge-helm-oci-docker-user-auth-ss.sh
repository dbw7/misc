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


execute_and_echo sudo rm -r ~/dockerconf
execute_and_echo sudo rm -r ~/charts

execute_and_echo sudo docker stop registry
execute_and_echo sudo docker rm registry

echo -n "Please type in the ip of the host: "
read ip_address

helm registry logout https://$ip_address:5000