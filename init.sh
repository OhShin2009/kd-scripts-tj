#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin;
export PATH

function check_netfilter(){
  if ! [ -x "$(command -v netfilter-persistent)" ]; then
    apt update
    DEBIAN_FRONTEND=noninteractive apt install iptables-persistent -y
  fi
}


function check_node(){
   if ! [ -x "$(command -v node)" ]; then
       curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
       apt install -y nodejs
       apt install -y build-essential
       npm install pm2 -g
   fi
}


function check_git(){
  if ! [ -x "$(command -v git)" ]; then
    apt update
    apt install -y git
  fi
}


function check_redis(){
  if ! [ -x "$(command -v redis-server)" ]; then
    apt update
    apt install -y redis-server
  fi
}


function check_proxy(){
  if [ ! -d "/home/kd-proxy" ]; then
    cd /home
    git clone https://github.com/Mooc1988/kd-proxy.git
  fi
}

function check_scripts(){
  if [ ! -d "/home/kd-scripts" ]; then
    cd /home
    git clone https://github.com/Mooc1988/kd-scripts.git
  fi
}


function add_cron(){
  if [ ! -d "/home/kd-scripts" ]; then
    mkdir /home/cron-log
  fi
  (
    echo "* * * * * cd /home/kd-scripts/cron && ./cron-job-min.sh >> /home/cron-log/min.log"
    echo "0 * * * * cd /home/kd-scripts/cron && ./cron-job-hour.sh >> /home/cron-log/hour.log"
    echo "0 0 * * * cd /home/kd-scripts/cron && ./cron-job-day.sh >> /home/cron-log/day.log"
    echo "0 0 * * 0 cd /home/kd-scripts/cron && ./cron-job-week.sh >> /home/cron-log/week.log"
  ) | crontab -u root -
}

function init(){
  check_netfilter
  check_node
  check_git
  check_redis
  check_proxy
  check_scripts
  add_cron
}

init
bash /home/kd-scripts/deploy.sh
