#!/bin/bash

set -eu

DIR="/mnt/ssd/"
FILE="hom-mc-server.tar"

if pgrep -x java >/dev/null
then
    sleep 1
else
    echo ">>> java is not running, world might not be launchable"
    exit 1
fi

echo ">>> Updating ownership"
chown -R pi $DIR

cd $DIR

echo ">>> Creating archive"
tar cf $FILE "$DIR/hom-mc-server"

SIZE=$(stat -c '%s' $FILE | numfmt --to=si --suffix=B)
echo ">>> Size: $SIZE"

echo ">>> Moving"
mv $FILE /mnt/usb/backup/

echo "$(date)" >> local-backup.log
echo ">>> Complete"
