#!/bin/bash

set -eu

DIR="/mnd/ssd/"
FILE="hom-mc-server.tar"

print ">>> Updating ownership"
chown -R pi $DIR

cd $DIR

print ">>> Creating archive"
tar cf $FILE "$DIR/hom-mc-server"

print ">>> Moving"
mv $FILE /mnt/usb/backup/

print ">>> Complete"
