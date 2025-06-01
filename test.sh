echo "ready to run make test"
cd /home/john/minio
export PATH=$PATH:/home/john/local/go/bin
export PATH=$PATH:/home/john/go/bin
make test
echo "make test finished"

echo "************ready to make test-race******************"
make test-race
echo "************make test-race finished******************"
