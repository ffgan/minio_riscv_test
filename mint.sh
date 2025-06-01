echo "ready to run mint"
cd /home/john/minio
export PATH=$PATH:/home/john/local/go/bin
export PATH=$PATH:/home/john/go/bin
file minio

date

whoami

pwd

./minio server /home/john/minio/data --console-address ":9001" >minio.log 2>&1 &

sleep 10
