#!/bin/bash
#
# To use this script run "docker build .""
. config.sh

# download source code to gridlabd
git clone ${GRIDLABD_ORIGIN} -b ${GRIDLABD_BRANCH} /usr/local/src/gridlabd

# build xerces for gridlabd
cd /usr/local/src/gridlabd/third_party
XERCES=xerces-c-3.1.1
gunzip ${XERCES}.tar.gz
tar xf ${XERCES}.tar
cd ${XERCES}
export XERCESCROOT=`pwd`;
./configure
make install
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
/sbin/ldconfig

# install other needed libraries
apt-get install libcurl4-openssl-dev -y
apt-get install libncurses5-dev -y

# build and install gridlabd
cd /usr/local/src/gridlabd
autoreconf -isf
./configure --with-mysql=/usr/local
make -j20 install

# check python and gridlabd version
echo "Version check:"
python3 -V
echo "import gridlabd; print('GridLAB-D %s' % gridlabd.__version__)" | python3

# Validate gridlabd
gridlabd -T $(nproc) --validate

cd /tmp
if [ "x${REMOVE_SOURCE}" == "xyes" ]; then 
	rm -rf /usr/local/src/gridlabd
fi
