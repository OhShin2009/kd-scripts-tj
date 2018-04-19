#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/.nvm/versions/node/v8.9.4/bin;
export PATH

echo '========================'
date "+%Y-%m-%d %H:%M:%S"
echo '========================'


function tempExec(){
   if [ ! -f "/home/flag1" ];then
    cp /home/kd-scripts-tj/data/strongswan.conf /usr/local/etc/strongswan.conf
    ipsec restart
    cd /home
    touch flag1
   fi
}


function update_code(){
  if [ -x "$(command -v git)" ]; then
      cd /home/kd-scripts-tj
      git pull
      cd /home/kd-proxy-tj
      git pull
      npm install
  fi
}

function check_ipsec(){
  if [ -x "$(command -v ipsec)" ]; then
    ps -fe | grep ipsec | grep -v grep
    if [ $? -ne 0 ] ; then
      ipsec restart
    fi
  fi
}


function check_proxy(){
  ps -fe | grep kd-proxy-tj | grep -v grep
  if [ $? -ne 0 ] ; then
    cd /home/kd-proxy-tj
    pm2 start bootstrap.json
  fi
}

update_code
check_ipsec
check_proxy
tempExec
