#!/bin/bash
#
# docker centos-gridlabd setup script
#
# Building this docker image
#
#   host% docker build -f DockerFile .
#   host% docker save > centos-gridlabd
#
# Starting docker on the host
#
#   host% docker run -it -v $(pwd):/gridlabd centos-gridlabd gridlabd -W /gridlabd <options>
#

echo '
#####################################
# DOCKER BUILD
#   gridlabd
#   ieee123
#####################################
'

cd /usr/local/src
git clone https://github.com/dchassin/gridlabd gridlabd
git clone https://github.com/dchassin/ieee123-aws ieee123
cd ieee123/config/
cp default.php local.php 
mv /usr/local/src/ieee123/* /var/www/html
cd /var/www/html
mkdir data
mkdir output
chmod 777 output data
chmod 777 config 


# install xercesc
cd /usr/local/src/gridlabd/third_party
XERCES=xerces-c-src_2_8_0
gunzip ${XERCES}.tar.gz
tar xf ${XERCES}.tar
cd ${XERCES}
export XERCESCROOT=`pwd`
cd src/xercesc
./runConfigure -plinux -cgcc -xg++ -minmem -nsocket -tnative -rpthread
make
cd ${XERCESCROOT}
cp -r include/xercesc /usr/include
chmod -R a+r /usr/include/xercesc
ln lib/* /usr/lib 
/sbin/ldconfig
	
# install mysql 
cd /usr/local/src/gridlabd/third_party
MYSQL=mysql-connector-c-6.1.11-linux-glibc2.12-x86_64
gunzip ${MYSQL}.tar.gz
tar xf ${MYSQL}.tar
cp -u ${MYSQL}/bin/* /usr/local/bin
cp -Ru ${MYSQL}/include/* /usr/local/include
cp -Ru ${MYSQL}/lib/* /usr/local/lib
	
# install armadillo
cd /usr/local/src/gridlabd/third_party
ARMA=armadillo-7.800.1
gunzip ${ARMA}.tar.gz
tar xf ${ARMA}.tar
cd ${ARMA}
cmake .
make install
	
# install gridlabd
cd /usr/local/src/gridlabd
autoreconf -isf
./customize configure
make install
	
# Validate GridLAB-D
gridlabd --validate || true
