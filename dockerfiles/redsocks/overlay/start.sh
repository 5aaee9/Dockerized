#!/bin/sh

set -e


# Ref: https://unix.stackexchange.com/questions/20784/how-can-i-resolve-a-hostname-to-an-ip-address-in-a-bash-script
resolveip(){
    local host="$1"
    if [ -z "$host" ]
    then
        return 1
    else
        local ip=$( getent hosts "$host" | awk '{print $1}' )
        if [ -z "$ip" ]
        then
            ip=$( dig +short "$host" )
            if [ -z "$ip" ]
            then
                echo "unable to resolve '$host'" >&2
                return 1
            else
                echo "$ip"
                return 0
            fi
        else
            echo "$ip"
            return 0
        fi
    fi
}

sed -i "s/{PROXY-SERVER}/$PROXY_SERVER/g" redsocks.conf
sed -i "s/{PROXY-PORT}/$PROXY_PORT/g" redsocks.conf

# Create redsocks proxy chain
iptables -t nat -N REDSOCKS

iptables -t nat -A REDSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A REDSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A REDSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A REDSOCKS -d 240.0.0.0/4 -j RETURN

# Ignore proxy server
iptables -t nat -A REDSOCKS -d $(resolveip $PROXY_SERVER)/32 -j RETURN

# Start redirect all output
iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12345
iptables -t nat -A OUTPUT -p tcp -j REDSOCKS

/usr/bin/redsocks -c redsocks.conf
