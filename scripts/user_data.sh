#!/bin/bash

# Update the system and install necessary packages
yum update -y
yum install -y yum-utils device-mapper-persistent-data lvm2

# Enable the extras repository
yum-config-manager --enable rhui-rhel-8-for-x86_64-extras-rhui-rpms

# Install containerd
yum install -y containerd.io

# Start and enable containerd
systemctl start containerd
systemctl enable containerd
