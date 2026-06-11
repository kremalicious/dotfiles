#!/usr/bin/env bash
#
# Download a complete website for offline browsing with wget,
# mirroring up to 5 levels deep with all assets and rewritten links
#
# Usage:
# offline-site.sh example.com

wget \
  --recursive \
  --level 5 \
  --no-clobber \
  --page-requisites \
  --adjust-extension \
  --span-hosts \
  --convert-links \
  --restrict-file-names=windows \
  --domains "$1" \
  --no-parent \
    "$1"