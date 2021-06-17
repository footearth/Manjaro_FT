# Manjaro Config

## Init

### Mirrors

```bash
>> sudo pacman-mirrors -i -c China -m rank -g
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
>> sudo pacman -Syyu
```

### Yay

```bash
>> sudo pacman -Syy yay

# >> sudo pacman-mirrors -g
# >> sudo pacman -Syy
# >> sudo pacman -S archlinux-keyring
# >> sudo pacman-key --populate archlinux
# >> sudo pacman-key --refresh-keys
```

```bash
>> mkdir ~/.config/yay
>> yay -Syu --devel --combinedupgrade --save
>> yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
>> yay -P -g
```

```bash
>> yay -S base-devel
```

```bash
>> yay -Syyu
```

### Go mirror

```bash
>> yay -S go
>> go env -w GO111MODULE=on
>> go env -w GOPROXY=https://goproxy.io,direct
```

## Server && Desktop

### Vim

```bash
>> yay -S vim neovim helix-bin amp
>> sudo mv /usr/bin/vi /usr/bin/viex
>> sudo ln -s /usr/bin/nvim /usr/bin/vi
```

### Base

```bash
>> yay -S zsh fish
>> yay -S mosh
>> yay -S tmux tmuxp

>> yay -S unzip neofetch
>> yay -S exa lsd

>> yay -S jq bat fd multitail
>> yay -S ripgrep the_silver_searcher fzf ack # the_silver_searcher = ag
>> yay -S progress pv # cv
>> yay -S duf ncdu dust diskus # tin-summer(need rust; cmd: sn ar)
>> yay -S ranger mc 

>> yay -S nload net-tools
>> yay -S axel aria2
>> yay -S curl httpie
>> yay -S htop glances
>> # yay -S atop bashtop iotop iftop nmon
>> # yay -S cpustat vmstat dstat

>> yay -S tig gitui lazygit
```

### Docker

```bash
>> yay -S docker
>> sudo gpasswd -a $USER docker
>> sudo mkdir -p /etc/docker
>> sudo vi /etc/docker/daemon.json
```

```json
{
  "registry-mirrors": [
    "https://registry.cn-hangzhou.aliyuncs.com",
    "https://docker.mirrors.ustc.edu.cn",
    "https://hub-mirror.c.163.com",
    "https://mirror.ccs.tencentyun.com"
  ]
}
```

```bash
>> sudo systemctl restart docker
>> sudo systemctl enable docker
```

### Proxy

```bash
>> yay -S proxychains privoxy polipo tinyproxy
```

### Browser

```bash
>> yay -S falkon
```


## Server

### sshd

```bash
>> yay -S dropbear # mosh openssh
```

## Desktop

### Fonts

```bash
>> yay -S font-manager wqy-microhei wqy-microhei-lite wqy-bitmapfont wqy-zenhei
>> yay -S ttf-roboto noto-fonts ttf-dejavu ttf-dejavu-sans-code ttf-sarasa-gothic
>> yay -S noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
>> yay -S ttf-wps-fonts # ttf-wps-win10 ttf-win10 ttf-windows 
>> yay -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts

>> # -- yay -S all-repository-fonts --
```

### Input -- ibus-rime

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

### Browser

```bash
>> yay -S brave
>> yay -S microsoft-edge-dev-bin
>> yay -S vivaldi
>> yay -S google-chrome chromium 
>> yay -S opera
>> yay -S palemoon
```

### VS Code

```bash
>> yay -S visual-studio-code-bin
```

### wine

```bash
>> yay -S wine wine_gecko wine-mono # deepin-wine
```

### WeChat

```bash
>> yay -S wechat-uos

>> # yay -S deepin-wine-wechat
```

### Media Player

```bash
>> yay -S mpv
```

### Music Player

```bash
>> yay -S netease-cloud-music
```

### Wps Office

```bash
>> yay -S wps-office
```

### Terminal

```bash
>> yay -S tilda terminator
>> yay -S terminus-terminal-bin # proxy

>> # yay -S alacritty kitty hyper
```

### Reader

```bash
>> yay -S foliate fbreader
```

### Usb Booting

```bash
>> yay -S etcher

>> # yay -S woeusb windows2usb
```

### albert

```bash
>> yay -S utools # proxy
>> # albert-minimal proxy

>> # yay -S albert
>> # yay -S albert-lite
```

### kodi todesk deskcreen(gnome-network-displays) m3u8-downloader



----
----
----

## Other

### Paru

```bash
>> sudo yay -S paru # proxy
```

### Sync Date

```bash
>> date
>> sudo ntpdate ntp1.aliyun.com
>> sudo hwclock -w
```

### arandr

```bash
>> yay -S arandr
```

### switchhosts

```bash
>> yay -S switchhosts-bin # proxy
```

### Screenshot

```bash
>> yay -S scrot shutter flameshot deepin-screenshot
```

### Translator

```bash
>> yay -S goldendict stardict
```

### Download

```bash
>> yay -S motrix
```

### Caffeine

```bash
>> yay -S caffeine
```

### switch kernel

```bash
>> yay -Ss linux5 | grep 'and modules'
>> yay -Ss linux5 | grep 'headers'
>> sudo mhwd-kernel -i linux57 linu57-headers
>> sudo mhwd-kernel -i linux57 rmc
```

### vm

```bash
>> yay -S virtualbox canonical-multipass kata-linux-container
```

### lm_sensors

```bash
>> yay -S lm_sensors xsensors fancontrol_gui
```

```bash
>> sudo sensors-detect
>> sudo sensors -s
>> sensors -u
>> inxi -F
```

### mail client

```bash
>> yay -S libsecret seahorse geary mailspring claws-mail protonmail-desktop
```

### Project Drawing

```bash
>> yay -S dia yed drawio-desktop bouml staruml akira-git figma-linux
```

### screen recorder

```bash
>> yay -S kazam simplescreenrecorder peek qt-recordmydesktop
```

### vlog

```bash
>> yay -S kdenlive openshot olive 
```

### rdp

```bash
>> yay -S xrdesktop-git freerdp-git
```

### bluetooth

```bash
>> yay -S bluez bluez-utils
>> yay -S blueman dbus # alias-plugins
>> yay -S pulseaudio-bluetooth
>> yay -S pulseaudio pavucontrol # pulseaudio-alias 

>> yay -S paprefs
```

### metting

```bash
>> yay -S zoom
```

### thunderbolt support

```bash
>> yay -S thunderbolt-software-user-space bolt tbt
```

### helper like man page

```bash
>> yay -S cheat tldr ruby-bropages
```

### simple-scan

```bash
>> yay -S simple-scan
```

### vnc server && client

```bash
>> yay -S tigervnc tigervnc-viewer
>> vncserver -alwaysshared -dpi 96 :1
>> x0vncserver -display :0 -passwordfile ~/.vnc/passwd
>> vncserver -kill :1
>> vncviewer ${ip}:1
```

### Budgie Desktop

```bash
>> yay -S budgie-desktop
```

```conf
# .xinitrc
export XDG_CURRENT_DESKTOP=Budgie:GNOME
exec budgie-desktop
```

### pm

```bash
>> yay -S pm
```

### eDex UI

```bash
>> yay -S edex-ui-git
```
