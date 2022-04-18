#!/bin/bash
configpath() {
	echo "######################"
	echo "suggested path for screenshots: $HOME/Pictures/Screenshots"
	echo "----------------------"
	read -r -p "Please add path to the screenshots: " screenshotspath
}

config() {

	read -r -p "Do you want yo use this path to scripts and log bin? $(pwd) (Y/N) [Y]: " option

	case $option in
		[Yy]* ) 
			scriptspath=$(pwd)
			echo "Path to the bin: "$scriptspath
			;;
		[Nn]* ) 
			read -r -p "Scripts bin and log Path: " scriptspath
			if [[ -d $scriptspath ]]; then
				echo "Script Path: " $scriptspath
			else
				echo "The directory does not exist, it will try to create"
				echo "------------------"
				sleep 1
				mkdir -p $scriptspath > /dev/null 2>&1
				if [[ $? == 0 ]]; then
					echo "created $scriptspath directory"
				else
					echo "Could not create directory"
					echo "###Bye###"
					exit 1
				fi
			fi
	esac
	
	configpath

	while [[ "$screenshotspath" == "$scriptspath" ]]; do
		echo "################# WARNING ##################"
	 	echo "Please don't use the same directory with scripts bin"
	 	configpath
	 done; 
	 if [[ -d $screenshotspath ]]; then
				echo "Path para scripts: " $screenshotspath
			else
				echo "The directory does not exist, it will try to create"
				echo "------------------"
				sleep 1
				mkdir -p $screenshotspath > /dev/null 2>&1
				if [[ $? == 0 ]]; then
					echo "created $screenshotspath directory"
				else
					echo "Could not create directory"
					echo "###Bye###"
					exit 1
				fi
			fi
    read -r -p "Enter the name of the script xbackbone_uploader_user.sh: " uploaderpath
    sleep 1
    if [[ ! -f "$scriptspath/$uploaderpath" ]]; then
    	echo "############# WARNING #################"
    	echo "The file $uploaderpath does not exist "
    	echo "Please put the file ## $uploaderpath ## in the $scriptspath directory and give execution permissions"
    	echo ""
    else 
    	chmod u+x $scriptspath/$uploaderpath
    	echo "------------------------------------"
    	echo "Finalizo la configuración"
    fi
}

config ### Comment to edit variables and uncomment the following variables

######
## Config Zone
######

# screenshotspath=$(pwd) # this can be at the home user
# scriptspath=$(pwd) # no the same path at the screenshotspath
# uploaderpath=$screenshotspath/xbackbone_uploader_user.sh # path to the linux xbackbonescript

logname=flamecapture.log # this is default
scriptbin=flamecapture.sh # no need to change

######

######
## Generate sh file
######

cat << EOF > $scriptspath/$scriptbin
#!/bin/bash
flameshot gui  --clipboard --path $screenshotspath > $scriptspath/$logname 2>&1
file=\$(find $screenshotspath -type f -printf "%T@ %p\n" | sort -n | tail -1 | awk '{print \$2}') # more exactly / comment
# file=\$(ls -ltr $screenshotspath |tail -1 | awk '{print \$9}') # faster / uncomment

captured=\$(cat $scriptspath/$logname | grep "Screenshot aborted")

if [[ -z "\$captured" ]]
then
	$screenshotspath/$uploaderpath $screenshotspath/\$file
fi

EOF

chmod u+x $scriptspath/$scriptbin
echo ""
echo "---------------------------------------------------------"
echo "Add to the keyboard shortcuts this path as print shortcut"
echo $scriptspath/$scriptbin
echo "---------------------------------------------------------"