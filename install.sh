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

wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O install-ohmyzsh.sh && sh install-ohmyzsh.sh
rm -rf install-ohmyzsh.sh

zsh_plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
zsh_themes_dir="$HOME/.oh-my-zsh/custom/themes"
tmux_plugins_dir="$HOME/.tmux/plugins"

install_plugin $zsh_themes_dir "romkatv" "powerlevel10k"
install_plugin $tmux_plugins_dir "tmux-plugins" "tpm"
install_plugin $zsh_plugins_dir "zsh-users" "zsh-autosuggestions"
install_plugin $zsh_plugins_dir "zsh-users" "zsh-syntax-highlighting"

# params: source, target
function link_file() {
        info "Removing $2"
        rm -rf $2
        info "Linking $1 to $2"
        ln -sf $1 $2
}

link_file $HOME/dotfiles/.zshrc ~/.zshrc
link_file $HOME/dotfiles/.gitconfig ~/.gitconfig
link_file $HOME/dotfiles/.profile ~/.profile
link_file $HOME/dotfiles/tmux.conf ~/.config/tmux/tmux.conf
link_file $HOME/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
link_file $HOME/dotfiles/.bashrc ~/.bashrc

# copy fonts
cp -a $HOME/dotfiles/fonts/. $HOME/.local/share/fonts/

# region fnm
if ! [ -x "$(command -v fnm)" ]; then
        echo 'fnm is not installed.' >&2
        curl -fsSL https://fnm.vercel.app/install | bash
fi
# endregion

if ! fc-list | grep -q "JetBrainsMono"; then
        echo "Installing JetBrainsMono Nerd Font"
        if [ ! -d ~/.fonts ]; then
                mkdir ~/.fonts
        fi
        curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
        tar -xf JetBrainsMono.tar.xz -C ~/.fonts
        rm JetBrainsMono.tar.xz -f
        fc-cache -f
fi

unset zsh_plugins_dir
unset zsh_themes_dir
unset tmux_plugins_dir
unset install_plugin
unset link_file
unset info
unset warn
unset error
