#!/bin/bash

set -eu

INPUT_FILE="/mnt/usb/backup/hom-mc-server.tar"
TEST_DIR="/mnt/nvme"
TEST_FILE="test.tar"
JAR="server_1.20.4.jar"

cd $TEST_DIR

# Copy
echo ">>> Copying"
cp $INPUT_FILE "./$TEST_FILE"

# Unzip
tar -xvf "./$TEST_FILE"

cd mnt/nvme/hom-mc-server

# Test launching world
echo ">>> Launching test server"
rm -rf ../../../mnt/nvme/hom-mc-server/world/level.dat
java -Xmx512M -jar $JAR --nogui --port 1337 &
echo ">>> Waiting for launch (60s)"
sleep 60
if [ $(pgrep --count java) -eq "2" ]; then
  echo ">>> Launch OK"

  # Kill test server
  PID=$(ps -e | grep java | sort | awk 'NR==1{print $1}')
  echo ">>> pid=$PID"
  sudo kill $PID
  echo ">>> Killed test server"
else
  echo ">>> Failed to launch new server"
  exit 1
fi

# Clean up
rm -rf "../../../$TEST_FILE" "../../../mnt/"
echo ">>> Cleaned up"
