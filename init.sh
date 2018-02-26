#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/.nvm/versions/node/v8.9.4/bin;
export PATH
cd /home
SCRIPTS_FOLDER="/home/kd-scripts"
PROXY_FOLDER="/home/kd-proxy"

if ! [ -x "$(command -v git)" ]; then
  apt update
  apt install git -y
fi

if ! [ -x "$(command -v redis-server)" ]; then
  apt update
  apt install redis-server -y
fi

if [ ! -d $PROXY_FOLDER ]; then
  git clone https://github.com/Mooc1988/kd-proxy.git
fi

if [ ! -d $SCRIPTS_FOLDER ]; then
  git clone https://github.com/Mooc1988/kd-scripts.git
  chmod +x /home/kd-scripts/*
fi

sh /home/kd-scripts/deploy.sh
