#!/usr/bin/bash
# Get Options

# This should be done with getopt or by scanning the server. For now configure statically.
NOOBS_VERSION="v2_3_0"
# This stuff should be calculated somehow
NOOBS_FOLDER="NOOBS-2017-03-03"

# This Stuff should never change
NOOBS_DNLD_SERVER="http://downloads.raspberrypi.org/NOOBS/images"

# Shortcut Variables
NOOBS_FILE="NOOBS_$NOOBS_VERSION.zip"
NOOBS_DIR="NOOBS_$NOOBS_VERSION"

############################################################
# 0. Setup Work Environment
############################################################
# Make a place to hold noobs downloads
if [ ! -d noobs_zips ]
then
  mkdir noobs_zips
fi
# Make a place to hold noobs extracted images
if [ ! -d noobs_extracts ]
then
  mkdir noobs_extracts
fi
# Make a place to hold created noobs images files
if [ ! -d noobs_images ]
then
  mkdir noobs_images
fi

##############################################################
# 1. Get NOOBS From Raspi Foundation
##############################################################
if [ -f noobs_zips/NOOBS_v2_3_0.zip ]
then
   echo "Already Got NOOBS Image ... Moving On"
else
   DNLD_TARGET=$NOOBS_DNLD_SERVER/$NOOBS_FOLDER/$NOOBS_FILE
   echo "Downloading NOOBS from $DNLD_TARGET"
   wget --show-progress --progress=bar -o noobs_zips/$NOOBS_FILE.downloadlog -O noobs_zips/$NOOBS_FILE $DNLD_TARGET
fi


##############################################################
# 2. Unzip Noobs Onto Local File System
##############################################################
rm -rf noobs_extracts/$NOOBS_DIR
mkdir noobs_extracts/$NOOBS_DIR
pushd noobs_extracts/$NOOBS_DIR
unzip ../../$NOOBS_FILE
popd

# 3. Work Out How Big NOOBS Is
## du -sh NOOBS_v2_3_0
$IMG_FILE_SIZE=$(du -s --block-size=1024 noobs_zips | awk -e '{print $1}')

# 3. Create an empty file that's the right size to hold NOOBS

# 4. Create a loopback device that points to the file

# 5. Create a 100% FAT32 Parition In The File

# 6. Format The Partition

# 7. Mount the New Filesystem / Partition

# 8. Unzip NOOBS into the New Filesystem

# 9. Unmount The New File System

# 10. Disconnect The Loopback Driver From The File

# 11. Happy Days. We're Done.


