function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting
    fastfetch --logo-color-1 yellow
    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        #cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias dolphin='nohup dolphin . & kitty @ close-window'
    alias lf yazi
    alias netfix='sudo modprobe -r iwlwifi && sudo modprobe iwlwifi && echo "WiFi adapter  
    reset"'
    alias vim nvim
    alias yt youtube-tui
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    fish_vi_key_bindings
    set -x MANPAGER "nvim +Man!"

end

function lf
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file=$tmp
    set cwd (cat -- $tmp)
    if test -s $tmp
        if test -n "$cwd" -a "$cwd" != "$PWD"
            cd -- $cwd
            commandline -f repaint
        end
    end
    rm -f -- $tmp
end
