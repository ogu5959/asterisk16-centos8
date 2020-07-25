# Version: 0.0.1 - Certified Asterisk 16 with sip and pjsip channels
FROM centos:latest
MAINTAINER Lake "ogu5959@gmail.com"

# CentOS Library Install
RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install gcc gcc-c++ make wget subversion libxml2-devel ncurses-devel openssl-devel sqlite-devel libuuid-devel vim-enhanced jansson-devel unixODBC unixODBC-devel libtool-ltdl libtool-ltdl-devel subversion mysql-devel

# libedit Install & Compile
WORKDIR /usr/src
RUN wget http://thrysoee.dk/editline/libedit-20190324-3.1.tar.gz
RUN tar xzvf libedit-20190324-3.1.tar.gz
WORKDIR /usr/src/libedit-20190324-3.1
RUN ./configure 
RUN make
RUN make install

# pjsip Install & Compile
WORKDIR /usr/src
RUN wget https://www.pjsip.org/release/2.9/pjproject-2.9.tar.bz2
RUN tar -jxvf pjproject-2.9.tar.bz2
WORKDIR /usr/src/pjproject-2.9
RUN ./configure CFLAGS="-DNDEBUG -DPJ_HAS_IPV6=1" --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-video --disable-sound --disable-opencore-amr
RUN make dep
RUN make
RUN make install
RUN ldconfig
RUN ldconfig -p | grep pj

# Asterisk16 Install & Compile
WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
RUN tar zxf asterisk-16-current.tar.gz
RUN rm -f asterisk-16-current.tar.gz
WORKDIR /usr/src/asterisk-16.12.0
RUN ./contrib/scripts/get_mp3_source.sh
RUN ./configure CFLAGS='-g -O2 -mtune=native' --libdir=/usr/lib64
RUN make
RUN make install
RUN make samples
WORKDIR /root
CMD ["/bin/bash"]