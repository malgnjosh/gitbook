
# AWS SWAP 메모리 설정방법

1. 스왑 파일 생성

```
sudo dd if=/dev/zero of=/swapfile bs=128M count=32

```

2. 권한 부여

```
sudo chmod 600 /swapfile

```
3. SWAP AREA 설정

```
sudo mkswap /swapfile

```

4. 확인

```
sudo swapon -s

```
5. 부팅시 스왑파일 활성화

```
sudo vi /etc/fastab

```
마지막 줄에 /swapfile swap swap defaults 0 0 추가

6. 메모리 확인

```
free -h

```
