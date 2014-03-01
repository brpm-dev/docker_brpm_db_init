#!/bin/bash
if [ "$(ls -A /data)" ]; then
  if [ "$OVERWRITE_EXISTING_DATA" == "1" ]; then
    echo "Data directory is not empty but OVERWRITE_EXISTING_DATA flag is activated so deleting the existing files"
    rm -rf /data/*
  else
    echo "Data directory is not empty, leaving it as it is."
    exit 1
  fi
fi

cp -R /var/lib/pgsql/data/* /data