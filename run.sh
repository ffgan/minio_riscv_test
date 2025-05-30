#! /bin/bash
set -e
uname -m

date -s "2025-05-28 10:00:00"

dnf install chrony git make tar -y
timedatectl set-timezone "Asia/Shanghai"
systemctl enable chronyd
systemctl start chronyd
date
chronyc makestep

curl https://dl.google.com/go/go1.24.3.linux-riscv64.tar.gz -o go1.24.3.linux-riscv64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.3.linux-riscv64.tar.gz
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin

useradd -m -s /bin/bash john
echo "john:testtesttest" | chpasswd

free -mh
df -mh
dd if=/dev/zero of=/swapfile count=8192 bs=1M
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

su john <<EOF
cd /home/john
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:/home/John/minio/.bin
whoami

pwd

git clone https://github.com/minio/minio.git
cd minio
git checkout RELEASE.2025-04-22T22-12-26Z

go version

go env

go mod tidy

sed -i 's/loongarch64)/loongarch64 | riscv64)/g' buildscripts/checkdeps.sh

sed -i 's/timeout=10m/timeout=2000m/' Makefile

sed -i '/@MINIO_API_REQUESTS_MAX=10000 CGO_ENABLED=0 go test -v -tags kqueue,dev .\/.../ s/$/ -timeout 0/' Makefile

make

echo "finished building minio"

echo "ready to run make test"
make test

echo "make test finished"

echo "ready to run mint"

file minio

chronyc makestep
date

whoami

pwd

./minio server /home/john/minio/data --console-address ":9001" >minio.log 2>&1 &

sleep 10
EOF
