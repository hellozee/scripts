#!/bin/bash

sudo mount --types proc /proc /mnt/os/proc 
sudo mount --rbind /sys /mnt/os/sys
sudo mount --make-rslave /mnt/os/sys 
sudo mount --rbind /dev /mnt/os/dev 
sudo mount --make-rslave /mnt/os/dev
