#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/.nvm/versions/node/v8.9.4/bin;
export PATH

function deploy_vpn(){
  echo "execute deploy_vpn" >> /home/deploy.log
  if ! [ -x "$(command -v ipsec)" ]; then
    echo "1" >> /home/deploy.log
    cd /home/kd-scripts
    git pull
    bash /home/kd-scripts/create_ikev2_vpn.sh
  else
    ps -fe | grep ipsec | grep -v grep
    if [ $? -ne 0 ] ; then
      echo "2" >> /home/deploy.log
      ipsec start
    else
      echo "3" >> /home/deploy.log
      ipsec restart
    fi
  fi
}

function deploy_proxy(){
  echo "execute deploy_proxy" >> /home/deploy.log
  cd /home/kd-proxy
  git pull
  npm install
  ps -fe | grep kd-proxy | grep -v grep
  if [ $? -ne 0 ] ; then
    cd /home/kd-proxy
    pm2 start bootstrap
    echo "start pm2" >> /home/boot.log
  else
    pm2 restart all
  fi
}

deploy_vpn
deploy_proxy
