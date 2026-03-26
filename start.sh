#!/bin/bash

# Tailscale daemon ko userspace mode mein start karein
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &

# Thoda wait karein taaki daemon start ho jaye
sleep 5

# Agar TAILSCALE_AUTHKEY environment variable set hai, toh login karein
if [ -n "$TAILSCALE_AUTHKEY" ]; then
    tailscale up --authkey=$TAILSCALE_AUTHKEY --hostname=railway-vps
fi

# SSH server start karein
/usr/sbin/sshd -D
