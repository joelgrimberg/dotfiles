#!/bin/sh

if ! type git > /dev/null ; then
  echo "git is not installed"
  exit 1
else
  echo "git is installed"
  echo "installing plugins..."
  if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "TMUX Plugin Manager already installed"
  else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
  fi
  
  if [ -d "$HOME/zsh-plugins/zsh-syntax-highlighting" ]; then
    echo "zsh-syntax-highlighting already installed"
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/zsh-plugins/zsh-syntax-highlighting  > /dev/null 2>&1
  fi
  
  if [ -d "$HOME/zsh-plugins/zsh-autosuggestions" ]; then
    echo "zsh-auto-suggestions already installed"
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/zsh-plugins/zsh-autosuggestions > /dev/null 2>&1
  fi

fi
