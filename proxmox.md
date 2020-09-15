# proxmox

## 安装

### 引导 iso 安装

### 调整国内源

- version: 5.x 

```bash
# 删除企业源
>> rm -rf /etc/apt/sources.list.d/pve-enterprise.list

# 下载秘钥
>> wget http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg

#添加社区源
>> echo "deb http://download.proxmox.wiki/debian/pve stretch pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list

############

>> vim /etc/apt/sources.list

>> cat /etc/apt/sources.list

deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib

deb http://mirrors.aliyun.com/debian-security stretch/updates main
deb-src http://mirrors.aliyun.com/debian-security stretch/updates main

deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib

deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
```

- version: 6.x

```bash
# 删除企业源
rm -rf /etc/apt/sources.list.d/pve-enterprise.list

# 下载秘钥
wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg

# 添加社区源
echo "deb http://download.proxmox.wiki/debian/pve buster pve-no-subscription" >/etc/apt/sources.list.d/pve-install-repo.list

############

>> vim /etc/apt/sources.list

>> cat /etc/apt/sources.list

# deb http://ftp.debian.org/debian buster main contrib
# deb http://ftp.debian.org/debian buster-updates main contrib

# security updates
# deb http://security.debian.org buster/updates main contrib

# debian aliyun source
deb https://mirrors.aliyun.com/debian buster main contrib non-free
deb https://mirrors.aliyun.com/debian buster-updates main contrib non-free
deb https://mirrors.aliyun.com/debian-security buster/updates main contrib non-free
deb https://mirrors.aliyun.com/debian/ buster-backports main non-free contrib

# proxmox source
# deb http://mirrors.ustc.edu.cn/proxmox/debian/pve buster pve-no-subscription
deb http://download.proxmox.com/debian/pve buster pve-no-subscription

```

- 清华大学开源软件镜像站

```bash
# 新建 /etc/apt/sources.list.d/pve-no-subscription.list
>> vim /etc/apt/sources.list.d/pve-no-subscription.list

>> cat /etc/apt/sources.list.d/pve-no-subscription.list

deb https://mirrors.tuna.tsinghua.edu.cn/proxmox/debian buster pve-no-subscription

############

>> vim /etc/apt/sources.list

>> cat /etc/apt/sources.lis

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
```

### 调整网络

1. 网桥模式（默认）

  **大多数无线不支持网桥**

```bash
>> vim /etc/network/interfaces

>> cat /etc/network/interfaces

auto lo
iface lo inet loopback

iface eno1 inet manual

auto vmbr0
iface vmbr0 inet static
        address 192.168.10.2
        netmask 255.255.255.0
        gateway 192.168.10.1
        bridge_ports eno1
        bridge_stp off
        bridge_fd 0
```

2. 路由模式

  **可以通宿主机网段，~~但不能通外网~~**

```bash
>> vim /etc/network/interfaces

>> cat /etc/network/interfaces

auto lo
iface lo inet loopback

auto eno1
iface eno1 inet static
        address 192.51.100.5
        netmask 255.255.255.0
        gateway 192.51.100.1
        post-up echo 1 > /proc/sys/net/ipv4/ip_forward
        post-up echo 1 > /proc/sys/net/ipv4/conf/eno1/proxy_arp

auto vmbr0
iface vmbr0 inet static
        address 203.0.113.17
        netmask 255.255.255.348
        bridge_ports none
        bridge_stp off
        bridge_fd 0
```

3. NAT 模式

  **可以通宿主机网段，可以通外网**

```bash
>> vim /etc/network/interfaces

>> cat /etc/network/interfaces

auto lo
iface lo inet loopback

auto eno1
# real IP address
iface eno0 inet static
        address 192.51.100.5
        netmask 255.255.255.0
        gateway 192.51.100.1

auto vmbr0
# private sub network
iface vmbr0 inet static
        address 10.10.10.1
        netmask 255.255.255.0
        bridge_ports none
        bridge_stp off
        bridge_fd 0
        post-up echo 1 > /proc/sys/net/ipv4/ip_forward
        post-up iptables -t net -A POSTROUTING -s '10.10.10.0/24' -o eno1 -j MASQUERADE
        post-down iptables -t net -D POSTROUTING -s '10.10.10.0/24' -o eno1 -j MASQUERADE
```

## 参考资料

- https://www.msin.ren/59
- https://pve.proxmox.com/wiki/Network_Configuration
- https://pve.proxmox.com/wiki/WLAN
- https://aikiki.top/hexo/2020/06/01/Proxmox-VE-6.2-%E5%9B%BD%E5%86%85%E6%BA%90%E8%AE%BE%E7%BD%AE/#%E6%9B%B4%E6%8D%A2-PVE-%E7%A4%BE%E5%8C%BA%E6%BA%90
- https://unix.stackexchange.com/questions/158328/network-manager-not-listing-wifi
- http://tx2.lpwei.com/index.php/archives/64/
- https://www.xiz.im/archives/134/
- https://koolshare.cn/thread-160531-1-1.html
- https://mirrors.tuna.tsinghua.edu.cn/help/proxmox/
- https://forum.proxmox.com/threads/just-got-proxmox-cannot-connect-to-wifi.69486/
