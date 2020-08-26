#!/usr/bin/env bash

rm -rf ./../hello*

arch=`uname -m`
dest_kernel="./hello-vmlinux.bin"
dest_rootfs="./hello-rootfs.ext4"
image_bucket_url="https://s3.amazonaws.com/spec.ccfc.min/img"

export http_proxy=http://127.0.0.1:8123
export https_proxy=$http_proxy
curl cip.cc

if [ ${arch} = "x86_64" ]; then
  kernel="${image_bucket_url}/hello/kernel/hello-vmlinux.bin"
  rootfs="${image_bucket_url}/hello/fsfiles/hello-rootfs.ext4"
elif [ ${arch} = "aarch64" ]; then
  kernel="${image_bucket_url}/aarch64/ubuntu_with_ssh/kernel/vmlinux.bin"
  rootfs="${image_bucket_url}/aarch64/ubuntu_with_ssh/fsfiles/xenial.rootfs.ext4"
else
  echo "Cannot run firecracker on $arch architecture!"
  exit 1
fi

echo "Downloading $kernel..."
curl -fsSL -o $dest_kernel $kernel

echo "Downloading $rootfs..."
curl -fsSL -o $dest_rootfs $rootfs

echo "Saved kernel file to $dest_kernel and root block device to $dest_rootfs."
