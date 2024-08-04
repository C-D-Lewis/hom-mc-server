#!/bin/bash

set -eu

ROOT_DIR="/mnt/nvme/hom-mc-server"
OUT_DIR="/mnt/usb/backup/"
DOW=$(date +'%A')
OUTPUT_FILE="hom-mc-server-$DOW.zip"

# Server must be running successfully
if pgrep -x java > /dev/null
then
  sleep 1
else
  echo ">>> java is not running, world might not be launchable"
  exit 1
fi

cd $ROOT_DIR

./scripts/create-zip.sh
mv "hom-mc-server.zip" "$OUTPUT_FILE"

echo ">>> Moving"
mv $OUTPUT_FILE $OUT_DIR

echo "$(date)" >> local-backup.log
echo ">>> Complete"
