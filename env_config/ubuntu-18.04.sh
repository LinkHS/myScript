# --- Essential ---
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
cp ./config_files/source_list.18.04 //etc/apt/sources.list
sudo apt update
sudo apt upgrade

## ---
ssh-keygen -t rsa -C "381082014@qq.com"
sudo apt install -y vim git tmux htop 
sudo apt install -y tig cmake tree

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
zsh


# -- Develop ---
## --- Latex ---
sudo apt install texlive-full
sudo apt install texlive-xetex
sudo apt install texlive-lang-chinese


# --- Configuration ---
## --- vim ---
cp vimrc ~/.vimrc

## --- zsh ---
## Change your shell to zsh and Login again your terminal
chsh -s `which zsh` # might need to reboot