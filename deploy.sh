#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/.nvm/versions/node/v8.9.4/bin;
export PATH

function deploy_vpn(){
  echo "execute deploy_vpn" >> /home/deploy.log
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
  echo "execute deploy_proxy" >> /home/deploy.log
  cd /home/kd-proxy
  git pull
  npm install
}

function set_default_config(){
  cp /home/kd-scripts/config/ext-auth.conf /usr/local/etc/strongswan.d/charon/ext-auth.conf
  ipsec restart
}

deploy_vpn
set_default_config
deploy_proxy
