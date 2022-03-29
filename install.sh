#!/bin/bash

zsh_plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
zsh_themes_dir="$HOME/.oh-my-zsh/custom/themes"

function install_zsh_plugin() {
    if [ -d "$zsh_plugins_dir/$2" ]; then
        echo "Plugin $1/$2 already installed"
        echo "Updating..."
        cd "$zsh_plugins_dir/$2" && git pull
    else
        git clone --depth=1 "https://github.com/$1/$2.git" "$zsh_plugins_dir/$2"
    fi
    echo ""
}

install_zsh_plugin "romkatv" "powerlevel10k"
install_zsh_plugin "zsh-users" "zsh-autosuggestions"
install_zsh_plugin "zsh-users" "zsh-syntax-highlighting"

# Chezmoi
if ! [ -x "$(command -v chezmoi)" ]; then
    echo "Chezmoi is not installed." >&2
    echo "Installing chezmoi"
    sh -c "$(curl -fsLS chezmoi.io/get)"
else
    echo "Chezmoi is already installed"
fi
