#!/bin/bash

###############################################################################
# ASK TO SEE IF USER HAS GIVEN FULL DISK ACCESS TO TERMINAL                   #
###############################################################################

echo "Did you give full disk access to Terminal.app? (y/n)"
read -r confirm
if [ "$confirm" != "y" ]; then
  echo "Please give full disk access to Terminal.app in System Preferences > Search for Full Disk Access, add Terminal and run the script again."
  exit
fi

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# ###############################################################################
# # Screen                                                                      #
# ###############################################################################

# Save screenshots to Downloads folder.
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# ###############################################################################
# # Finder                                                                      #
# ###############################################################################

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# # Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# # Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# # Show the ~/Library folder
chflags nohidden ~/Library

# # Disable single click desktop to hide all windows and show desktop only in Stage Manager.
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# ###############################################################################
# # Mouse, Keyboard, Trackpad, and Input                                        #
# ###############################################################################

# Enable Three Finger Drag
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"

# ###############################################################################
# # Dock, Menu, Dashboard, and hot corners                                      #
# ###############################################################################

# Disable Recently Used Applications in Dock
defaults write com.apple.dock "show-recents" -bool "false"

# ###############################################################################
# # Safari                                                                      #
# ###############################################################################

# # Disable Automatically Open Safe Downloads
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Disable AutoFill for all forms
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
