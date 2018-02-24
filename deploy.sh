#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:~/.nvm/versions/node/v8.9.4/bin;
export PATH
cd /home/kd-proxy
git pull
npm install
pm2 delete all
pm2 start /home/proxy.json
