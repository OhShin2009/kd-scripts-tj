#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin;
export PATH
echo precedence ::ffff:0:0/96  100 >> /etc/gai.conf

echo ulimit -n 65535 >> ~/.profile
source ~/.profile



function config_ssh(){
    sed -re 's/^(PasswordAuthentication)([[:space:]]+)yes/\1\2no/' -i.`date -I` /etc/ssh/sshd_config
    if [ ! -d "~/.ssh" ]; then
        mkdir ~/.ssh
    fi
    cd ~/.ssh
    echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCztBCQ0uJeccSApdta3q5hO0NICh0+DSYkIcRGV6qxB/2o/AAcn0vkWtJrsZXavC3J+Vj6DYuynqm1FOfcuqbk3gnjQrQkHmkH3gYTMmZFz1vi76sOtlW1+lWjk6is+DtPRuoPzjku1WYW6nGbwcK0at6kUsQvcKCzqv0+42xYscIsKzWmMSoDSfaCJrdVlQXnLXk4128mmjP80TnGror9lCMrAu9PTTznFixAw3I2ElrCsQW5a/y9qw2AyMvJtYh+ELjXIb3RNe1m81L9KhfFmpr09jNcvdL5Dvw1fwiPywE6A1svJaIVbSUyefmRlKDwfeAVVb8hiX7EjgPfRSQ/ frank@FrankdeMacBook-Pro.local >> authorized_keys
    echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWiGprMMV8rQ4BEtwi23JGIDY8DyoW+ZkPPB0VZDCxLJWBWEky76pvB1jJN/j1+ZT6NFUj456aN24IhGFXfCt20HoqefEeaz8RyNwLYFh+VMj890Iek0+XztiIgq6Ah1p3+ll65WGa319UDB1P5i8vfq1ehgmY7GB2ysh4RL1qPzgvDdTZf0yYjsLrEbGoVaj0NA/HJwmw/lGEQe0TEeUofUh+KkLkxXk/xA6jmpCxCEq6zfDCENlZnsMRWiY+Qa1INIlJ72/M7JPsv8krcPtxcEDgOzVQBIxxwgzJLAsJ4S8yo/9fG6rJ4HWTn0F0fBGfJGL5KQM5I2NU5nMLa5T5 frank@FrankdeMacBook-Pro.local >> authorized_keys
    service sshd restart
}

function check_git(){
  if ! [ -x "$(command -v git)" ]; then
    apt update
    apt install -y git
  fi
}

function check_scripts(){
  if [ ! -d "/home/kd-scripts-tj" ]; then
    cd /home
    git clone https://github.com/syg-ohshin/kd-scripts-tj.git
  else
    cd /home/kd-scripts-tj
    git pull
  fi
}

config_ssh
check_git
check_scripts
cd /home/kd-scripts-tj
bash /home/kd-scripts-tj/init.sh
