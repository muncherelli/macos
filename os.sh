#!/bin/bash

###############################################################################
# General UI/UX                                                               #
###############################################################################

# expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# save to disk (not to iCloud) by default
# defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# # ###############################################################################
# # # Screen                                                                      #
# # ###############################################################################

# # Save screenshots to Downloads folder.
# defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# # # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# # ###############################################################################
# # # Finder                                                                      #
# # ###############################################################################

# set home directory as the default location for new Finder windows
# TO-DO

# Finder: show hidden files by default
# TO-DO

# finder: show all filename extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# # Avoid creating .DS_Store files on network volumes
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# use list view in all Finder windows by default
# four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
# defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# this seems to be broken in Sequoia

# show the ~/Library folder because we aren't nubs
chflags nohidden ~/Library

# # # Disable single click desktop to hide all windows and show desktop only in Stage Manager.
# defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# # ###############################################################################
# # # Mouse, Keyboard, Trackpad, and Input                                        #
# # ###############################################################################

# # Enable Three Finger Drag
# defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1
# defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"

# # ###############################################################################
# # # Dock, Menu, Dashboard, and hot corners                                      #
# # ###############################################################################

# disable Recently Used Applications in Dock
defaults write com.apple.dock "show-recents" -bool "false"

# # ###############################################################################
# # # Safari                                                                      #
# # ###############################################################################

# # # Disable Automatically Open Safe Downloads
# defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# # Disable AutoFill for all forms
# defaults write com.apple.Safari AutoFillFromAddressBook -bool false
# defaults write com.apple.Safari AutoFillPasswords -bool false
# defaults write com.apple.Safari AutoFillCreditCardData -bool false
# defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# reload finder
killall Finder

# reload dock
killall Dock