#!/bin/bash

base_control_port=15000

TOR_INSTANCES="$1"

if [ ! $TOR_INSTANCES ] || [ $TOR_INSTANCES -lt 1 ]; then
    echo "Please supply an instance count"
    echo "Example: ./tor_newid.sh 5"
    exit 1
fi

for i in $(seq $TOR_INSTANCES)
do
	control_port=$((base_control_port+i))

    ./tor_newid.exp $control_port
done
