# Virtual host

## 1. Virtual host란

하나의 서버에서 여러 웹사이트를 운영하기 위해 메인 호스트 외에 가상 호스트를 추가할 수 있다.

## 2. Virtual host 설정 방법

httpd.conf에

virtual host에 대해 정의하고 있는 파일을 포함시키거나,

virtual host 태그를 넣어 직접 정의할 수 있다.

<VirtualHost *:80>
    ServerName      vhostest.com
    ServerAdmin     josh@malgnsoft.com
    DocumentRoot    "/var/www/test"
    <Directory "/var/www/test">
        AllowOverride All
    </Directory>
</VirtualHost>

