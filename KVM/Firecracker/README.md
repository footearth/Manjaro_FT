# Firecracker

### 安装 firecracker

```bash
latest=$(basename $(curl -fsSLI -o /dev/null -w  %{url_effective} https://github.com/firecracker-microvm/firecracker/releases/latest))
curl -LOJ https://github.com/firecracker-microvm/firecracker/releases/download/${latest}/firecracker-${latest}-$(uname -m)
mv firecracker-${latest}-$(uname -m) firecracker
chmod +x firecracker
mv firecracker /usr/local/bin/firecracker
```

### 安装 firectl

```bash
curl -Lo firectl https://firectl-release.s3.amazonaws.com/firectl-v0.1.0
curl -Lo firectl.sha256 https://firectl-release.s3.amazonaws.com/firectl-v0.1.0.sha256
sha256sum -c firectl.sha256
chmod +x firectl
mv firectl /usr/local/bin/firecracker
```

## 测试

### 网络支持

#### Host 创建网卡

```bash
sudo ip tuntap add tap0 mode tap
sudo ip addr add 172.16.0.1/24 dev tap0
sudo ip link set tap0 up
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo iptables -t nat -A POSTROUTING -o ${br0} -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i tap0 -o ${br0} -j ACCEPT
```

#### Host 移除网卡

```bash
sudo ip link del tap0
sudo iptables -F
sudo sh -c "echo 0 > /proc/sys/net/ipv4/ip_forward"
if [ -f iptables.rules.bak ]; then
  sudo iptables-restore < iptables.rules.bak
fi
```

#### Host Iptable 配置备份

```bash
sudo iptables-save > iptables.rules.old
```

#### Guest 网卡配置

```bash
ip addr add 172.16.0.2/24 dev eth0
ip link set eth0 up
ip route add default via 172.16.0.1 dev eth0

echo > /etc/resolv.conf <<EOF
nameserver  8.8.8.8
EOF
```

### 启动流程

#### 手工启动服务

```bash
firecracker --api-sock /tmp/firecracker.socket
```

#### 初始化 kernel、rootfs 与 网络

- kernel

```bash
arch=`uname -m`
kernel_path=$(pwd)"/hello-vmlinux.bin"

if [ ${arch} = "x86_64" ]; then
  curl --unix-socket /tmp/firecracker.socket -i \
    -X PUT 'http://localhost/boot-source'   \
    -H 'Accept: application/json'           \
    -H 'Content-Type: application/json'     \
    -d "{
       \"kernel_image_path\": \"${kernel_path}\",
       \"boot_args\": \"console=ttyS0 reboot=k panic=1 pci=off\"
       }"
elif [ ${arch} = "aarch64" ]; then
  curl --unix-socket /tmp/firecracker.socket -i \
    -X PUT 'http://localhost/boot-source'   \
    -H 'Accept: application/json'           \
    -H 'Content-Type: application/json'     \
    -d "{
       \"kernel_image_path\": \"${kernel_path}\",
       \"boot_args\": \"keep_bootcon console=ttyS0 reboot=k panic=1 pci=off\"
       }"

else
  echo "Cannot run firecracker on $arch architecture!"
  exit 1
fi
```

- rootfs

```bash
rootfs_path=$(pwd)"/hello-rootfs.ext4"

curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/drives/rootfs' \
  -H 'Accept: application/json'           \
  -H 'Content-Type: application/json'     \
  -d "{
     \"drive_id\": \"rootfs\",
     \"path_on_host\": \"${rootfs_path}\",
     \"is_root_device\": true,
     \"is_read_only\": false
     }"
```

- network

```bash
curl -X PUT \
  --unix-socket /tmp/firecracker.socket \
  http://localhost/network-interfaces/eth0 \
  -H accept:application/json \
  -H content-type:application/json \
  -d '{
      "iface_id": "eth0",
      "guest_mac": "AA:FC:00:00:00:01",
      "host_dev_name": "tap0"
    }'
```

#### firectl 启动服务

```bash
firectl \
  --kernel=./hello-vmlinux.bin \
  --root-drive=./hello-rootfs.ext4 \
  --tap-device=tap0/AA:FC:00:00:00:01
```

#### 清除服务

```bash
killall firecracker
rm -f /tmp/firecracker.socket
```

#### 启动实例

```bash
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/actions'       \
  -H  'Accept: application/json'          \
  -H  'Content-Type: application/json'    \
  -d '{
     "action_type": "InstanceStart"
     }'
```

#### Alpine

```bash 
sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
apk update && apk upgrade
``` 

## 参考材料

- [Getting Started with Firecracker](https://github.com/firecracker-microvm/firecracker/blob/master/docs/getting-started.md)
- [Getting Started Firecracker Network Setup](https://github.com/firecracker-microvm/firecracker/blob/2c375691c9655c5c2b04aaa402d0c7ca74bc8126/docs/network-setup.md)
- [Add DNS and config file help to network-setup.md](https://github.com/firecracker-microvm/firecracker/pull/1794/commits/37d846c288bcf1826aef07a659bd88aa9d7a5ba6)

- [Alpine 清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/alpine/)
- [把玩Alpine linux(二):APK包管理器](https://www.jianshu.com/p/4b76a7931ea0)

- [Firecracker – 无服务器计算的轻量级虚拟化](https://aws.amazon.com/cn/blogs/china/firecracker-lightweight-virtualization-for-serverless-computing/)
- [深度解析 AWS Firecracker 实战篇 – 一起动手点炮竹](https://aws.amazon.com/cn/blogs/china/in-depth-analysis-of-aws-firecracker/)
