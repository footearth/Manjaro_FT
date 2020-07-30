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
sudo pacman -S yay
yay -S aurman
```

2. init soft

```
yay -Syu
```

- 2.1 init

```
yay -S vim
sudo mv /usr/bin/vi /usr/bin/viex
sudo ln -s /usr/bin/vim /usr/bin/vi
```

```
yay -S htop nload net-tools curl axel aria2 progress
yay -S pulseaudio pavucontrol paprefs
yay -S font-manager wqy-microhei wqy-microhei-lite wqy-bitmapfont wqy-zenhei
yay -S ttf-roboto noto-fonts ttf-dejavu
yay -S noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
yay -S ttf-wps-fonts # ttf-wps-win10 ttf-win10 ttf-windows 
yay -S all-repository-fonts
yay -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts
```

- 2.2 docker

```
yay -S docker
sudo gpasswd -a $USER docker
sudo vi /etc/docker/daemon.json
```

```json
{
  "registry-mirrors": [
    "http://f1361db2.m.daocloud.io"
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

- 3.2 browser

```
yay -S falkon google-chrome chromium vivaldi
```

- 3.3 vs code

```
yay -S visual-studio-code-bin
```

- 3.4 wine

```
yay -S wine wine_gecko wine-mono deepin-wine
```

- 3.5 wechat

```
yay -S deepin-wine-wechat
```

- 3.6 translate tool

```
yay -S goldendict stardict
```

- 3.7 download tool

```
yay -S motrix
```

- 3.8 media player

```
yay -S mpv
```

- 3.9 music player

```
yay -S netease-cloud-music
```

- 3.10 mail client

```
yay -S libsecret seahorse geary mailspring claws-mail
```

- 3.11 terminal

```
yay -S tilda terminator terminus-terminal-bin
yay -S alacritty kitty hyper
```

- 3.12 proxy

```
yay -S proxychains privoxy polipo tinyproxy
```

- 3.13 Reader

```
yay -S foliate-git fbreader
```

- 3.14 Project Drawing

```
yay -S dia yed drawio-desktop bouml staruml akira-git figma-linux
```

- 3.15 screen recorder

```
yay -S simplescreenrecorder peek
```

- 3.16 vlog

```
yay -S kdenlive openshot olive 
```

- 3.17 rdp

```
yay -S xrdesktop-git freerdp-git
```

- 3.18 bluetooth

```
yay -S bluez bluez-utils
yay -S blueman dbus alias-plugins
yay -S pulseaudio-bluetooth
yay -S pulseaudio pulseaudio-alias pavucontrol
```

- 3.19 metting

```
yay -S zoom
```

- 3.20 usb booting

```
yay -S etcher woeusb windows2usb
```

- 3.21 thunderbolt support

```
yay -S thunderbolt-software-user-space bolt tbt
```
