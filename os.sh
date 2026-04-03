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

# Menu bar clock: time only (no weekday, no date). ShowDate 2 = Never (macOS 12.4+).
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool false
defaults write com.apple.menuextra.clock ShowDate -int 2

# # ###############################################################################
# # # Screen                                                                      #
# # ###############################################################################

# # Save screenshots to Downloads folder.
# defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# # # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# TO-DO: change the lock screen timeout to 180 minutes (max)

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

# disable single click desktop to hide all windows and show desktop only in Stage Manager.
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# # ###############################################################################
# # # Mouse, Keyboard, Trackpad, and Input                                        #
# # ###############################################################################

# Enable three-finger drag (Accessibility-style dragging; built-in + Magic Trackpad).
# Same toggles as System Settings → Accessibility → Pointer Control → Trackpad Options.
# May require logging out and back in for the trackpad to pick it up.
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Tap to click (built-in + Magic Trackpad; matches Trackpad settings).
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable automatic spelling correction and capitalization (Keyboard text settings).
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

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

# apply menu bar clock prefs (Ventura+)
killall ControlCenter 2>/dev/null || true