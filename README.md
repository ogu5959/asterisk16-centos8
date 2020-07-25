# Asterisk 16 - CentOS 8

##### CentOS8 Asterisk 16 Docker image 

사용방법 :

`$ git clone https://github.com/ogu5959/asterisk16-centos8 docker-asterisk16-centos8`

`$ cd docker-asterisk16-centos8`

`$ docker build -t="asterisk" .`

실행방법 :

실행시 Asterisk에 사용할 포트 범위를 지정

`# docker run -i -t --name asterisk -d -p 5060-5065:5060-5065/tcp -p 10000-10500:10000-10500/udp asterisk /bin/bash`

다음에 실행한 이미지에 접속

`# docker exec -i -t asterisk /bin/bash`


