#!/bin/bash

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
    if [[ ! -L $2 && ! -e $2 ]]; then
        echo "Linking $1 to $2"
        ln -s $1 $2
    else
        echo "File or directory already exists(source: $1, target: $2)"
    fi
}

link_file $HOME/dotfiles/.zshrc ~/.zshrc
link_file $HOME/dotfiles/.gitconfig ~/.gitconfig
link_file $HOME/dotfiles/.profile ~/.profile
link_file $HOME/dotfiles/.tmux.conf ~/.tmux.conf
link_file $HOME/dotfiles/.bashrc ~/.bashrc

# copy fonts
cp -a $HOME/dotfiles/fonts/. $HOME/.local/share/fonts/

# region vim
link_file $HOME/dotfiles/nvim $HOME/.config/

vimplug_dir="$HOME/.local/share/nvim/site/autoload/plug.vim"
vimplug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [ ! -f "$vimplug_dir" ]; then
    echo "Installing vimplug"
    curl -fLo $vimplug_dir --create-dirs $vimplug_url
    nvim '+PlugInstall' '+qa'
else
    echo "Vimplug already installed"
fi
# endregion

# region nvm
# export NVM_DIR="$HOME/.nvm" && (
#   git clone https://github.com/creationix/nvm.git "$NVM_DIR"
#   cd "$NVM_DIR"
#   git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
# ) && \. "$NVM_DIR/nvm.sh"
export NVM_DIR="$HOME/.nvm"
# check if nvm exists and install
if [ ! -d "$NVM_DIR" ]; then
    echo "Installing nvm"
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    . "$NVM_DIR/nvm.sh"
else
    echo "Nvm already installed"
fi
# endregion

