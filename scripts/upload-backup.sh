#!/bin/bash

set -eu

DATE=$(TZ=GMT date +"%Y%m%d")
FILE="hom-mc-server-$DATE.zip"
BUCKET_DIR="s3://public-files.chrislewis.me.uk/chunky-fargate/worlds"

rm -rf ./*.zip
zip -r $FILE .
/usr/local/bin/aws s3 cp $FILE "$BUCKET_DIR/"
mv $FILE /home/pi/last.zip
