#!/bin/bash

set -e
set -u
set -o pipefail

while getopts "e:p:h" opt; do
	case ${opt} in
		e ) essid=$OPTARG
			;;
		p ) pass=$OPTARG
			;;
		h ) echo "Usage: wifi-setup.sh -e ESSID -p PASSWORD"
			;;
		: ) echo "Invalid Option : $OPTARG requires an argument" 1>&2
			;;
	esac
done

echo "ESSID : $essid"
echo "Password : $pass"

wpa_passphrase "$essid" "$pass" > /etc/wpa.conf

shift $((OPTIND -2))
