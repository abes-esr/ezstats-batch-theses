#!/bin/sh

# https://crontab.guru/#0_0_*_*_*
{ echo ""; \
  echo "# EZP Bulk"; \
  echo "0 2 * * * /home/node/launch-ezp.sh 1>/proc/1/fd/1 2>/proc/1/fd/2"; \
  echo "# EZM"; \
  echo "0 6 * * * /home/node/launch-ezm.sh $EZMESURE_TOKEN 1>/proc/1/fd/1 2>/proc/1/fd/2" ; \
	} | crontab -

# start cron
echo "Starting EZP bulk cron and EZM cron..."
#service cron start
cron -f