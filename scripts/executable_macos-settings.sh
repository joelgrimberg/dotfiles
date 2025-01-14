#!/bin/sh

defaults write com.apple.finder ShowHardDrivesOnDesktop 0
defaults write com.apple.finder ShowMountedServersOnDesktop 0
defaults write com.apple.finder ShowRemovableMediaOnDesktop 0
defaults write com.apple.finder ShowStatusBar 0
defaults write com.apple.finder CreateDesktop false
defaults write com.apple.finder AppleShowAllFiles -boolean true

defaults write NSGlobalDomain AppleShowAllExtensions -boolean true 

defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock tilesize -int 32
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

defaults delete com.apple.screencapture

killall Dock
killall Finder
