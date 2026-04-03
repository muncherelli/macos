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

# Finder: new windows open in your home directory (General → "New Finder windows show").
defaults write com.apple.finder NewWindowTarget -string PfLo
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Finder: show hidden files by default
# TO-DO

# finder: show all filename extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# finder: do not show external disks on the desktop (Finder Settings → General)
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false

# # Avoid creating .DS_Store files on network volumes
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Finder: default view for folders without a saved per-folder style (List = Nlsv).
# Other codes: icnv icon, clmv column, glyv gallery, Flwv (legacy cover flow).
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv

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

# Hot corners: disable all (0 = no action; bottom-right defaults to Quick Note otherwise).
for corner in tl tr bl br; do
  defaults write com.apple.dock "wvous-${corner}-corner" -int 0
  defaults write com.apple.dock "wvous-${corner}-modifier" -int 0
done

# # ###############################################################################
# # # Safari                                                                      #
# # ###############################################################################

# Safari is sandboxed: it reads prefs from the container plist. A bare `defaults write`
# often updates ~/Library/Preferences only (ignored by Safari) unless Terminal has
# Full Disk Access. We mirror into the container file when it exists, and do a one-time
# launch if Safari has never run (so that plist exists).
safari_container_plist="${HOME}/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist"

osascript -e 'quit app "Safari"' 2>/dev/null || true
sleep 1

if [[ ! -f "$safari_container_plist" ]]; then
  open -gj -a Safari 2>/dev/null || true
  sleep 3
  osascript -e 'quit app "Safari"' 2>/dev/null || true
  sleep 1
fi

safari_set_bool() {
  local key=$1 val=$2
  defaults write com.apple.Safari "$key" -bool "$val"
  if [[ -f "$safari_container_plist" ]]; then
    if ! /usr/libexec/PlistBuddy -c "Set :${key} ${val}" "$safari_container_plist" 2>/dev/null; then
      /usr/libexec/PlistBuddy -c "Add :${key} bool ${val}" "$safari_container_plist" 2>/dev/null || true
    fi
  fi
}

# General → disable "Open safe files after downloading".
safari_set_bool AutoOpenSafeDownloads false

# AutoFill → turn off all automatic fill categories.
safari_set_bool AutoFillFromAddressBook false
safari_set_bool AutoFillPasswords false
safari_set_bool AutoFillCreditCardData false
safari_set_bool AutoFillMiscellaneousForms false

unset -f safari_set_bool

# reload finder
killall Finder

# reload dock
killall Dock

# apply menu bar clock prefs (Ventura+)
killall ControlCenter 2>/dev/null || true