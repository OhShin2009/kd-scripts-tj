#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/.nvm/versions/node/v8.9.4/bin;
export PATH
cd /home

if ! [ -x "$(command -v git)" ]; then
  apt update
  apt install git -y
fi

if ! [ -x "$(command -v redis-server)" ]; then
  apt update
  apt install redis-server -y
fi

if [ ! -d "/home/kd-proxy" ]; then
  git clone https://github.com/Mooc1988/kd-proxy.git
else
  cd /home/kd-proxy
  git pull
fi

if [ ! -d "/home/kd-scripts" ]; then
  git clone https://github.com/Mooc1988/kd-scripts.git
  chmod +x /home/kd-scripts/*
else
  cd /home/kd-scripts
  git pull
fi

bash /home/kd-scripts/deploy.sh