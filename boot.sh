#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin;
export PATH

function check_git(){
  if ! [ -x "$(command -v git)" ]; then
    apt update
    apt install -y git
  fi
}

function check_scripts(){
  if [ ! -d "/home/kd-scripts" ]; then
    cd /home
    git clone https://github.com/Mooc1988/kd-scripts.git
  else
    cd /home/kd-scripts
    git pull
  fi
}


check_git
check_scripts
cd /home/kd-scripts
bash /home/kd-scripts/init.sh