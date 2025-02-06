
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
    source $HOME/.config/fish/key_bindings.fish
end

if status is-interactive
    set fish_greeting
    # Commands to run in interactive sessions can go here
end

#if status is-interactive
#and not set -q TMUX
#    exec tmux
#end

source ~/.config/fish/path.fish

#eval (tmuxifier init - fish)
fnm env --use-on-cd --shell fish | source

starship init fish | source
zoxide init fish | source
enable_transience
