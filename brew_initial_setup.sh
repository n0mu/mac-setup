#!/bin/sh
# https://hackernoon.com/personal-macos-workspace-setup-adf61869cd79

#echo "Creating an SSH key for you..."
#ssh-keygen -t rsa
#
#echo "Please add this public key to Github \n"
#echo "https://github.com/account/ssh \n"
#read -p "Press [Enter] key after this..."

echo "Installing xcode-stuff"
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

## Install homewbrew repos
echo "Installing homebrew repos..."
declare -a taps=(
 'buo/cask-upgrade'
 'caskroom/cask'
 'caskroom/versions'
 'homebrew/bundle'
 'homebrew/core'
)

for tap in "${taps[@]}"; do
 brew tap "$tap"
done

echo "Updating homebrew..."
brew upgrade && brew update


echo "Installing Git..."
brew install git

echo "Git config"
#git config --global user.name "Jorge Garcia"
#git config --global user.email n0mu@anche.no

echo "Installing brew git utilities..."
brew install git-extras
#brew install legit
#brew install git-flow

echo "Installing other brew stuff..."
brew install tree
brew install wget
brew install trash
brew install nvim
#brew install mackup
brew install micronaut

echo "Cleaning up brew"
brew cleanup

#######################
### Install Formula ###
#######################
echo "installing formula"
declare -a formula_apps=(
 'git'
 'git-extras'         # https://github.com/tj/git-extras
 #'git-flow'          # https://github.com/nvie/gitflow
 'tree'
 'wget'
 ''
)
for app in "${formula_apps[@]}"; do
  echo 'installing "$app"'
  brew install "$app"
done

#####################
### Install Casks ###
#####################
echo "Installing casks..."
brew install cask

declare -a cask_apps=(
 'atom'
 'appcleaner'
 'bit-slicer'
 'brave-browser'
 'disk-inventory-x'
 'firefox'
 'flux'
 'freeplane'
 'iterm2'
 'licecap'
 'keepassxc'
 'keka'
 'smcfancontrol'
 'spectacle'
# 'thunderbird'
# 'veracrypt'
# 'virtualbox'
# 'virtualbox-extension-pack'
)

for app in "${cask_apps[@]}"; do
  echo 'installing "$app"'
  brew cask install "$app"
done

# Java Development Setup
echo 'installing java development environment'
echo 'install java8'
brew cask install java8

#echo 'install maven@3.6'
#brew install maven@3.6
#
#echo 'install intellij-ce'
#brew cask install 'intellij-idea-ce'

brew cask cleanup
brew cleanup


######################################
### Install App Store Applications ###
######################################
echo "Install mac store apps"
echo "Please login on app store"
read -p "Press [Enter] key after this..."

brew install mas

declare -a mas_apps=(
  '1024640650'  # CotEditor (3.7.1)
  '808647808'   # ActivityTimer (2.0.5)
)

for app in "${mas_apps[@]}"; do
  echo 'installing "$app"'
  mas install "$app"
done

####################
### Mac Settings ###
####################
echo "Setting some Mac settings..."
#"Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#"Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Disable smart quotes and smart dashes as they are annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#"Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

#"Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

#"Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

#"Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

#"Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#"Disable the sudden motion sensor as its not useful for SSDs"
sudo pmset -a sms 0

#"Disable annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

#"Setting screenshots location to ~/Downloads"
defaults write com.apple.screencapture location -string "$HOME/Downloads"

#"Setting screenshot format to PNG"
defaults write com.apple.screencapture type -string "png"

#"Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

#"Disabling Safari's thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

killall Finder

echo "Done!"
