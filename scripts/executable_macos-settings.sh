#!/bin/sh

LOGGED_USER=$(stat -f%Su /dev/console)
sudo su $LOGGED_USER -c 'defaults write com.apple.dock mineffect -string scale'
killall Dock
