#!/bin/bash


# Maintainer Praveen Dhawan

set -e

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

echo "Add Package repositories"

echo "Adding java"
sudo add-apt-repository ppa:webupd8team/java

echo "Adding numix"
sudo apt-add-repository ppa:numix/ppa

echo "Adding skype"
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skype-stable.list
curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -

echo "Adding uget"
sudo add-apt-repository ppa:plushuang-tw/uget-stable

echo "Adding google-cloud-sdk"
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "Adding spotify"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886\
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list\

echo "Adding rvm"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable

echo "Updates packages"
sudo apt update -y
sudo apt dist-upgrade

echo "Installs packages. Give your password when asked."
sudo apt --ignore-missing install build-essential tcl git-core curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3 libxml2-dev libxslt1-dev python-software-properties libffi-dev libgdm-dev libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib libpq-dev pgadmin3 libc6-dev nodejs libgdbm-dev vim gitk synapse apt-transport-https ca-certificates docker-ce chromium libappindicator1 vlc terminator gparted gnome-shell-extensions python-pip npm nodejs-legacy graphviz ubuntu-restricted-extras software-properties-common gvim vim-gnome mongodb-clients meld gnome-mplayer kdiff3 libqt4-dev openvpn oracle-java8-installer oracle-java8-set-default numix-icon-theme-circle numix-gtk-theme docker.io uget zsh google-cloud-sdk spotify-client skypeforlinux -y

sudo apt -f install

# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886\
# echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list\

# sudo apt-get update
# sudo apt-get install spotify-client

# sudo add-apt-repository ppa:webupd8team/java
# sudo apt update; sudo apt install oracle-java8-installer
# javac -version
# sudo apt install oracle-java8-set-default

# sudo apt-add-repository ppa:numix/ppa
# sudo apt-get update
# sudo apt install numix-icon-theme-circle
# sudo apt install numix-gtk-theme 

echo "Install Pip Modules -> youtube_dl, coursera-dl, edx-dl"
sudo pip install --upgrade pip
sudo pip install --upgrade youtube_dl
sudo -H pip install -U edx-dl
sudo pip install coursera-dl

echo "config git"
git config --global user.name "Praveen Dhawan"
git config --global user.email "praveen.dhawan@grabonrent.com"
git config --global --add merge.tool kdiff3
git config --global --add mergetool.kdiff3.trustExitCode false
git config --global --add diff.guitool kdiff3
git config --global --add difftool.kdiff3.trustExitCode false

echo "git aliases"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'


echo "Installs ImageMagick for image processing"
sudo apt install imagemagick --fix-missing -y

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo "Installs Ruby"
rvm install 2.3.3
rvm use 2.3.1 --default

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler
gem install rails -v 4.2.4
gem install rsense
gem install rubocop
gem install metrical
gem install rubycritic
gem install rails_best_practices

echo "set up Project Directory"
rvm use 2.3.1@gor --default
gem install bundler
gem install rails -v 4.2.4
gem install rsense
gem install rubocop
gem install metrical
gem install rubycritic
gem install rails_best_practices

mkdir Projects
cd Projects/
git clone git@bitbucket.org:dev_grabonrent/gor_refactored.git
cd gor_refactored
bundle install
cd ..
git clone git@bitbucket.org:dev_grabonrent/kubernetes-config.git

echo "docker setup"
sudo apt remove docker docker-engine
# sudo apt install docker.io
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER

sudo docker pull elasticsearch:2.3.5
sudo docker pull mongo
sudo docker pull redis:latest
sudo docker pull neo4j 3.1.3

sudo docker run -d --name redis -p 6379:6379 redis:latest
sudo docker run -d --name mongo -p 27017:27017 mongo:latest
sudo docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 elasticsearch:2.3.5
sudo docker run -d --name neo4j -p 7474:7474 -p 7687:7687 neo4j:3.1.3


echo "install nvm and node"
curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh
nvm ls-remote
nvm install 0.11.13
nvm install 7.4.0
nvm use 7.4.0

# echo "install skype"
# sudo dpkg -s apt-transport-https > /dev/null || bash -c "sudo apt-get update; sudo apt-get install apt-transport-https -y" 
# curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
# echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skype-stable.list
# sudo dpkg --add-architecture i386
# sudo dpkg -i skype-ubuntu-precise_4.3.0.37-1_i386.deb
# sudo apt-get install skypeforlinux -y  
# sudo apt -f install 

# echo "install uget"
# sudo add-apt-repository ppa:plushuang-tw/uget-stable
# sudo apt update
# sudo apt install uget

echo "install steam"
sudo dpkg -i steam_latest.deb 

echo "install zsh"
# sudo apt install zsh
chsh -s /bin/zsh

echo "install prezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl\
chmod +x ./kubectl\
sudo mv ./kubectl /usr/local/bin/kubectl\
echo "source <(kubectl completion bash)" >> ~/.bashrc
echo "source <(kubectl completion zsh)" >> ~/.zshrc

wget https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh && . one-dark.sh\
chmod +x one-dark.sh
./one-dark.sh


sudo -H pip install powerline-status
git clone https://github.com/powerline/fonts.git
sh install.sh

# export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
# echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# sudo apt update && sudo apt install google-cloud-sdk
gcloud init
gcloud components
gcloud components install kubectl
gcloud container clusters get-credentials kube-gor --zone asia-east1-a --project grabonrent-gor
gcloud auth application-default login


sudo vim /usr/share/applications/atom-urihandler.desktop
sudo chmod +x /usr/bin/atom-urihandler
sudo update-desktop-database

curl -O https://raw.githubusercontent.com/exercism/cli-www/master/public/install
chmod +x install
./install
exercism configure --key=35618fafcb614b6981aa77acc12f6656\
curl http://cli.exercism.io/exercism_completion.zsh > ~/.config/exercism/exercism_completion.zsh


curl -O https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
keybase pgp select
keybase pgp gen