#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin;
export PATH

if [ ! -d "/home/log" ]; then
  mkdir /home/log
fi

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



function add_cron(){

  (
    echo "* * * * * cd /home/kd-scripts/cron && ./cron-job-min.sh >> /home/log/min.log"
    echo "0 * * * * cd /home/kd-scripts/cron && ./cron-job-hour.sh >> /home/log/hour.log"
    echo "0 0 * * * cd /home/kd-scripts/cron && ./cron-job-day.sh >> /home/log/day.log"
    echo "0 0 * * 0 cd /home/kd-scripts/cron && ./cron-job-week.sh >> /home/log/week.log"
  ) | crontab -u root -
}

function init(){
  check_netfilter
  check_node
  check_redis
  check_proxy
}

init
bash /home/kd-scripts/deploy.sh
add_cron
