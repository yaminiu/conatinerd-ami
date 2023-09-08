#!/bin/bash

# Configure containerd
cat <<EOF > /etc/containerd/config.toml
[plugins."io.containerd.grpc.v1.cri".containerd]
  snapshotter = "overlayfs"
  disable_snapshot_annotations = true
[plugins."io.containerd.grpc.v1.cri".cni]
  bin_dir = "/opt/cni/bin"
  conf_dir = "/etc/cni/net.d"
[plugins."io.containerd.grpc.v1.cri".registry]
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
    [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
      endpoint = ["https://registry-1.docker.io"]
[plugins."io.containerd.grpc.v1.cri".registry.configs]
  [plugins."io.containerd.grpc.v1.cri".registry.configs."docker.io".auth]
    username = ""
    password = ""
    auth = ""
    identitytoken = ""
[plugins."io.containerd.grpc.v1.cri".runtime]
  runtime_type = "io.containerd.runtime.v1.linux"
EOF

# Restart containerd
systemctl restart containerd

# install containerd-nerdctl
# Download containerd-nerdctl
git clone https://github.com/containerd/nerdctl.git

# Build containerd-nerdctl
cd nerdctl
make
cd ..

# Copy binary to /usr/local/bin
sudo cp nerdctl/build/nerdctl /usr/local/bin/

Set permissions
sudo chmod +x /usr/local/bin/nerdctl

# Verify installation
nerdctl --version