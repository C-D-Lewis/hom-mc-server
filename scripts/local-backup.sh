#!/bin/bash

set -eu

FILE="hom-mc-server.tar"

cd /mnt/ssd
tar cf $FILE /mnt/ssd/hom-mc-server
mv $FILE /mnt/usb/backup/
