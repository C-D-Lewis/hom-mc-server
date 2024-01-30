#!/bin/bash

set -eu

ROOT_DIR="/mnt/nvme/"
OUT_DIR="/mnt/usb/backup/"
FILE="hom-mc-server.tar"

if pgrep -x java >/dev/null
then
    sleep 1
else
    echo ">>> java is not running, world might not be launchable"
    exit 1
fi

echo ">>> Updating ownership"
chown -R pi $ROOT_DIR

cd $ROOT_DIR

echo ">>> Creating archive"
tar cf $FILE "$ROOT_DIR/hom-mc-server"

SIZE=$(stat -c '%s' $FILE | numfmt --to=si --suffix=B)
echo ">>> Size: $SIZE"

echo ">>> Moving"
mv $FILE $OUT_DIR

echo "$(date)" >> local-backup.log
echo ">>> Complete"
