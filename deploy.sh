#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/.nvm/versions/node/v8.9.4/bin;
export PATH

function deploy_vpn(){
  if ! [ -x "$(command -v ipsec)" ]; then
    cd /home/kd-scripts
    git pull
    bash /home/kd-scripts/create_ikev2_vpn.sh
  else
    ps -fe | grep ipsec | grep -v grep
    if [ $? -ne 0 ] ; then
      ipsec start
    else
      ipsec restart
    fi
  fi
}

function deploy_proxy(){
  echo "deploy_proxy" >> /home/log
  cd /home/kd-proxy
  git pull
  npm install
  ps -fe | grep kd-proxy | grep -v grep
  if [ $? -ne 0 ] ; then
    pm2 start /home/kd-proxy/bootstrap.json
  else
    pm2 restart all
  fi
}

deploy_vpn
deploy_proxy