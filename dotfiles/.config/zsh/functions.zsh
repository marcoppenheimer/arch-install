#!/bin/zsh --login

function sti {
    while getopts l: flag
    do
        case "${flag}" in
            l) label=${OPTARG};;
        esac
    done
    export HISTFILE="$HOME/.zsh_history"
    fc -R
    echo "" >> "$HOME/arch-install/home_install.sh"
    echo "#${label}" >> "$HOME/arch-install/home_install.sh"
    echo "$(fc -l -20 | tail -2 | head -1 | cut -c8-999)" >> "$HOME/arch-install/home_install.sh"
}

function n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

function mpv ()
{
    nohup mpv $@ > /dev/null 2>&1&
}
