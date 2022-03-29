#!/bin/bash

zsh_plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
zsh_themes_dir="$HOME/.oh-my-zsh/custom/themes"
tmux_plugins_dir="$HOME/.tmux/plugins"

# params: plugin_dir, username, repo
function install_plugin() {
    if [ -d "$1/$3" ]; then
        echo "Plugin $2/$3 already installed"
        echo "Updating..."
        cd "$1/$3" && git pull
    else
        git clone --depth=1 "https://github.com/$2/$3.git" "$1/$3"
    fi
    echo ""
}

install_plugin $zsh_themes_dir "romkatv" "powerlevel10k"
install_plugin $zsh_plugins_dir "zsh-users" "zsh-autosuggestions"
install_plugin $zsh_plugins_dir "zsh-users" "zsh-syntax-highlighting"
install_plugin $tmux_plugins_dir "tmux-plugins" "tpm"
