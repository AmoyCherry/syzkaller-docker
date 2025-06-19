# syzkaller-docker
-- syzkaller-docker
|------ Dockerfile.syzkaller
|------ syzkaller_with_syzllm
|------ syzkaller-data
|---------- bullseye.id_rsa
|---------- bullseye.id_rsa.pub
|---------- bullseye.img
|---------- bzImage
|---------- vmlinux
-- syzllm-docker
|------ Dockerfile.syzllm
|------ fuzz-with-syzllm

Commands

Pack
docker save -o all_syzllm_images.tar syzkaller-docker-syzkaller:latest syzkaller-docker-syzllm-server:latest

Load
docker load -i /path/on/target/machine/all_syzllm_images.tar

Run
docker compose up -d
