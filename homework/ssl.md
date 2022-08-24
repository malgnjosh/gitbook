# 1\. TLS 활성화

```
$ sudo systemctl start httpd && sudo systemctl enable httpd
```

아파치 서버를 가동하고, 시스템 부팅 시 자동으로 시작되도록 한다.

```
$ sudo yum update -y
$ sudo yum install -y mod_ssl
```
ssl 모듈을 설치해 준다.

```
$ cd /etc/pki/tls/certs
$ sudo ./make-dummy-cert localhost.crt
```
자체 서명된 인증서를 생성하고 /etc/httpd/conf.d/ssl.conf 파일을 열어 SSLCertificateKeyFile 부분을 주석처리 한다.

```
$ sudo apachectl restart
```

아파치 서버를 재가동한 뒤 https:// 주소로 접속이 가능하면 성공이다. 다만 인증서가 유효하지 않아 보안 경고가 뜬다.

# 2\. letsencrypt

## 준비

epel 설치는 생략한다.

```
$ sudo yum-config-manager --enable epel*
$ sudo yum repolist all
```
epel package를 모두 사용가능한 상태로 만들고 확인한다.

httpd.conf 에

```
Listen 443

<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    ServerName "malgnjosh.ze.to"
    ServerAlias "www.malgnjosh.ze.to"
</VirtualHost>
```
를 추가한다.

```
$ sudo apachectl restart
```

## certbot 설치 및 인증서 발급

```
$ sudo amazon-linux-extras install epel -y
$ sudo yum install -y certbot python2-certbot-apache
```
```
$ sudo certbot --webroot --installer apache -w /var/www/html/ -d malgnjosh.ze.to
```

위 명령을 실행하면 httpd.conf 에

```
<VirtualHost *:80>
    ...
    RewriteEngine on
    RewriteCond %{SERVER_NAME} =malgnjosh.ze.to [OR]
    RewriteCond %{SERVER_NAME} =www.malgnjosh.ze.to
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>
```
http://로 접속시 https://로 리다이렉트 해주는 내용이 추가된다.

또 /etc/httpd/conf/httpd-le-ssl.conf 를 생성하고 httpd.conf에서 Include 하게 되는데,

이 파일은 443에 대한 가상호스트를 설정하고 인증서 파일 경로를 지정한다.
```
<IfModule mod_ssl.c>
<VirtualHost *:443>
    DocumentRoot "/var/www/html"
    ServerName "malgnjosh.ze.to"
    ServerAlias "www.malgnjosh.ze.to"
RewriteEngine on

SSLCertificateFile /etc/letsencrypt/live/malgnjosh.ze.to/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/malgnjosh.ze.to/privkey.pem
Include /etc/letsencrypt/options-ssl-apache.conf
</VirtualHost>
</IfModule>
```



![img](./img/ssl.png)

인증서 발급이 완료되었다.
