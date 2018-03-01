#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/.nvm/versions/node/v8.9.4/bin;
export PATH

echo '========================'
date "+%Y-%m-%d %H:%M:%S"
echo '========================'

if [ -x "$(command -v git)" ]; then
    cd /home/kd-scripts
    git pull
    cd /home/kd-proxy
    git pull
    npm install
fi

if [ -x "$(command -v ipsec)" ]; then
  ps -fe | grep ipsec | grep -v grep
  if [ $? -ne 0 ] ; then
    ipsec restart
  fi
fi

