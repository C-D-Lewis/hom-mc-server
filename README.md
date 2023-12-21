# hom-mc-server

SCM controlled configuration for the Heroes of Mirren Minecraft Server.

> Note: All `.jar` files must be at same level as `world`.

## Prepare

Put world files in `world`, then launch with `scripts/start.sh`.

## Configure

Configuration is stored in `server.properties`.

## Automation

### Local backup

Backup the server locally to `/mnt/usb`:

`./scripts/local-backup.sh`

### AWS S3 backup

Backup the server to an AWS S3 bucket:

`./scripts/upload-backup.sh`

See `scripts/crontab.txt` for template crontab to automate these.
