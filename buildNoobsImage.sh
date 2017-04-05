#!/bin/bash
# Get Options

# This should be done with getopt or by scanning the server. For now configure statically.
NOOBS_VERSION="v2_3_0"
# This stuff should be calculated somehow
NOOBS_FOLDER="NOOBS-2017-03-03"

# This Stuff should never change
NOOBS_DNLD_SERVER="http://downloads.raspberrypi.org/NOOBS/images"

# Shortcut Variables
NOOBS_FILE="NOOBS_$NOOBS_VERSION.zip"
NOOBS_IMG="NOOBS_$NOOBS_VERSION.img"

############################################################
# 0. Setup Work Environment
############################################################
# Make a place to hold noobs downloads
if [ ! -d noobs_zips ]
then
  mkdir noobs_zips
fi

# Make a place to hold created noobs images files
if [ ! -d noobs_images ]
then
  mkdir noobs_images
fi

##############################################################
# 1. Get NOOBS From Raspi Foundation
##############################################################
if [ -f noobs_zips/$NOOBS_FILE ]
then
   echo "Already Downloaded NOOBS .zip ... Moving On ..."
else
   DNLD_TARGET=$NOOBS_DNLD_SERVER/$NOOBS_FOLDER/$NOOBS_FILE
   echo "Downloading NOOBS from $DNLD_TARGET"
   wget --show-progress --progress=bar -o noobs_zips/$NOOBS_FILE.downloadlog -O noobs_zips/$NOOBS_FILE $DNLD_TARGET
fi


############################################################
# 2. Work Out How Big NOOBS Is.
#    Add 20% for file system overheads.
############################################################
# Get uncompressed size in kB
IMG_FILE_SIZE=$(unzip -l noobs_zips/$NOOBS_FILE | tail -n 1 | awk '{print int($1/1024)}')
IMG_FILE_SIZE=$(echo $IMG_FILE_SIZE | awk '{print int($1*1.2)}')
IMG_FILE_SIZE_HUMAN=$(echo $IMG_FILE_SIZE | awk '{print $1/(1024*1024)}')
echo "NOOBS Image file will be $IMG_FILE_SIZE_HUMAN G"

############################################################
# 3. Create an empty file that's the right size to hold NOOBS
############################################################
echo "Building raw image file ... give me a minute ..."
rm -f noobs_images/$NOOBS_IMG
dd if=/dev/zero of=noobs_images/$NOOBS_IMG bs=1024 count=$IMG_FILE_SIZE

############################################################
# 4. Create a loopback device that points to the file
############################################################
loopDevice=`losetup -f`
echo "Creating loopback device on" $loopDevice
sudo losetup $loopDevice noobs_images/$NOOBS_IMG

############################################################
# 5. Create a 100% FAT32 Parition In The File
############################################################
echo "Partitioning the loopback device"
sudo parted -s $loopDevice mklabel msdos
sudo parted -s $loopDevice -a optimal mkpart primary fat32 0% 100%
sudo parted -s $loopDevice set 1 boot on

############################################################
# 6. Format The Partition
############################################################
echo "Formatting the partition"
p1="p1"
sudo mkfs.msdos $loopDevice$p1

############################################################
# 7. Mount the New Filesystem / Partition
############################################################
echo "Mounting the filesystem"
sudo rm -rf /mnt/NOOBS
sudo mkdir /mnt/NOOBS
sudo mount $loopDevice$p1 /mnt/NOOBS

############################################################
# 8. Unzip NOOBS into the New Filesystem
############################################################
echo "Unzipping NOOBS into the loopback filesystem"
HERE=$PWD
pushd /mnt/NOOBS
sudo unzip -qq $HERE/noobs_zips/$NOOBS_FILE
popd 

############################################################
# 9. Unmount The New File System
############################################################
echo "Unmounting ..."
sudo umount /mnt/NOOBS
sudo rm -rf /mnt/NOOBS

############################################################
# 10. Detach The Loopback Driver From The File
############################################################
echo "Detach from the loopback driver"
sudo losetup -d $loopDevice

############################################################
# 11. Happy Days. We're Done.
############################################################
echo "NOOBS Image file created at noobs_images/$NOOBS_IMG"

