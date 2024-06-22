# hom-mc-server

SCM controlled configuration for the Heroes of Mirren Minecraft Server.

> Note: All `.jar` files must be at same level as `world`.

## Prepare

Put world files in `world`, then launch with `scripts/start.sh`.

Configuration is stored in `server.properties`.

## Run in Docker

> The `scripts/start-docker.sh` builds and runs the container.

Build the image:

```
docker build -t hom-mc-server .
```

Then run a container with exposed port and mounted world directory:

```
docker run -p 25565:25565 -v world:/server/world -t hom-mc-server
```

## Automation

### Local backup

Backup the server locally to `/mnt/usb`:

`./scripts/local-backup.sh`

### AWS S3 backup

Backup the server to an AWS S3 bucket:

`./scripts/upload-backup.sh`

See `scripts/crontab.txt` for template crontab to automate these.
