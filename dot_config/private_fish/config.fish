
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
    source $HOME/.config/fish/key_bindings.fish
end

if status is-interactive
    set fish_greeting
    # Commands to run in interactive sessions can go here
end

fnm env --use-on-cd --shell fish | source
starship init fish | source
zoxide init fish | source

