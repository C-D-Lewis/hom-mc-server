#!/bin/bash

set -eu

DATE=$(TZ=GMT date +"%Y%m%d")
FILE="hom-mc-server-$DATE.zip"
BUCKET_DIR="s3://public-files.chrislewis.me.uk/chunky-fargate/worlds"

echo ">>> Removing zips"
rm -rf ./*.zip

echo ">>> Creating zip"
zip -r $FILE . || true # Some files could not be read

echo ">>> Uploading"
/usr/local/bin/aws s3 cp $FILE "$BUCKET_DIR/"

echo ">>> Moving"
mv $FILE /home/pi/last.zip

echo "$(date)" >> upload-backup.log
echo ">>> Complete"
