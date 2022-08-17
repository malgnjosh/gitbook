```
ServerRoot "/etc/httpd"
```
서버루트는 최상위 디렉토리로 서버 설정, 에러 정보 및 로그 파일이 저장되는 곳이다.

```
Listen 80
```
아파치 서버가 시스템 기본값 외 특정 IP 주소나 포트에서의 요청을 기다리도록 한다. VirtualHost와 관련이 있다.

위의 경우 80 포트를 통해서 아파치에 연결할 수 있도록 한다.
```
Include conf.modules.d/*.conf
```
conf.modules.d 디렉토리의 모든 설정 파일을 불러온다.
```
User apache
Group apache
```
아파치 프로세스의 소유자와 소유 그룹을 apache로 설정한다.
```
ServerAdmin root@localhost
```
오류 발생시 노출되는 관리자 연락처를 설정할 수 있다.


<Directory></Directory> 를 이용하면 지정 디렉토리 아래에 있는 모든 웹문서들에 대한 설정을 변경할 수 있다.
아래는 루트 / 에 대해서 
AllowOverride 지시자의 값으로 none을 주어 AccessFileName에 지정된 파일을 액세서 인증 파일로 인식하지 않으며,
Require all denied로 서버 전체에 대한 접근을 거부하고 있다. 따라서 별도로 접근 허용 여부를 명시해야 한다.


```
<Directory />
AllowOverride none
Require all denied
</Directory>
```

```
DocumentRoot "/var/www/html"
```

문서를 보관할 DocumentRoot의 경로를 지정한다.  모든 요청은 이 디렉토리를 통해서 받게 된다.

```
<Directory "/var/www">
AllowOverride None
Require all granted
</Directory>
```
```
<Directory "/var/www/html">
Options Indexes FollowSymLinks
AllowOverride None
Require all granted
</Directory>
```
```
<IfModule dir_module>
DirectoryIndex index.html
</IfModule>
```
```
<Files ".ht*">
Require all denied
</Files>
```
```
ErrorLog "logs/error_log"
```
```
LogLevel warn
```
```
<IfModule log_config_module>
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common

<IfModule logio_module>
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %l %O" combinedio
</IfModule>

CustomLog "logs/access_log" combined
</IfModule>
```

```
<IfModule alias_module>
ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
</IfModule>
```

```
<Directory "/var/www/cgi-bin">
AllowOverride None
Options None
Require all granted
</Directory>
```

```
<IfModule mime_module>
TypesConfig /etc/mime.types
AddType application/x-compress .Z
AddType application/x-gzip .gz .tgz

AddType text/html .shtml
AddOutputFilter INCLUDES .shtml
</IfModule>
```

```
AddDefaultCharset UTF-8
```
```
<IfModule mime_magic_module>
MIMEMagicFile conf/magic
</IfModule>
```
```
EnableSendFile on
```
```
<IfModule mod_http2.c>
Protocols h2 h2c http/1.1
</IfModule>
```
```
```
IncludeOptional conf.d/*.conf
```

