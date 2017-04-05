# NoobsImageBuilder
Build a .img file from a NOOBS .zip so you can blow it onto a RaspberryPi using dd.

This tool downloads a specific version of the NOOBS .zip distribution from the RASPI foundation, and creates a small .img file that can be loaded straight onto a factory bought microsd card. It's intended to be used with bulk card programmers, etc.

# How to create a NOOBS image
1. Navigate to http://downloads.raspberrypi.org/NOOBS/images/ and check for the latest version of NOOBS.
2. Open the script buildNoobsImage.sh and enter the release-date version of NOOBS that you want into the variable NOOBS_FOLDER
3. Click through into the NOOBS version that you want on downloads.raspberrypi.org and note the NOOBS **version** that you want eg v2_3_0. Copy this information into the NOOBS_VERSION variable in the script.
4. Run the script. The NOOBS image will be created in ../NoobsImageBuilder/noobs_images/

# If you've run this script on a Raspberry Pi
Get the image off the Pi with a flashdrive / shared folder.
If you're using an NTFS formatted flash drive, make sure you execute `sudo apt-get update && sudo apt-get install ntfs-3g` otherwise you won't be able to write to the flash drive.

#
Built by the beautiful Pacific Ocean in Newcastle, Australia by http://switchdin.com in collaboration with http://core-electronics.com.au.

Use and abuse as you see fit, but drop us a line to let us know if this was useful for you. If you have some new feature or cutting edge addition, please share it with us.

Cheers!
