#!/bin/bash


######
## Config Zone
######

screenshotspath=$(pwd) # this can be at the home user
scriptspath=$(pwd) # no the same path screenshotspath

logname=flamecapture.log # this is default
scriptbin=flamecapture.sh # no need to change

uploaderpath=$(pwd)/xbackbone_uploader_user.sh # path to the linux xbackbonescript

######

######
## Generate sh file
######

cat << EOF > $scriptspath/$scriptbin
#!/bin/bash
flameshot gui  --clipboard --path $screenshotspath > $scriptspath/$logname 2>&1
file=\$(find $screenshotspath -type f -printf "%T@ %p\n" | sort -n | tail -1) # more exactly / comment
# file=\$(ls -ltr $ruta |tail -1 | awk '{print $9}') # faster / uncomment
upload=\$(cat $scriptspath/$logname | grep "Screenshot aborted")

if [[ -z "\$upload" ]]
then
	$uploaderpath $screenshotspath/\$file
fi

EOF
