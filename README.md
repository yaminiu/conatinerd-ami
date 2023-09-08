# conatinerd-ami
build aws ami for eks continerd worknode

```
packer/
|-- rhel8-containerd.json
|-- scripts/
|   |-- user_data.sh
|   |-- install_containerd.sh
```
## build ami
```
packer build packer/rhel8-containerd.json
```
