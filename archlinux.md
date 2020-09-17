# Arch Linux

## 安装

### Before Chroot

- Set Root Password

```bash
>> passwd
```

- Start SSH

```bash
>> systemctl start sshd
```

- Config ip

```bash
>> ip addr add 10.10.10.101 dev ens18
>> ip route add 10.10.10.0/24 dev ens18
>> ip route add default via 10.10.10.1 dev ens18
```

- Remote Login

```bash
>> ssh root@<ip address>
```

- Check Boot Mode

```bash
>> ls /sys/firmware/efi/efivars
```

- Check Internet Connection

```bash
>> ping -c3 223.8.8.8
```

- Setup Mirrors

```bash
>> mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && cat /etc/pacman.d/mirrorlist.bak | \
  grep --no-group-separator -A1 "China" > /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist

>> pacman -Syy
>> pacman -Sy reflector

>> reflector -c CN -p https -a 12 --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist
```

- Update the System Clock

```bash
>> timedatectl set-ntp true && date
```

- Select the Disk to Partition

```bash
>> cfdisk /dev/sdx
>> cgdisk /dev/sdx
>> lsblk
>> lsblk -f
```

- Format the Partitions

```bash
>> mkfs.fat -F32 /dev/sda1 # 300M
>> mkswap /dev/sda2 # 4-8G
>> mkfs.ext4 /dev/sda3 # left all
```

- Mount the File Systems

```bash
>> mount /dev/sda3 /mnt
>> swapon /dev/sda2
>> mkdir /mnt/boot
>> mount /dev/sda1 /mnt/boot
```

- Install the Base Packages

```bash
>> pacstrap /mnt \
  base base-devel \
  linux linux-headers linux-firmware \
  bash-completion net-tools networkmanager vim \
  man-db man-pages openssh reflector
```

- Fstab

```bash
>> genfstab -U /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab
```

- Chroot

```bash
>> arch-chroot /mnt
```

### After Chroot

- Time Zone

```bash
>> ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
>> hwclock --systohc
```

- Localization

```bash
>> vim /etc/locale.gen
>> cat /etc/locale.gen | grep en_US
>> locale-gen
>> echo LANG=en_US.UTF-8 > /etc/locale.conf && cat /etc/locale.conf
```

- Host Name

```bash
>> echo arch > /etc/hostname && cat /etc/hostname
```

- Hostnames

```bash
>> vim /etc/hosts
>> cat /etc/hosts
```

```conf
127.0.0.1	  localhost
::1		      localhost
127.0.1.1	  myhostname.localdomain	myhostname
```

- Password

```bash
>> passwd
```

- Install EFI Boot Manager

```bash
>> bootctl --path=/boot install
```

- Loader Configuration

```bash
>> vim /boot/loader/loader.conf
>> cat /boot/loader/loader.conf
```

```conf
#timeout 3
#console-mode keep
default arch-*
```

- Add Arch Linux Loader Entry

```bash
>> vim /boot/loader/entries/arch.conf
>> cat /boot/loader/entries/arch.conf
```

```conf
title	Arch Linux
linux	/vmlinuz-linux
initrd	/initramfs-linux.img
options	root=UUID=f691168b-f435-453c-b024-bc34baf0fc5f rw
```

- Boot to Actual System

```bash
>> exit
>> reboot
```

### Post Installation

- Config Network

```bash
>> ip addr
>> ip route
>> iw
>> nmcli
>> nmtui
```

- Start the Daemon

```bash
>> systemctl start NetworkManager
>> systemctl enable NetworkManager
>> systemctl start sshd
>> systemctl enable sshd
```

- Add User

```bash
>> useraddd -m footearth
>> passwd footearth
>> visudo
```

- Allow Root SSH Remote Login

```bash
>> vim /etc/ssh/sshd_config
>> cat /etc/ssh/sshd_config | grep PermitRootLogin
```

```conf
PermitRootLogin yes
```

## 参考资料

- https://marvintan.com/posts/arch-linux-installation-guide-part-1/
- https://itsfoss.com/install-arch-linux/
- https://hjortsberg.org/notes/Installing-ArchLinux.html

- https://blog.cvhc.cc/html/zh/isp/isp_37388.html
- https://mlog.club/article/5435985

- https://anarchyinstaller.org/index.html
