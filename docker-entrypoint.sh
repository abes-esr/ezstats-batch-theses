#!/bin/sh

# https://crontab.guru/#0_0_*_*_*
{ echo ""; \
  echo "# EZP Bulk"; \
  echo "0 0 * * * /home/node/launch-ezp.sh 1>/proc/1/fd/1 2>/proc/1/fd/2"; \
	} | crontab -

# start cron
echo "Starting EZP bulk cron..."
#service cron start
cron -f