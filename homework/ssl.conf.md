# ssl.conf


```
SSLPassPhraseDialog exec: /usr/libexec/httpd-ssl-pass-dialog
```
SSLPassPhraseDialog는 SSL이 적용된 virtualhost에 대한 certificate와 private key를 읽어온다.

exec은 각 key에 대해 호출할 외부 프로그램을 설정한다.

```
SSLSessionCache shmcb:/run/httpd/sslcache(512000)
SSLSessionCacheTimeout 300
```
병렬 요청 프로세스의 속도를 개선하기 위해 캐시를 설정해준다.
shmcb 는 공유 메모리 세그먼트의 고성능 싸이클릭 버퍼를 사용한다. 데이터파일의 경로와 크기를 지정해준다.
Timeout 시간은 300초로 지정한다. 최저 15초까지 낮출 수 있다.

```
SSLRandomSeed startup file:/dev/urandom 256
SSLRandomSeed connect builtin
```

서버가 시작될 때 seed source로 외부 파일을 사용하며 바이트는 256으로 한다.
새로운 SSL 연결이 이루어질 때, builtin seeding source 를 사용한다.

```
SSLCryptoDevice builtin
```

암호화장치를 builtin으로 설정한다.

```
<VirtualHost _default_:443>

ErrorLog logs/ssl_error_log
TransferLog logs/ssl_access_log
LogLevel warn
```
443 포트에 대한 가상호스트를 설정한다.
에러로그 및 전송로그를 저장할 경로를 설정하고
로그 레벨은 경고 수준으로 설정한다.

```
SSLEngine on
```
SSL/TLS 프로토콜 엔진의 사용여부를 지정한다. 기본값은 OFF이다.

```
SSLProtocol all -SSLv3
```

SSL프로토콜 중 SSLv3 을 제외한 모든 프로토콜을 허용한다.

```
SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5:!SEED:!IDEA
```
ssl handshake 단계에서 클라이언트와 협상할 수 있는 cipher suite를 설정한다.

: 을 구분자로 쓴다. !는 not을 의미한다.

cipher suite의 4가지 주속성은

키 교환 key exchange algorithm
인증 authentication algorithm
암호 인코딩 cipher encoding algorithm
메시지 인증 mac digest algorithm

이다.

위의 경우

Triple-DES 를 사용하는 모든 cipher 가 사용가능하고
128bit 암호화 cipher 가 사용가능하다.
null 인증은 사용할 수 없다.
메시지 인증 알고리즘에서 MD5를 제외하고
암호 인코딩에서 IDEA와 SEED를 제외했다.


```
SSLCertificateFile /etc/pki/tls/certs/localhost.crt
```
증명서 파일을 지정한다.


```
<Files ~ "\.(cgilshtml|phtml|php3?)$">
  SSLOptions +StdEnvVars
</Files>
<Directory "/var/www/cgi-bin">
  SSLOptions +StdEnvVars
</Directory>
```
cgi shtml phtml php3 을 포함하는 파일에 대해서 StdEnvVars 옵션을 활성화한다.

CGI/SSI 환경변수에 관련된 기본 셋이 생성된다.

cgi-bin 디렉토리에 대해서도 StdEnvVars 옵션을 활성화한다.


```
BrowserMatch "MSIE [2-5]" \
  nokeepalive ssl-unclean-shutdown \
  downgrade-1.0 force-response-1.0

CustomLog logs/ssl_request_log \
  "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\ %b"
</VirtualHost>
```

keepalive는 http 프로토콜을 이용한 지속적인 연결을 의미한다.

IE2에서 5까지의 브라우저에 대해서는 keepalive를 무시한다.

request가 이후 버전이더라도 HTTP/1.0 으로 처리한다.

HTTP/1.0 요청을 하는 클라이언트에게 HTTP/1.0 응답을 강제한다. HTTP/1.1응답을 받으면 제대로 동작하지 않는 일부 브라우저가 있기 때문이다.

이상은 구형 IE에서 발생하는 오류를 처리하기 위한 설정이다.

마지막으로 커스텀로그를 설정한다.

