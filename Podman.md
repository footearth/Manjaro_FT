# Podman

```
yay -S podman

sudo echo "footearth:100000:65536" > /etc/subuid
sudo echo "footearth:100000:65536" > /etc/subgid

podman system migrate
podman unshare cat /proc/self/uid_map

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

[[registry]]
prefix = "quay.io"
location = "quay.azk8s.cn"
EOF
```

[ "/entrypoint.sh", "-m", "ss-server", "-s", "-s 0.0.0.0 -p 6443 -m chacha20-ietf-poly1305 -k netserver", "-x", "-e" , "kcpserver", "-k", "-t 127.0.0.1:6443 -l :6500 -mode fast2" ]
