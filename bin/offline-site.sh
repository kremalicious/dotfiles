#!/usr/bin/env bash

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