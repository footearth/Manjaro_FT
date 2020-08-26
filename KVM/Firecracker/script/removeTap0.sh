#!/usr/bin/env bash

sudo ip link del tap0
sudo iptables -F
sudo sh -c "echo 0 > /proc/sys/net/ipv4/ip_forward"
if [ -f iptables.rules.bak ]; then
  sudo iptables-restore < iptables.rules.bak
fi
