# Manjaro Config

1. init config

```
sudo pacman-mirrors -i -c China -m rank
```


```
sudo vi /etc/pacman.conf

```

```
[archlinuxcn]
# SigLevel = Optional TrustedOnly
SigLevel = Never
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

[arch4edu]
SigLevel = Never
Server = https://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch
```

```
sudo pacman-mirrors -g
sudo pacman -Syy
sudo pacman -S archlinux-keyring
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys
sudo pacman -S yay
```

2. init soft

```
yay -Syu
```

- 2.1 init

```
date
yay -S ntpdate
sudo ntpdate ntp1.aliyun.com
sudo hwclock -w
```

```
yay -S vim
sudo mv /usr/bin/vi /usr/bin/viex
sudo ln -s /usr/bin/vim /usr/bin/vi
```

```
yay -S nload net-tools curl axel aria2
yay -S progress cv pv the_silver_searcher ripgrep
yay -S htop atop bashtop iotop iftop nmon
yay -S cpustat vmstat dstat
yay -S glances ncdu ranger mc 
<<<<<<< HEAD
yay -S tig multitail httpie
=======
yay -S tig pm multitail httpie
>>>>>>> add some base cmd
yay -S pulseaudio pavucontrol paprefs
yay -S font-manager wqy-microhei wqy-microhei-lite wqy-bitmapfont wqy-zenhei
yay -S ttf-roboto noto-fonts ttf-dejavu ttf-dejavu-sans-code ttf-sarasa-gothic
yay -S noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
yay -S ttf-wps-fonts # ttf-wps-win10 ttf-win10 ttf-windows 
yay -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts
# -- yay -S all-repository-fonts --
**yay -S pm**
yay -S tmux zsh fish
```

- 2.2 docker

```
yay -S docker
sudo gpasswd -a $USER docker
sudo mkdir -p /etc/docker
sudo vi /etc/docker/daemon.json
```

```json
{
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://mirror.ccs.tencentyun.com"
  ]
}
```

```
sudo systemctl restart docker
sudo systemctl enable docker
```

- 2.3 vm

```
yay -S virtualbox canonical-multipass kata-linux-container
```

3. X soft

- 3.1 input

```
yay -S ibus ibus-qt ibus-rime
```

```
ibus-setup
ibus-daemon
```

```
vi ~/.xprofile

```

```
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -d -x
```

```
vi ~/.profile
```

```
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
```

- 3.2 arandr

```
yay -S arandr
```

- 3.3 lm_sensors

```
yay -S lm_sensors xsensors fancontrol_gui
```

```
sudo sensors-detect
sudo sensors -s
sensors -u
inxi -F
```

- 3.4 browser

```
yay -S falkon google-chrome chromium **vivaldi** brave
```

- 3.5 vs code

```
yay -S visual-studio-code-bin
```

- 3.6 wine

```
yay -S wine wine_gecko wine-mono deepin-wine
```

- 3.7 wechat

```
yay -S deepin-wine-wechat
```

- 3.8 translate tool

```
yay -S goldendict stardict
```

- 3.9 download tool

```
yay -S motrix
```

- 3.10 media player

```
yay -S mpv
```

- 3.11 music player

```
yay -S netease-cloud-music
```

- 3.12 mail client

```
yay -S libsecret seahorse geary mailspring claws-mail protonmail-desktop
```

- 3.13 terminal

```
yay -S tilda terminator **terminus-terminal-bin**
yay -S alacritty kitty hyper
```

- 3.14 proxy

```
yay -S proxychains privoxy polipo tinyproxy
```

- 3.15 Reader

```
yay -S foliate-git fbreader
```

- 3.16 Project Drawing

```
yay -S dia yed drawio-desktop bouml staruml akira-git figma-linux
```

- 3.17 screen recorder

```
yay -S simplescreenrecorder peek
```

- 3.18 vlog

```
yay -S kdenlive openshot olive 
```

- 3.19 rdp

```
yay -S xrdesktop-git freerdp-git
```

- 3.20 bluetooth

```
yay -S bluez bluez-utils
yay -S blueman dbus alias-plugins
yay -S pulseaudio-bluetooth
yay -S pulseaudio pulseaudio-alias pavucontrol
```

- 3.21 metting

```
yay -S zoom
```

- 3.22 usb booting

```
yay -S etcher woeusb windows2usb
```

- 3.23 thunderbolt support

```
yay -S thunderbolt-software-user-space bolt tbt
```

- 3.24 helper like man page

```
yay -S cheat tldr ruby-bropages
```

- 3.25 switchhosts

```
yay -S switchhosts-bin
```

- 3.26 simple-scan

```
yay -S simple-scan
```

- 3.27 vnc server && client

```
yay -S tigervnc tigervnc-viewer
vncserver -alwaysshared -dpi 96 :1
x0vncserver -display :0 -passwordfile ~/.vnc/passwd
vncserver -kill :1
vncviewer ${ip}:1
```

- 3.28 Budgie Desktop

```
yay -S budgie-desktop

# .xinitrc
export XDG_CURRENT_DESKTOP=Budgie:GNOME
exec budgie-desktop
```
