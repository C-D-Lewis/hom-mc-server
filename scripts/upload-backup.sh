#!/bin/bash

set -eu

# Allow sudo crontab to find ~/.aws/
export HOME="${HOME:=/home/pi}"

DATE=$(TZ=GMT date +"%Y%m%d")
ROOT_DIR="/mnt/nvme/"
FILE="hom-mc-server-$DATE.zip"
BUCKET_DIR="s3://public-files.chrislewis.me.uk/chunky-fargate/worlds"

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
zip -r $FILE .

SIZE=$(stat -c '%s' $FILE | numfmt --to=si --suffix=B)
echo ">>> Size: $SIZE"

echo ">>> Uploading"
/usr/local/bin/aws s3 cp $FILE "$BUCKET_DIR/"

echo ">>> Copying to latest"
/usr/local/bin/aws s3 cp "$BUCKET_DIR/$FILE" "$BUCKET_DIR/hom-mc-server-latest.zip"

echo ">>> Cleaning up"
rm -rf $FILE

echo "$(date)" >> upload-backup.log
echo ">>> Complete"
