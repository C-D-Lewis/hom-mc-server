#!/bin/bash

# Build the image
docker build -t hom-mc-server .

# Make sure the world directory exists to mount and persist to
mkdir -p world

# Run the image with exposed port and mounted world directory
docker run --rm -p 25565:25565 -v ./world:/server/world -t hom-mc-server
