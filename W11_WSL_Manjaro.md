# Win11 开发环境

## 准备

- U 盘刻制
- PE 准备
- 磁盘规划
- 安装系统
- 中文环境
- 梯子自备
- 电脑管家
- Obsidian

## Dev

### Scoop

```powershell
>> Set-ExecutionPolicy RemoteSigned -scope CurrentUser
>> iwr -useb get.scoop.sh | iex
```

```powershell
>> scoop install aria2
>> scoop config aria2-enabled true
>> scoop install curl axel

>> # powershell proxy env
>> $env:http_proxy="http://localhost:8118"
>> $env:https_proxy=$env:http_proxy
>> scoop/shim/curl cip.cc
>> # nu shell proxy env
>> let-env http_proxy = http://localhost:8118
>> let-env https_proxy = $nu.env.http_proxy
>> curl cip.cc

>> scoop install git
>> scoop bucket add extras
>> scoop update

>> scoop install vim neovim nu
>> scoop install posh-git oh-my-posh3

>> # config oh-my-posh
>> mkdir -p $PROFILE
>> touch $PROFILE
>> nvim $PROFILE
>> oh-my-posh --init --shell pwsh --config "$(scoop prefix oh-my-posh3)\themes\ys.omp.json" | Invoke-Expression

>> scoop install uget
>> scoop install tabby windterm mobaxterm
>> scoop install busybox msys2

>> # config msys2
>> export PATH=/c/Users/$USER/scoop/shims:$PATH

>> # Install "oh-my-bash" or "bash-it"
>> # - https://github.com/ohmybash/oh-my-bash
>> # - https://github.com/Bash-it/bash-it
>> export OSH=$HOME/.oh-my-bash
>> alias vi="nvim"

>> scoop install telnet

>> scoop bucket add nerd-fonts
>> scoop install DejaVuSansMono-NF-Mono DejaVuSansMono-NF
>> scoop install Hack-NF-Mono Hack-NF
```

### ManjaroWSL

```powershell
>> dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
>> dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# restart win11

>> wsl --update
>> wsl --shutdown
>> wsl -l -v
```

```bash
>> passwd
>> useradd -m -G wheel -s /bin/bash <username>
>> passwd <username>
>> exit
```

```powershell
>> wsl
```

```bash
>> sudo su - <username>
>> exit
```

#### Change User 

```powershell
>> .\Manjaro.exe config --default-user <username>
>> .\Manjaro.exe --default-uid 1000
>> wsl
```

```powershell
>> .\Manjaro.exe backup --tgz
>> .\Manjaro.exe install backup.tar.gz
```

```powershell
>> usermod -l <newuser> <olduser>

>> sudo pkill -u <olduser>
>> sudo pkill -9 -u <olduser>

>> sudo usermod -d /home/<newuser> -m <newuser>

>> groupmod -n <newuser> <olduser>
>> sudo usermod -u 1000 <newuser>

>> id <newuser>
```

### Manajro Init

#### Docker

```bash
>> sudo visudo
<username> ALL=(ALL) NOPASSWD: /usr/bin/dockerd

>> vi ~/.bashrc
# Start Docker daemon automatically when logging in if not running.
RUNNING=`ps aux | grep dockerd | grep -v grep`
if [ -z "$RUNNING" ]; then
  sudo dockerd > /dev/null 2>&1 &
  disown
fi

>> sudo usermod -a -G docker $USER
```

#### Podman

- [swseighman/Podman-Fedora-WSL2 (github.com)](https://github.com/swseighman/Podman-Fedora-WSL2)
- [Running podman rootless gives ERRO[0000] cannot setup namespace using newuidmap: exit status 1 · Issue #2788 · containers/podman (github.com)](https://github.com/containers/podman/issues/2788)

```bash
>> yay -S podman buildah skopeo
>> sudo touch /etc/sub{u, g}id # fish
>> USER=(whoami) subid=/etc/subuid sudo bash -lc "echo '$USER:100000:65536' > $subid"
>> USER=(whoami) subid=/etc/subgid sudo bash -lc "echo '$USER:100000:65536' > $subid"

>> cat /etc/subuid
<your-username>:100000:65536

>> cat /etc/subgid
<your-username>:100000:65536

>> sudo usermod --add-subuids 10000-75535 <your-username>
>> sudo usermod --add-subgids 10000-75535 <your-username>
# or
>> echo <your-username>:10000:65536 >> /etc/subuid
>> echo <your-username>:10000:65536 >> /etc/subgid

>> cat /etc/subgid
<your-username>:100000:65536
<your-username>:10000:65536

>> cat /etc/subuid
<your-username>:100000:65536
<your-username>:10000:65536

>> vi .bashrc # append end of .bashrc
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  export XDG_RUNTIME_DIR=/run/user/$UID
  if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR=/tmp/$USER-runtime
    if [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
      mkdir -m 0700 "$XDG_RUNTIME_DIR"
    fi
  fi
fi

if [[ -d /mnt/wslg/runtime-dir ]]; then
  sudo chown $USER:$USER /mnt/wslg/runtime-dir
  sudo chmod 0700 /mnt/wslg/runtime-dir
fi

>> sudo vi /etc/containers/containers.conf

replace: cgroup_manager = "systemd"
to: cgroup_manager = "cgroupfs"

replace: events_logger = "journald"
to: events_logger = "file"

>> sudo vi /etc/sysctl.conf
net.ipv4.ip_unprivileged_port_start=0

>> sudo sysctl -p
>> ip addr | grep 172

>> sudo chmod 4755 /usr/bin/newgidmap
>> sudo chmod 4755 /usr/bin/newuidmap
```
