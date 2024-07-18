#!/bin/bash

set -eu

ROOT_DIR="/mnt/nvme/hom-mc-server"
OUT_DIR="/mnt/usb/backup/"
OUTPUT_FILE="hom-mc-server.zip"

# Server must be running successfully
if pgrep -x java > /dev/null
then
  sleep 1
else
  echo ">>> java is not running, world might not be launchable"
  exit 1
fi

cd $ROOT_DIR

echo ">>> Removing zips"
rm -rf ./*.zip

echo ">>> Updating ownership"
chown -R pi $ROOT_DIR

echo ">>> Creating zip"
zip -r $OUTPUT_FILE .

SIZE=$(stat -c '%s' $OUTPUT_FILE | numfmt --to=si --suffix=B)
echo ">>> Size: $SIZE"

echo ">>> Moving"
mv $OUTPUT_FILE $OUT_DIR

echo "$(date)" >> local-backup.log
echo ">>> Complete"
