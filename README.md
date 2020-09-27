# Manjaro Config

1. init config

```bash
>> sudo pacman-mirrors -i -c China -m rank
```

```bash
>> sudo vi /etc/pacman.conf

```

```conf
[archlinuxcn]
# SigLevel = Optional TrustedOnly
SigLevel = Never
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

[arch4edu]
SigLevel = Never
Server = https://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch
```

```bash
>> sudo pacman-mirrors -g
>> sudo pacman -Syy
>> sudo pacman -S archlinux-keyring
>> sudo pacman-key --populate archlinux
>> sudo pacman-key --refresh-keys
>> sudo pacman -S yay
```

```bash
>> yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
```

```bash
>> yay -S go
>> go env -w GO111MODULE=on
>> go env -w GOPROXY=https://goproxy.io,direct
```

2. init soft

```bash
>> yay -Syyu
```

- 2.0 switch kernel

```bash
>> yay -Ss linux5 | grep 'and modules'
>> yay -Ss linux5 | grep 'headers'
>> sudo mhwd-kernel -i linux57 linu57-headers
>> sudo mhwd-kernel -i linux57 rmc
```

- 2.1 init

```bash
>> date
>> yay -S ntpdate
>> sudo ntpdate ntp1.aliyun.com
>> sudo hwclock -w
```

```bash
>> yay -S vim
>> sudo mv /usr/bin/vi /usr/bin/viex
>> sudo ln -s /usr/bin/vim /usr/bin/vi
```

```bash
>> yay -S tmux zsh fish mosh


>> yay -S bat ag fd fzf
>> yay -S nload net-tools curl axel aria2
>> yay -S progress cv pv the_silver_searcher ripgrep
>> yay -S htop atop bashtop iotop iftop nmon
>> yay -S cpustat vmstat dstat
>> yay -S glances ncdu ranger mc 
>> yay -S tig multitail httpie
>> yay -S font-manager wqy-microhei wqy-microhei-lite wqy-bitmapfont wqy-zenhei
>> yay -S ttf-roboto noto-fonts ttf-dejavu ttf-dejavu-sans-code ttf-sarasa-gothic
>> yay -S noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
>> yay -S ttf-wps-fonts # ttf-wps-win10 ttf-win10 ttf-windows 
>> yay -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts

>> yay -S pulseaudio pavucontrol paprefs

>> # -- yay -S all-repository-fonts --
```

- 2.2 docker

```bash
>> yay -S docker
>> sudo gpasswd -a $USER docker
>> sudo mkdir -p /etc/docker
>> sudo vi /etc/docker/daemon.json
```

```json
{
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://registry.cn-hangzhou.aliyuncs.com",
    "https://mirror.ccs.tencentyun.com"
  ]
}
```

```bash
>> sudo systemctl restart docker
>> sudo systemctl enable docker
```

- 2.3 vm

```bash
>> yay -S virtualbox canonical-multipass kata-linux-container
```

3. X soft

- 3.1 input

```bash
>> yay -S ibus ibus-qt ibus-rime
```

```bash
>> ibus-setup
>> ibus-daemon
```

```bash
>> vi ~/.xprofile

```

```conf
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -d -x
```

```bash
>> vi ~/.profile
```

```conf
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
```

- 3.2 arandr

```bash
>> yay -S arandr
```

- 3.3 lm_sensors

```bash
>> yay -S lm_sensors xsensors fancontrol_gui
```

```bash
>> sudo sensors-detect
>> sudo sensors -s
>> sensors -u
>> inxi -F
```

- 3.4 browser

```bash
>> yay -S falkon google-chrome chromium vivaldi brave
```

- 3.5 vs code

```bash
>> yay -S visual-studio-code-bin
```

- 3.6 wine

```bash
>> yay -S wine wine_gecko wine-mono deepin-wine
```

- 3.7 wechat

```bash
>> yay -S deepin-wine-wechat
```

- 3.8 translate tool

```bash
>> yay -S goldendict stardict
```

- 3.9 download tool

```bash
>> yay -S motrix
```

- 3.10 media player

```bash
>> yay -S mpv
```

- 3.11 music player

```bash
>> yay -S netease-cloud-music
```

- 3.12 mail client

```bash
>> yay -S libsecret seahorse geary mailspring claws-mail protonmail-desktop
```

- 3.13 terminal

```bash
>> yay -S tilda terminator terminus-terminal-bin
>> yay -S alacritty kitty hyper
```

- 3.14 proxy

```bash
>> yay -S proxychains privoxy polipo tinyproxy
```

- 3.15 Reader

```bash
>> yay -S foliate-git fbreader
```

- 3.16 Project Drawing

```bash
>> yay -S dia yed drawio-desktop bouml staruml akira-git figma-linux
```

- 3.17 screen recorder

```bash
>> yay -S simplescreenrecorder peek
```

- 3.18 vlog

```bash
>> yay -S kdenlive openshot olive 
```

- 3.19 rdp

```bash
>> yay -S xrdesktop-git freerdp-git
```

- 3.20 bluetooth

```bash
>> yay -S bluez bluez-utils
>> yay -S blueman dbus alias-plugins
>> yay -S pulseaudio-bluetooth
>> yay -S pulseaudio pulseaudio-alias pavucontrol
```

- 3.21 metting

```bash
>> yay -S zoom
```

- 3.22 usb booting

```bash
>> yay -S etcher woeusb windows2usb
```

- 3.23 thunderbolt support

```bash
>> yay -S thunderbolt-software-user-space bolt tbt
```

- 3.24 helper like man page

```bash
>> yay -S cheat tldr ruby-bropages
```

- 3.25 switchhosts

```bash
>> yay -S switchhosts-bin
```

- 3.26 simple-scan

```bash
>> yay -S simple-scan
```

- 3.27 vnc server && client

```bash
>> yay -S tigervnc tigervnc-viewer
>> vncserver -alwaysshared -dpi 96 :1
>> x0vncserver -display :0 -passwordfile ~/.vnc/passwd
>> vncserver -kill :1
>> vncviewer ${ip}:1
```

- 3.28 Budgie Desktop

```bash
>> yay -S budgie-desktop
```

```conf
# .xinitrc
export XDG_CURRENT_DESKTOP=Budgie:GNOME
exec budgie-desktop
```

- 3.29 pm

```bash
>> yay -S pm
```

- 3.30 albert

```bash
>> yay -S albert-lite
>> yay -S albert
```
