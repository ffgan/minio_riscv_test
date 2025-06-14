all: init test mint build


build: init
	sshpass -p 'test123@#' scp -o StrictHostKeyChecking=no -P 2222 ./build.sh john@localhost:/home/john/build.sh
	sshpass -p 'test123@#' ssh -o StrictHostKeyChecking=no john@localhost -p 2222 "bash /home/john/build.sh"


.PHONY: init test mint build
init:
	bash ./host_init.sh
	# ssh root@localhost -p 2222

	rm -rf ~/.ssh/known_hosts

	sshpass -p 'openEuler12#$$' scp -o StrictHostKeyChecking=no -P 2222 ./vm_init.sh root@localhost:/root/init.sh
	sshpass -p 'openEuler12#$$' ssh -o StrictHostKeyChecking=no root@localhost -p 2222 "bash /root/init.sh"

test: 
	sshpass -p 'test123@#' scp -o StrictHostKeyChecking=no -P 2222 ./test.sh john@localhost:/home/john/test.sh
	sshpass -p 'test123@#' ssh -o StrictHostKeyChecking=no john@localhost -p 2222 "bash /home/john/test.sh"


mint: 
	sshpass -p 'test123@#' scp -o StrictHostKeyChecking=no -P 2222 ./mint.sh john@localhost:/home/john/mint.sh
	sshpass -p 'test123@#' ssh -o StrictHostKeyChecking=no john@localhost -p 2222 "bash /home/john/mint.sh"
	sshpass -p 'openEuler12#$$' ssh -o StrictHostKeyChecking=no root@localhost -p 2222 "cd /home/john/minio; cat   minio.log"
	podman run -e SERVER_ENDPOINT=host.docker.internal:9000 -e ACCESS_KEY=minioadmin -e SECRET_KEY=minioadmin docker.io/minio/mint:edge
