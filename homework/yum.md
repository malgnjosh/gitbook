# yum 패키지 도구

## 1\. yum이란 무엇인가

패키지 관리란 시스템에 소프트웨어를 설치하고 유지, 관리하는 것을 말한다.

패키지 시스템은 리눅스 배포판마다 다르며, 리눅스 배포판은 크게 레드햇 계열과 데비안 진영으로 나눌 수 있다.

레드햇 계열의 CentOS에서는 yum을 사용하고 데비안 계열의 Ubuntu에서는 apt를 이용한다.

yum은 Yellow dog updater, modified의 약자로 듀크대에서 개발한 패키지 관리 도구이다.

yum의 장점은 기존 RPM의 의존성 문제를 해결하였다는 점이다. yum으로 특정 패키지를 설치할 경우 의존관계에 있는 다른 패키지들까지 설치해준다. 

yum의 설정 파일은 /etc/yum.conf 이다.


## 2\. 사용방법

### 1) 설치

```
# yum install [package]
```

### 2) 패키지 삭제

```
# yum remove [package]
```

### 3) 패키지 업데이트

```
# yum update [package]
```

### 4) 커널 패키지에 설치된 모든 패키지를 업데이트

```
# yum -y update
```

패키지 명을 입력하지 않으면 커널 패키지에 설치된 모든 패키지를 업데이트한다.

#### yum의 옵션

설치 도중 y/n 여부를 물어보는 경우가 있는데, -y 옵션을 이용하면 일일이 y를 체크해주지 않고 설치를 완료할 수 있다.

이처럼 하이픈(-)과 함께 옵션을 지정할 수 있다.

### 5) 패키지 검색

```
# yum search [package]
```

### 6) 패키지 정보

```
# yum info [package]
```

### 7) 패키지 리스트

```
# yum list
```
#### 특정 단어를 포함한 패키지의 리스트는 아래처럼 하면 된다.

```
# yum list [특정단어]
```

#### 업데이트된 패키지만 확인하려면

```
# yum list updates
```

#### 설치된 패키지 리스트

```
# yum list available
```

### 8) 특정 파일을 제공하는 패키지

```
# yum whatprovides [특정파일]
```

## 3\. Repository

yum repository는 yum을 통해 설치할 수 있는 package들의 저장소이다. 

repository들은 /etc/yum.repos.d 에 .repo 형태로 존재한다.

### 1) 활성화된 레포지토리 리스트 확인

```
# yum repolist
```

### 2) 레포지토리 추가하기

위 repo의 경로에 새로운 .repo 파일을 생성한다.

```
# vi myrepo.repo
```

repo 파일의 구조는 다음과 같다.

```
name=이름
baseurl=주소
enabled=1
gpgcheck=1
gpgkey=주소
```

gpgcheck는 서명키 사용 여부를 체크하는 옵션이다. GPG는 RSA를 이용한 암호화 방식 중 하나이다.

### 3) 레포지토리 삭제하기

위 repo 경로에서 base를 제외한 파일들을 삭제하면 된다.

```
# rm -rf myrepo.repo
```

cache는 /var/cache/yum/ 에 존재하며

headers, packages, metadata는 각각 yum clean으로 삭제해준다.

```
# yum clean headers
# yum clean packages
# yum clean metadata
```


