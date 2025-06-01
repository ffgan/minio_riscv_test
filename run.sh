#! /bin/bash
# set -e
uname -m

curl https://dl.google.com/go/go1.24.3.linux-riscv64.tar.gz -o go1.24.3.linux-riscv64.tar.gz
mkdir /home/john/local
tar -C /home/john/local -xzf go1.24.3.linux-riscv64.tar.gz
ls -l /home/john/local/go
export PATH=$PATH:/home/john/local/go/bin
export PATH=$PATH:/home/john/go/bin

echo "Inside john user session:"
echo "PATH: $PATH"

whoami

git clone https://github.com/minio/minio.git
cd minio

pwd
ls -l

git checkout RELEASE.2025-04-22T22-12-26Z

go version

go env

sed -i 's/loongarch64)/loongarch64 | riscv64)/g' buildscripts/checkdeps.sh

sed -i 's/timeout=10m/timeout=2000m/' Makefile

sed -i 's/go test -v -tags kqueue,dev \.\/\.\.\./go test -v -timeout 0 -tags kqueue,dev \.\/\.\.\./g' Makefile

cat Makefile

go mod tidy

make

echo "finished building minio"

echo "ready to run make test"

make test

echo "make test finished"

echo "ready to run mint"

file minio

date

whoami

pwd

./minio server /home/john/minio/data --console-address ":9001" >minio.log 2>&1 &

sleep 10
