# NoobsImageBuilder
This tool downloads the latest version of the NOOBS distribution from the RASPI foundation, and creates an .img file that can be `dd`'ed straight onto a factory-bought SD card. The point is to put NOOBS onto blank store-bought cards in a way that they will boot automatically - eg. to be used with bulk card programmers, etc.

# How to create a NOOBS image
Navigate to a clean working directory.
Execute the following command: `curl -L https://raw.githubusercontent.com/michaelruppe/NoobsImageBuilder/master/buildNoobsImage.sh | bash`

The script will take some time to download the NOOBS zip and generate a .img

#
Built by the beautiful Pacific Ocean in Newcastle, Australia by http://switchdin.com in collaboration with http://core-electronics.com.au.

Use and abuse as you see fit, but drop us a line to let us know if this was useful for you. If you have some new feature or cutting edge addition, please share it with us.

Cheers!
