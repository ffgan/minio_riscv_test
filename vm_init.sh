#! /bin/bash
# create user and grant sudo permission
useradd -m -s /bin/bash john
echo "john:test123@#" | chpasswd

date -s "2025-05-28 10:00:00"

dnf install chrony git make tar -y
timedatectl set-timezone "Asia/Shanghai"
systemctl enable chronyd
systemctl start chronyd
date
chronyc makestep

# create swap file
free -mh
df -mh
dd if=/dev/zero of=/swapfile count=8192 bs=1M
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
# switch to john user and run commands
