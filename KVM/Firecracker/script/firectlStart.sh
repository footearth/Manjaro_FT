#!/usr/bin/env bash

killall firecracker

rm -f /tmp/firecracker.socket

firectl \
  --kernel=./hello-vmlinux.bin \
  --root-drive=./hello-rootfs.ext4 \
  --tap-device=tap0/AA:FC:00:00:00:01
