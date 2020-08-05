# Podman

```
yay -S podman

# use fish shell
sudo touch /etc/sub{u, g}id
USER=(whoami) subid=/etc/subuid sudo bash -lc "echo '$USER:100000:65536' > $subid"
USER=(whoami) subid=/etc/subgid sudo bash -lc "echo '$USER:100000:65536' > $subid"

podman system migrate
podman unshare cat /proc/self/uid_map

cat <<EOF > $HOME/.config/containers/registries.conf
unqualified-search-registries = ['docker.io']

[[registry]]
prefix = "docker.io"
location = "hub-mirror.c.163.com"
EOF
```

### 失效

```
cat <<EOF > $HOME/.config/containers/registries.conf
unqualified-search-registries = ['docker.io', 'k8s.gcr.io', 'quay.io']

[[registry]]
prefix = "docker.io"
location = "hub-mirror.c.163.com"

[[registry.mirror]]
prefix = "docker.io"
location = "dockerhub.azk8s.cn"

[[registry]]
prefix = "k8s.gcr.io"
location = "gcr.azk8s.cn/google_containers"
# location = "registry.aliyuncs.com/google_containers"

[[registry]]
prefix = "quay.io"
location = "quay.azk8s.cn"
EOF
```

[ "/entrypoint.sh", "-m", "ss-server", "-s", "-s 0.0.0.0 -p 6443 -m chacha20-ietf-poly1305 -k netserver", "-x", "-e" , "kcpserver", "-k", "-t 127.0.0.1:6443 -l :6500 -mode fast2" ]
