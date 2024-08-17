alias ls='eza -lh --group-directories-first --icons --all'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --theme=\"Catppuccin Mocha\" --color=always {}' --preview-window '~3'"
alias cat='bat --theme="Catppuccin Mocha"'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias n='nvim'
alias g='git'
alias d='docker'
alias r='rails'
alias lzg='lazygit'
alias lzd='lazydocker'

# Git
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

alias vi='nvim'

alias rsync-copy='rsync -v -r --progress '

# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# when on Debian or Ubuntu, bat should be called with batcat
if ! type bat > /dev/null ; then
alias cat='batcat'
fi
