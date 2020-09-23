# virt-manager

## Install

```bash
>> yay -S qemu virt-manager ebtables ovmf
>> sudo systemctl start libvirtd
>> sudo systemctl start virtlogd
>> sudo systemctl status libvirtd
>> sudo systemctl enable libvirtd
```

## support UEFI

```bash
>> vim /etc/libvirt/qemu.conf

>> cat /etc/libvirt/qemu.conf
```

```conf
nvram = [
  "/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd"
]
```

```bash
>> sudo systemctl restart libvirtd
>> sudo systemctl status libvirtd
```
