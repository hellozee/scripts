#!/bin/bash

touch /etc/udev/rules.d/80-net-name-slot.rules

service networking restart

wpa_supplicant -B -i wlan0 -c /etc/wpa.conf -Dwext

dhclient wlan0

ifconfig wlan0 

