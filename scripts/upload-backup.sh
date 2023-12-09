#!/bin/bash

set -eu

# Allow sudo crontab to find ~/.aws/
export HOME="${HOME:=/home/pi}"

DATE=$(TZ=GMT date +"%Y%m%d")
DIR="/mnt/ssd/"
FILE="hom-mc-server-$DATE.zip"
BUCKET_DIR="s3://public-files.chrislewis.me.uk/chunky-fargate/worlds"

if pgrep -x java >/dev/null
then
    sleep 1
else
    echo ">>> java is not running, world might not be launchable"
    exit 1
fi

cd $DIR

echo ">>> Removing zips"
rm -rf ./*.zip

echo ">>> Updating ownership"
chown -R pi $DIR

echo ">>> Creating zip"
zip -r $FILE .

SIZE=$(stat -c '%s' $FILE | numfmt --to=si --suffix=B)
echo ">>> Size: $SIZE"

echo ">>> Uploading"
/usr/local/bin/aws s3 cp $FILE "$BUCKET_DIR/"

echo ">>> Moving"
mv $FILE /home/pi/last.zip

echo "$(date)" >> upload-backup.log
echo ">>> Complete"
