#!/usr/bin/env bash

rm -f /tmp/firecracker.socket && \
firecracker --api-sock /tmp/firecracker.socket
