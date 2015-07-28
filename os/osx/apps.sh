#!/usr/bin/env bash
set -eu

#
# Application installer (via brew-cask)
#

# Apps
apps=(
  1password
  atom
  calibre
  dropbox
  evernote
  firefox
  flux
  free-ruler  
  google-chrome
  hex-fiend
  imagealpha
  imageoptim
  iterm2
  karabiner
  max
  owncloud
  mplayerx
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  scroll-reverser
  skype
  spotify
  sublime-text3
  the-unarchiver
  tower
  transmission
  transmit
  trickster
  trim-enabler
  vlc
)

# Atom packages
atom=(
  atom-beautify
  cmd-9
  color-picker
  file-icons
  highlight-selected
  image-view
  inc-dec-value
  language-jade
  linter
  linter-jsxhint
  react
  tabs-to-spaces
  zentabs
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  # Cask
  brew tap ponychicken/homebrew-customcask 
  # Adobe 
  brew tap ponychicken/homebrew-adobe-cc
  # Popcorn
  #brew tap ponychicken/homebrew-custom
  brew install brew-cask --HEAD

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install atom plugins
  echo "installing atom plugins..."
  apm install ${atom[@]}

  # link with alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
