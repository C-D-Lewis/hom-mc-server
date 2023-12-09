#!/bin/bash

set -eu

DIR="/mnd/ssd/"
FILE="hom-mc-server.tar"

echo ">>> Updating ownership"
chown -R pi $DIR

cd $DIR

echo ">>> Creating archive"
tar cf $FILE "$DIR/hom-mc-server"

echo ">>> Moving"
mv $FILE /mnt/usb/backup/

echo ">>> Complete"
