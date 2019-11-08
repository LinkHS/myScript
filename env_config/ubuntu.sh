#
sudo apt-get install -y git
sudo apt-get install -y cmake
sudo apt-get install -y tig tmux htop tree


# --- vim ---
sudo apt-get install -y vim
cp vimrc ~/.vimrc

## Plugins：
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim


# --- pip ---
mkdir ~/.pip
cp pip.conf ~/.pip/pip.conf
sudo apt-get install python-pip


# --- fonts ---
# Note: cp *.ttc /usr/share/fonts

sudo apt-get install unity-tweak-tool


# --- zsh ---
## Prereq:
sudo apt-get install -y zsh
sudo apt-get install -y git-core

## Install
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

## Change your shell to zsh and Login again your terminal
chsh -s `which zsh` # might need to reboot

## Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Note: 在'~/.zshrc' 中添加以下内容
# Note: plugins = ( [plugins...] zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)


# --- fzf ---
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


# --- VPN ---
cp ss.vpn_config ~/

## method 1
# pip install git+https://github.com/shadowsocks/shadowsocks.git@master
# sudo apt install libsodium-dev
#`sslocal -c ss.vpn_config`

## method 2
#sudo apt-get install software-properties-common -y 
#sudo add-apt-repository ppa:max-c-lv/shadowsocks-libev -y 
#sudo apt-get update 
#sudo apt install shadowsocks-libev 
#
#ss-local -c ss.vpn_config


# --- Tmux ---
mkdir ~/.tmux
cp tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# --- TLP 电源管理
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw


# --- exfat ---
sudo apt install exfat-fuse exfat-utils


# --- Gestures ---
sudo gpasswd -a $USER input
sudo apt-get install libinput-tools
sudo apt-get install xdotool
sudo apt-get install ruby
gem install fusuma
mkdir -p ~/.config/fusuma  
mv fusuma_config.yml ~/.config/fusuma/config.yml
# run "sudo fusuma &" or "add fusuma to Startup Applications"


# --- cgroup 限制内存
sudo apt-get install cgroup-bin cgroup-lite cgroup-tools cgroupfs-mount libcgroup1
sudo cp cgrule.conf /etc/
sudo cp cgconfig.conf /etc/
# Add `cgconfigparser -l /etc/cgconfig.conf` and `cgrulesengd` into /etc/rc.local


# --- sysmonitor 资源监视 ---
sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update
sudo apt-get install indicator-sysmonitor  


# --- Develop ---
sudo apt-get install -y build-essential
sudo apt-get install -y python-dev python3-dev
sudo apt-get install -y openblas
sudo apt-get install -y ctags cscope

sudo apt-get install -y libeigen3-dev


# --- Notes ---
echo 'add fusuma to Startup Applications'