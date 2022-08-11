# 필수 프로그램 설치

## 1\. 업데이트

```
# yum -y update
```

## 2\. epel

```
# yum list epel-release
```

```
# sudo yum -y install epel-release.noarch

# sudo yum -y install httpd
```

```
실행 및 포트설정

sudo systemctl start httpd
sudo systemctl status httpd

yum install firewalld
sudo firewalld
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo firewall-cmd --zone=public --list-all
```

## 3\. jdk

```
# yum list | grep jdk
```

```
# sudo yum -y install java-1.8.0-openjdk.x86\_64
# sudo yum -y install java-1.8.0-openjdk-devel.x86\_64
```

```
환경변수 설정

# which java

# readlink -f /usr/bin/java

/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.332.b09-1.amzn2.0.2.x86\_64/jre/bin/java

# sudo vi /etc/profile

export JAVA\_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.332.b09-1.amzn2.0.2.x86\_64/jre/bin/java
export PATH=$PATH:$JAVA\_HOME/bin
export CLASSPATH=$JAVA\_HOME/jre/lib:$JAVA\_HOME/lib/tools.jar

:wq!

# source /etc/profile

# echo $JAVA\_HOME
```

## 4\. mysql

```
# sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022

# sudo yum localinstall -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# sudo yum install -y mysql-community-server

# sudo systemctl enable mysqld
# sudo systemctl start mysqld

# mysql --version
# sudo netstat -plntu // 3306 포트 뜨는지 확인
# sudo systemctl restart mysqld
```

## 5\. php

```
# yum list php
```
```
# sudo yum -y install php.x86\_64
```

## 6\. resin

```
# yum install resin-4.0.63-1.x86\_64.rpm
```

