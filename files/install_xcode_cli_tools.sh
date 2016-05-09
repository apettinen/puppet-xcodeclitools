#!/bin/bash
# Installs Xcode Command Line Tools
# Credits to Tim Sutton for the commands. These are
# taken from:
#https://github.com/timsutton/osx-vm-templates/blob/master/scripts/xcode-cli-tools.sh
PROD=$(/usr/sbin/softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
# install it
/usr/sbin/softwareupdate -i "$PROD" -v
