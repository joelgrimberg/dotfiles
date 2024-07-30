#!/bin/sh

if ! type git > /dev/null ; then
  echo "git is not installed"
  exit 1
else
  echo "git is installed"
  echo "installing plugins..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/zsh-plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/zsh-plugins/zsh-autosuggestions
fi
