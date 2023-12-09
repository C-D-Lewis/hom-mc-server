#!/bin/bash

set -eu

DATE=$(TZ=GMT date +"%Y%m%d")
FILE="hom-mc-server-$DATE.zip"
BUCKET_DIR="s3://public-files.chrislewis.me.uk/chunky-fargate/worlds"

print ">>> Removing zips"
rm -rf ./*.zip

print ">>> Creating zip"
zip -r $FILE . || true # Some files could not be read

print ">>> Uploading"
/usr/local/bin/aws s3 cp $FILE "$BUCKET_DIR/"

print ">>> Moving"
mv $FILE /home/pi/last.zip

print ">>> Complete"
