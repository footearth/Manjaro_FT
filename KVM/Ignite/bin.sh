#!/usr/bin/env bash

export VERSION=v0.7.1
export GOARCH=$(go env GOARCH 2>/dev/null || echo "amd64")

export http_proxy=http://127.0.0.1:8123
export https_proxy=$http_proxy
curl cip.cc

for binary in ignite ignited; do
  echo "Installing ${binary}..."
  curl -fLo ${binary} https://github.com/weaveworks/ignite/releases/download/${VERSION}/${binary}-${GOARCH}
  chmod +x ${binary}
  sudo mv ${binary} /usr/local/bin
done

export CNI_VERSION=v0.8.5
export ARCH=$([ $(uname -m) = "x86_64" ] && echo amd64 || echo arm64)
sudo mkdir -p /opt/cni/bin
curl -sSL https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-linux-${ARCH}-${CNI_VERSION}.tgz | sudo tar -xz -C /opt/cni/bin
