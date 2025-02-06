function vv --description "Open nvim with a specific config"
    set -l configs nvim lazyvim neovim neobean clean-lazyvim
    set -l selected_config (printf "%s\n" $configs | fzf)

    if test -n "$selected_config"
        set -x NVIM_APPNAME $selected_config
        nvim $argv
    end
end
