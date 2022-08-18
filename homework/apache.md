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


&lt;Directory&gt;&lt;/Directory&gt; 를 이용하면 지정 디렉토리 아래에 있는 모든 웹문서들에 대한 설정을 변경할 수 있다.
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
/var/www 에 대하여 모든 접근을 허용한다.

```
<Directory "/var/www/html">
Options Indexes FollowSymLinks
AllowOverride None
Require all granted
</Directory>
```
/var/www/html 에 대하여
Directoryindex를 가지고 있지 않은 디렉토리에 접근하려고 하는 경우 디렉토리의 내용을 보여준다.
아파치가 심볼릭 링크를 사용하도록 한다. 성능은 향상되나 보안상 문제가 있다.


```
<IfModule dir_module>
DirectoryIndex index.html
</IfModule>
```
&lt;IfModule&gt; 은 해당 모듈이 서버에 존재할 때만 적용한다는 의미이다.
파일명 대신 디렉토리만 지정된 경우에 DirectoryIndex 로 어떤 파일을 반환할 지 지정할 수 있다.

dir\_module이 존재한다면 클라이언트의 요청이 있을 경우 index.html을 반환하도록 한다.


```
<Files ".ht*">
Require all denied
</Files>
```
&lt;Files> 는 파일 이름으로 범위를 설정한다.
.ht\*인 파일에 대해 모든 접근을 거부한다.

```
ErrorLog "logs/error_log"
```
에러로그 파일의 이름을 지정한다.

```
LogLevel warn
```
기록할 에러의 수준을 정할 수 있다. warn은 경고성 에러를 의미한다.
중요도에 따라서 emerg > alert > crit > error > warn > notice > info > debug > trace1~8 가 있다.

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
log\_config\_module이 존재한다면

LogFormat으로 로그의 형식을 지정한다.


|형식 문자열|설명|
|:--:|-----|
|%h|원격 호스트|
|%l|원격 로그인명|
|%u|원격 사용자|
|%t|clf 시간 형식의 시간|
|%r|요청의 첫번째 줄|
|%&gt;s|\(최종\) 요청의 상태|
|%b|HTTP 헤더를 제외한 전송 바이트 수|
|%O|헤더를 포함한 송신 바이트 수|

위의 "%h %l %u %t \"%r\" %&gt;s %b" 를 Common Log Format, 줄여서 CLF 라고 한다.

\{Referer\}i 는 Request에 포함된 Referer의 값을 가져온다.

여기까지 작성한 형식을 combined로 설정한다.

형식의 종류는 common/combined/combinedio가 있다.

CustomLog 로 실제 로그파일에 설정된 형식을 적용할 수 있다.


```
<IfModule alias_module>
ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
</IfModule>
```
Alias는 url을 특정 파일시스템 위치로 맵핑한다.

ScriptAlias도 같으며, 추가로 cgi-script 핸들러가 처리할 CGI 스크립트가 있다는 것을 알린다.

alias\_module이 존재할 때, 

/cgi-bin/foo 로 요청이 들어오면 /var/www/cgi-bin/foo 스크립트를 실행하도록 설정한다.


```
<Directory "/var/www/cgi-bin">
AllowOverride None
Options None
Require all granted
</Directory>
```
/var/www/cgi-bin 디렉토리에 대하여
옵션을 제거하고 모든 접근을 허용한다.

```
<IfModule mime_module>
TypesConfig /etc/mime.types
AddType application/x-compress .Z
AddType application/x-gzip .gz .tgz

AddType text/html .shtml
AddOutputFilter INCLUDES .shtml
</IfModule>
```
mime\_module이 존재할 때,
TypesConfig 미디어 타입의 위치를 설정한다. 이 때 경로는 ServerRoot에 대한 상대 경로이다.
AddType 주어진 파일이름 확장자를 특정 컨텐트 타입으로 맵핑한다.
AddOutputFilter 주어진 파일이름 확장자를 출력 필터와 맵핑한다.
출력 필터는 서버가 클라이언트로 전송하기 전, Response를 처리해주는 것으로
INCLUDES는 server-side includes를 처리하며 DEFLATE는 출력을 보내기 전에 압축해준다.


```
AddDefaultCharset UTF-8
```
default characterset 인코딩을 UTF-8로 설정한다.


```
<IfModule mime_magic_module>
MIMEMagicFile conf/magic
</IfModule>
```
mime\_magic\_module은 magic file을 이용해 특정 파일의 처음 몇 바이트를 보고 MIME 타입을 결정한다. 유닉스의 file(1)과 같다.
MIMEMagicFile Directive는 magic file의 경로 conf/magic을 지정하며 이 모듈을 사용할 수 있도록 한다.


```
EnableSendFile on
```
httpd가 client에게 파일 컨텐츠를 전송할 때 커널로부터 sendfile 지원을 받을 것인지 여부를 설정한다.

```
<IfModule mod_http2.c>
Protocols h2 h2c http/1.1
</IfModule>
```
mod\_http2.c 모듈은 HTTP / 2 에 대한 지원을 제공한다.

Protocols directive는 서버 또는 virtualhost 에 대해 지원되는 프로토콜의 리스트를 특정한다.

http/1.1은 http와 https h2는 https h2c는 http 연결을 가능하게 한다.

```
IncludeOptional conf.d/\*.conf
```

Include와 동일하게 설정파일을 포함시킬 수 있다. 다만, 파일이 존재하지 않을 경우 에러를 발생시키지 않는다.
conf.d 폴더의 모든 .conf 파일을 포함시킨다.
