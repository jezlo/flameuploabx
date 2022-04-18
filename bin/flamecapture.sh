#!/bin/bash
flameshot gui  --clipboard --path /root/Pictures/Screenshots > /root/Repositorios/flameuploabx/bin/flamecapture.log 2>&1
file=$(find /root/Pictures/Screenshots -type f -printf "%T@ %p\n" | sort -n | tail -1 | awk '{print $2}') # more exactly / comment
# file=$(ls -ltr /root/Pictures/Screenshots |tail -1 | awk '{print $9}') # faster / uncomment

captured=$(cat /root/Repositorios/flameuploabx/bin/flamecapture.log | grep "Screenshot aborted")

if [[ -z "$captured" ]]
then
	/root/Pictures/Screenshots/uploader /root/Pictures/Screenshots/$file
fi

