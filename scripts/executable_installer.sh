#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
ENDCOLOR="\e[0m"

# curl https://raw.githubusercontent.com/kentcdodds/dotfiles/HEAD/.macos | bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# Joel's Customizations                                                       #
###############################################################################

echo "Hello $(whoami)! Let's get you set up."

echo "mkdir -p ${HOME}/code"
mkdir -p "${HOME}/code"

echo "installing homebrew"
# install homebrew https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install chezmoi

if ! type git > /dev/null ; then
  echo -e "${RED}git is not installed ${ENDCOLOR}"
  exit 1
else
  echo "git is installed"
  echo "installing plugins..."
  if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "TMUX Plugin Manager already installed"
  else
    echo "installing TMUX Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
    echo "✅ ${GREEN}TMUX Plugin Manager installed ${ENDCOLOR}"
  fi
  
  if [ -d "$HOME/zsh-plugins/zsh-syntax-highlighting" ]; then
    echo "zsh-syntax-highlighting already installed"
  else
    echo "installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/zsh-plugins/zsh-syntax-highlighting  > /dev/null 2>&1
    echo "✅ ${GREEN}zsh-syntax-highlighting installed {ENDCOLOR}"
  fi
  
  if [ -d "$HOME/zsh-plugins/zsh-autosuggestions" ]; then
    echo "zsh-auto-suggestions already installed"
  else
    echo "installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/zsh-plugins/zsh-autosuggestions > /dev/null 2>&1
    echo "✅ ${GREEN}zsh-autosuggestions installed ${ENDCOLOR}"
  fi

  if [ -d  "$(bat --config-dir)/themes" ]; then 
    echo "catppuccin theme for bat already installed"
  else
   echo "installing Catppucchin Themes for Bat..the better Cat"
   mkdir -p "$(bat --config-dir)/themes"
   wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
   wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
   wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
   wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
   bat cache --build
  fi

  chezmoi init https://github.com/joelgrimberg/dotfiles.git
  chezmoi apply

  brew bundle install

  echo "Generating a new SSH key for GitHub"
  ssh-keygen -t ed25519 -C "me+github@joelgrimberg.nl" -f ~/.ssh/id_ed25519
  eval "$(ssh-agent -s)"
  touch ~/.ssh/config
  echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519" | tee ~/.ssh/config
  ssh-add -K ~/.ssh/id_ed25519
  echo "run 'pbcopy < ~/.ssh/id_ed25519.pub' and paste that into GitHub"

  ## Login GH to create a ssh key
  gh auth login --hostname GITHUB.COM -p ssh --skip-ssh-key --web
  
  ## clone fonts
  git clone --depth=1 git@github.com:joelgrimberg/Berkeley-Mono-Fonts.git  ~/tmp/
  mv ~/tmp/* /Library/Fonts/
  rm -rf ~/tmp

fi


# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

