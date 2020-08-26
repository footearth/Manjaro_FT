# KVM

- [KVM (简体中文)](https://wiki.archlinux.org/index.php/KVM_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

### KVM 硬件支持

```
LC_ALL=C lscpu | grep Virtualization
```

#### 内核支持

```
zgrep CONFIG_KVM /proc/config.gz
lsmod | grep kvm
```

#### 准虚拟化(使用VIRTIO)

```
zgrep VIRTIO /proc/config.gz
lsmod | grep virtio
```

#### 手工导入模块

```
modprobe -r kvm_amd
modprobe kvm_amd nested=1
```

#### 模块永久生效

```
vi /etc/modprobe.d/modprobe.conf
options kvm_intel nested=1
```

#### 检查模块激活状态

```
systool -m kvm_intel -v | grep nested
```

#### 测试虚拟机

```
qemu-system-x86_64 -enable-kvm -cpu host
```

#### 获取 host 鼠标焦点

```
Ctrl(L) + Alt(L) + G
```

### 安装 KVM

```
yay -S qemu libvirt ovmf virt-manager qemu-kvm
```

#### 开启 libvirt 服务

```
systemctl enable libvirtd
systemctl start libvirtd
```

#### 将用户加入KVM组

```
usermod -a -G kvm username
```

#### MacOS on KVM

- https://github.com/foxlet/macOS-Simple-KVM

#### 参考材料

- [ArchLinux/Manjaro 配置 KVM 环境](https://www.jianshu.com/p/392ae8181dc3)
- [KVM + MacOS](https://www.jianshu.com/p/6f8c6da20cd0)

- [arch_linux 安装 kvm](https://blog.csdn.net/sanxinge/article/details/52347998)
- [KVM 安装启动虚拟机](https://www.cnblogs.com/grglym/p/7896266.html)
- [qemu-kvm 基础（一）](https://www.jianshu.com/p/268ae6edc212)

- [KVM 虚拟化详解](https://zhuanlan.zhihu.com/p/105499858)

