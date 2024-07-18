#!/bin/bash

set -eu

# Allow sudo crontab to find ~/.aws/
export HOME="${HOME:=/home/pi}"

DATE=$(TZ=GMT date +"%Y%m%d")
ROOT_DIR="/mnt/nvme/hom-mc-server"
OUTPUT_FILE="hom-mc-server-$DATE.zip"
S3_BUCKET_DIR="s3://public-files.chrislewis.me.uk/chunky-fargate/worlds"

# Test local backup
# ./scripts/test-local-backup.sh

# Server must be running successfully
if pgrep -x java >/dev/null
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

echo ">>> Uploading"
/usr/local/bin/aws s3 cp $OUTPUT_FILE "$S3_BUCKET_DIR/"

echo ">>> Copying to latest"
/usr/local/bin/aws s3 cp "$S3_BUCKET_DIR/$OUTPUT_FILE" "$S3_BUCKET_DIR/hom-mc-server-latest.zip"

echo ">>> Cleaning up"
rm -rf $OUTPUT_FILE

echo "$(date)" >> upload-backup.log
echo ">>> Complete"
