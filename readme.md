Modified the provided lab code to display a animated image on the display.

All credit to the original authours. 
Credit for reverse enginering the image format and displaying custom png images goes to Johan Ribom

Usage:

1. Place the images you want to animate in the git repo. 
2. Run python importmany.py
3. Change the frame amount in mipslab.h
4. make && make install to get it on your board

The pythonscript will automaticaly add all .png images inte the directory to the source file.
The frames will be presented in alphabetical order.

This was hacked togheter in an hour, feel free to fork.
