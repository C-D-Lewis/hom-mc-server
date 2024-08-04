#!/bin/bash

set -eu

OUTPUT_FILE="hom-mc-server.zip"

echo ">>> Removing zips"
rm -rf ./*.zip

echo ">>> Updating ownership"
chown -R pi ./

echo ">>> Creating zip"
zip -r $OUTPUT_FILE .

size=$(stat -c '%s' $OUTPUT_FILE | numfmt --to=si --suffix=B)
echo ">>> Size: $size"
