# 필수 프로그램 설치

## 1\. 업데이트 및 epel 설치

```
$ yum -y update
```

```
$ sudo amazon-linux-extras install epel -y

$ sudo yum repolist
```

## 2\. apache
```
$ sudo yum -y install httpd
```

```
실행

$ sudo systemctl start httpd
$ sudo systemctl status httpd

```

## 3\. jdk

```
$ yum list | grep jdk
```

```
$ sudo yum -y install java-1.8.0-openjdk.x86_64
$ sudo yum -y install java-1.8.0-openjdk-devel.x86_64
```

## 4\. mysql

```
$ sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022

$ sudo yum localinstall -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
$ sudo yum install -y mysql-community-server

$ sudo systemctl enable mysqld
$ sudo systemctl start mysqld

$ mysql --version
$ sudo netstat -plntu // 3306 포트 뜨는지 확인
$ sudo systemctl restart mysqld
```

## 5\. php

```
$ yum list php
```
```
$ sudo yum -y install php.x86_64
```

## 6\. resin

caucho.com 에서 rpm 파일을 다운받은 뒤 설치한다.

```
$ yum install resin-4.0.63-1.x86_64.rpm
```
