#!/bin/bash
#making script to stop on 1st error
set -e

# Original script from
# http://blog.databigbang.com/distributed-scraping-with-multiple-tor-circuits/

base_socks_port=9050
base_control_port=15000

# Create data directory if it doesn't exist
if [ ! -d "data" ]; then
	mkdir "data"
fi

TOR_INSTANCES="$1"

if [ ! $TOR_INSTANCES ] || [ $TOR_INSTANCES -lt 1 ]; then
    echo "Please supply an instance count"
    echo "Example: ./multi-tor.sh 5"
    exit 1
fi

for i in $(seq $TOR_INSTANCES)
do
	j=$((i+1))
	socks_port=$((base_socks_port+i))
	control_port=$((base_control_port+i))
	if [ ! -d "data/tor$i" ]; then
		echo "Creating directory data/tor$i"
		mkdir "data/tor$i"
	fi

	# Take into account that authentication for the control port is disabled. Must be used in secure and controlled environments
	echo "Running: tor --RunAsDaemon 1 --CookieAuthentication 0 --HashedControlPassword \"\" --ControlPort $control_port --PidFile tor$i.pid --SocksPort $socks_port --DataDirectory data/tor$i"

	tor --RunAsDaemon 1 --CookieAuthentication 0 --HashedControlPassword "" --ControlPort $control_port --PidFile tor$i.pid --SocksPort $socks_port --DataDirectory data/tor$i
done
