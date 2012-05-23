#!/bin/sh
#
# Set-up Sublime settings + packages sync over Dropbox
#
# Tested on OSX - should support Linux too as long as
# you set-up correct SOURCE folder
#
# Copyright 2012 Mikko Ohtamaa http://opensourcehacker.com
# Licensed under WTFPL
#

# No Warranty! Use on your own risk. Take backup first.

DROPBOX="$HOME/Dropbox"

SYNC_FOLDER="$DROPBOX/Sublime"

# Where Sublime settings have been installed
if [[ `uname` == "Darwin" ]] ; then
        SOURCE="$HOME/Library/Application Support/Sublime Text 2"
else
        echo "Unknown operating system"
        exit 1
fi

# Check that settings really exist on this computer
if [[ ! -e "$SOURCE/Settings/" ]] ; then
        echo "Could not find $SOURCE/Settings/"
        exit 1
fi

# Detect that we don't try to install twice and screw up
if [[ -L "$SOURCE/Settings" ]] ; then
        echo "Dropbox settings already symlinked"
        exit 1
fi

# Dropbox has not been set-up on any computer before?
if [[ ! -e "$SYNC_FOLDER" ]] ; then
        echo "Setting up Dropbox sync folder"
        mkdir "$SYNC_FOLDER"
        cp -r "$SOURCE/Installed Packages/" "$SYNC_FOLDER"
        cp -r "$SOURCE/Packages/" "$SYNC_FOLDER"
        cp -r "$SOURCE/Settings/" "$SYNC_FOLDER"
fi

# Now when settings are in Dropbox delete existing files
rm -rf "$SOURCE/Installed Packages"
rm -rf "$SOURCE/Packages"
rm -rf "$SOURCE/Settings"

# Symlink settings folders from Drobox
ln -s "$SYNC_FOLDER/Installed Packages" "$SOURCE"
ln -s "$SYNC_FOLDER/Packages" "$SOURCE"
ln -s "$SYNC_FOLDER/Settings" "$SOURCE"

