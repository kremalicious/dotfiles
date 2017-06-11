#!/usr/bin/env bash
#
#
# Prerequisite:
# rclone configured with:
# - remote Amazon Cloud Drive named `amazon`
# - remote AWS S3 named `s3`
#
# brew install rclone
# rclone config
#
# http://rclone.org/commands/rclone_copy/
# http://rclone.org/commands/rclone_sync/

DEFAULTS_AMAZON='--exclude .DS_Store'

# Sync up Movies
rclone sync "$MOVIES_DIR" amazon:/Movies "$DEFAULTS_AMAZON"

# Sync up TV Shows
rclone sync "$TVSHOWS_DIR" amazon:"/TV Shows" "$DEFAULTS_AMAZON"

# Sync up iTunes
rclone sync "$ITUNES_DIR" amazon:/Music/iTunes "$DEFAULTS_AMAZON"

# Sync down all S3 buckets
#rclone sync s3: $S3BACKUP_DIR
