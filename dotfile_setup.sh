#!/bin/bash

# Dependencies
sudo apt update && sudo apt install git npm tmux curl ripgrep zsh

# Set up config repo
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" >> $HOME/.bashrc
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/caseyryan22465/dotfiles.git $HOME/.dotfiles
source $HOME/.bashrc
config checkout
config config --local status.showUntrackedFiles no

# Set up zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Set up alacritty
## First download rust/alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
cargo install alacritty
ALACRITTY_BIN=$(which alacritty)
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $ALACRITTY_BIN 50
## Next download and install fonts
fonturl="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Overpass.zip"
curl -L -o temp.zip $fonturl
unzip -o temp.zip -d $HOME/.fonts/
rm temp.zip
sudo fc-cache -fv

# Set up neovim
nvim_dl="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
curl -L -o $HOME/nvim.appimage $nvim_dl

cargo install tree-sitter-cli
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
