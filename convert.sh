#!/bin/bash

fname=$1
name=$(echo $fname | cut -f 1 -d '.')
rate=$(ffmpeg -i filename 2>&1 | sed -n "s/.*, \(.*\) fp.*/\1/p")
mkdir $name
ffmpeg -i $fname -r $rate $name/$name_%05d.png
