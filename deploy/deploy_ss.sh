#! /bin/bash


function install_ss(){
    if ! [ -x "$(command -v ss-server)" ]; then
        if grep -Eqi "16.04" /etc/issue ; then
          apt-get install software-properties-common -y
          add-apt-repository ppa:max-c-lv/shadowsocks-libev -y
        fi
        apt-get update
        apt install shadowsocks-libev -y
    fi
}

function install_supervisor(){
    if ! [ -x "$(command -v supervisorctl)" ]; then
        apt update
        apt install supervisor -y
    fi
}

function optimize_ss(){
    cp /home/kd-scripts/config/ss/local.conf /etc/sysctl.d/local.conf
    sysctl --system
    adduser --system --disabled-password --disabled-login --no-create-home shadowsocks
}

function config_iptables(){
    if [ -f "/etc/iptables/rules.v4"]; then
        iptables-restore /etc/iptables/rules.v4
    else
        iptables -N SHADOWSOCKS
        iptables -t filter -m owner --uid-owner shadowsocks -A SHADOWSOCKS -d 127.0.0.0/8 -j REJECT
        iptables -t filter -m owner --uid-owner shadowsocks -A SHADOWSOCKS -p udp --dport 53 -j ACCEPT
        iptables -t filter -m owner --uid-owner shadowsocks -A SHADOWSOCKS -p tcp --dport 53 -j ACCEPT
        iptables -t filter -m owner --uid-owner shadowsocks -A SHADOWSOCKS -p tcp --dport 80 -j ACCEPT
        iptables -t filter -m owner --uid-owner shadowsocks -A SHADOWSOCKS -p tcp --dport 443 -j ACCEPT
        iptables -t filter -m owner --uid-owner shadowsocks -A SHADOWSOCKS -m state --state ESTABLISHED,RELATED -j ACCEPT
        iptables -t filter -m owner --uid-owner shadowsocks -A SHADOWSOCKS -p tcp -j REJECT --reject-with tcp-reset
        iptables -t filter -m owner --uid-owner shadowsocks -A SHADOWSOCKS -p udp -j REJECT
        iptables -A OUTPUT -j SHADOWSOCKS
        iptables-save > /etc/iptables/rules.v4
    fi
}
