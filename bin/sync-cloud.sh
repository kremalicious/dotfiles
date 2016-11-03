#!/usr/bin/env bash

#
# Prerequisite:
# rclone configured with remote Amazon Cloud Drive named `amazon`
#
# brew install rclone
# rclone config

# http://rclone.org/commands/rclone_copy/
# http://rclone.org/commands/rclone_sync/

# Sync Movies
rclone sync $MOVIES_DIR amazon:/Movies --update

# Sync TV Shows
rclone sync $TVSHOWS_DIR amazon:/TV\ Shows --update
