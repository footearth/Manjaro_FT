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
```

2. init soft

```
yay -Syu
```

```
yay -S vim
sudo mv /usr/bin/vi /usr/bin/viex
sudo ln -s /usr/bin/vim /usr/bin/vi
```

```
yay -S htop nload net-tools curl axel aria2
yay -S wqy-microhei wqy-microhei-lite wqy-bitmapfont wqy-zenhei
yay -S ttf-roboto noto-fonts ttf-dejavu
yay -S noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
yay -S ttf-wps-fonts # ttf-wps-win10 ttf-win10 ttf-windows 
yay -S adobe-source-code-pro-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts
```

3. soft

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
yay -S google-chrome chromium vivaldi
```

- 3.3 download tool

```
yay -S motrix
```

- 3.4 vs code

```
yay -S visual-studio-code-bin
```

- 3.5 docker

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

- 3.6 wine

```
yay -S wine wine_gecko wine-mono deepin-wine
```

- 3.7 wechat

```
yay -S deepin-wine-wechat
```

