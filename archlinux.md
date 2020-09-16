# Arch Linux

## 安装

### Before Chroot

- Set Root Password

```
>> passwd
```

- Start SSH

```
>> systemctl start sshd
```

- Config ip

```
ip addr add 10.10.10.101 dev ens18
ip route add 10.10.10.0/24 dev ens18
ip route add default via 10.10.10.1 dev ens18
```

- Remote Login

```
>> ssh root@<ip address>
```

- Check Boot Mode

```
>> ls /sys/firmware/efi/efivars
```

- Check Internet Connection

```
>> ping -c3 223.8.8.8
```

- Setup Mirrors

```
>> mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && cat /etc/pacman.d/mirrorlist.bak | \
  grep --no-group-separator -A1 "China" > /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist

>> pacman -Syy
>> pacman -Sy reflector

>> reflector -c CN -p https -a 12 --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist
```

- Update the System Clock

```
>> timedatectl set-ntp true && date
```

- Select the Disk to Partition

```
>> cfdisk /dev/sdx
>> cgdisk /dev/sdx
>> lsblk
>> lsblk -f
```

- Format the Partitions

```
>> mkfs.fat -F32 /dev/sda1 # 300M
>> mkswap /dev/sda2 # 4-8G
>> mkfs.ext4 /dev/sda3 # left all
```

- Mount the File Systems

```
mount /dev/sda3 /mnt
swapon /dev/sda2
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
```

- Install the Base Packages

```
>> pacstrap /mnt \
  base base-devel \
  linux linux-headers linux-firmware \
  bash-completion net-tools networkmanager vim \
  man-db man-pages openssh reflector
```

- Fstab

```
>> genfstab -U /mnt >> /mnt/etc/fstab && cat /mnt/etc/fstab
```

- Chroot

```
>> arch-chroot /mnt
```

### After Chroot

- Time Zone

```
>> ln -sf /usr/share/zoneinfo/Pacific/Auckland /etc/localtime
>> hwclock --systohc
```

- Localization

```
>> vim /etc/locale.gen
>> cat /etc/locale.gen | grep en_US
>> locale-gen
>> echo LANG=en_US.UTF-8 > /etc/locale.conf && cat /etc/locale.conf
```

- Host Name

```
>> echo arch > /etc/hostname && cat /etc/hostname
```

- Hostnames

```
>> vim /etc/hosts
>> cat /etc/hosts
```

- Password

```
>> passwd
```

- Install EFI Boot Manager

```
>> bootctl --path=/boot install
```

- Loader Configuration

```
>> vim /boot/loader/loader.conf
>> cat /boot/loader/loader.conf

#timeout 3
#console-mode keep
default arch-*
```

- Add Arch Linux Loader Entry

```
>> vim /boot/loader/entries/arch.conf
>> cat /boot/loader/entries/arch.conf

title	Arch Linux
linux	/vmlinuz-linux
initrd	/initramfs-linux.img
options	root=UUID=f691168b-f435-453c-b024-bc34baf0fc5f rw
```

- Boot to Actual System

```
>> exit
>> reboot
```

### Post Installation

- Config Network

```
ip addr
ip route
iw
nmcli
nmtui
```

- Start the Daemon

```
systemctl start NetworkManager
systemctl enable NetworkManager
systemctl start sshd
systemctl enable sshd
```

- Add User

```
>> useraddd -m footearth
>> passwd footearth
>> visudo
```

- Allow Root SSH Remote Login

```
>> vim /etc/ssh/sshd_config
>> cat /etc/ssh/sshd_config | grep PermitRootLogin

PermitRootLogin yes
```

## 参考资料

- https://marvintan.com/posts/arch-linux-installation-guide-part-1/
- https://itsfoss.com/install-arch-linux/
- https://hjortsberg.org/notes/Installing-ArchLinux.html

- https://blog.cvhc.cc/html/zh/isp/isp_37388.html
- https://mlog.club/article/5435985

- https://anarchyinstaller.org/index.html
