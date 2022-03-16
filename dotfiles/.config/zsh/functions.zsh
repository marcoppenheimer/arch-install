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

function start_work {
    sudo systemctl start snapd.service
    sudo snap start microk8s
    microk8s start --wait-ready
}

function stop_work {
    microk8s stop
    sudo systemctl stop microk8s
}
