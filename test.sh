echo "ready to run make test"
cd /home/john/minio
export PATH=$PATH:/home/john/local/go/bin
export PATH=$PATH:/home/john/go/bin
make test
# go test -timeout 30s -run ^TestIAMInternalIDPConcurrencyServerSuite$ github.com/minio/minio/cmd

echo "make test finished"