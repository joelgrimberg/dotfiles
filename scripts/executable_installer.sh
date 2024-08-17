#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
ENDCOLOR="\e[0m"


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
fi
