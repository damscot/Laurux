#!/bin/bash

echo "Service Start"
sudo service mysql start
sudo service ssh start

echo "User Remap"
source /user-mapping.sh

echo "Running $@" 
exec su - "${USER}" -c "$@"
