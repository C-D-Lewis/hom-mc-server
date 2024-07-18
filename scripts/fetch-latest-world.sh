#!/bin/bash

set -eu

BUCKET_DIR="s3://public-files.chrislewis.me.uk/chunky-fargate/worlds"

read -p "WARNING: This will erase local world directory and replace with latest from S3 (y/n)?" CONT
if [ "$CONT" != "y" ]; then
  exit 0
fi

echo ">>> Erasing world"
rm -rf ./world

echo ">>> Downloading from S3"
/usr/local/bin/aws s3 cp "$BUCKET_DIR/hom-mc-server-latest.zip" .

echo ">>> Unzipping world"
unzip hom-mc-server-latest.zip -d ./temp
mv ./temp/world .

echo ">>> Cleaning up"
rm -rf ./temp
rm hom-mc-server-latest.zip

echo ">>> Complete"
