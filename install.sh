#!/bin/bash

function info() {
    echo -e "\033[32m$1\033[0m"
}

function warn() {
    echo -e "\033[33m$1\033[0m"
}

function error() {
    echo -e "\033[31m$1\033[0m"
}

info "Installing dependencies..."

# params: plugin_dir, username, repo
function install_plugin() {
    if [ -d "$1/$3" ]; then
        info "Updating plugin $2/$3..."
        cd "$1/$3" && git pull
    else
        git clone --depth=1 "https://github.com/$2/$3.git" "$1/$3"
    fi
    echo ""
}

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O install-ohmyzsh.sh && sh install-ohmyzsh.sh; rm -rf install-ohmyzsh.sh

zsh_plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
zsh_themes_dir="$HOME/.oh-my-zsh/custom/themes"
tmux_plugins_dir="$HOME/.tmux/plugins"

install_plugin $zsh_themes_dir "romkatv" "powerlevel10k"
install_plugin $zsh_plugins_dir "zsh-users" "zsh-autosuggestions"
install_plugin $zsh_plugins_dir "zsh-users" "zsh-syntax-highlighting"
install_plugin $tmux_plugins_dir "tmux-plugins" "tpm"

# params: source, target
function link_file() {
    # check symlink and dir exist
    if [[ ! -L $2  ]]; then
        info "Removing $2"
        rm $2
    elif [[ -e $2 ]]; then
        info "Unlink $2"
        unlink $2
    fi
    info "Linking $1 to $2"
    ln -s $1 $2
}

link_file $HOME/dotfiles/.zshrc ~/.zshrc
link_file $HOME/dotfiles/.gitconfig ~/.gitconfig
link_file $HOME/dotfiles/.profile ~/.profile
link_file $HOME/dotfiles/.tmux.conf ~/.tmux.conf
link_file $HOME/dotfiles/.bashrc ~/.bashrc

# copy fonts
cp -a $HOME/dotfiles/fonts/. $HOME/.local/share/fonts/

# region fnm
if ! [ -x "$(command -v fnm)" ]; then
    echo 'fnm is not installed.' >&2
    curl -fsSL https://fnm.vercel.app/install | bash
fi
# endregion

unset zsh_plugins_dir
unset zsh_themes_dir
unset tmux_plugins_dir
unset install_plugin
unset link_file
unset info
unset warn
unset error
