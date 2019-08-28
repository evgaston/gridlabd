#!/bin/bash
#
# docker ubuntu-gridlabd setup script
#
# Starting docker on the host
#
#   host% docker run -it -v $(pwd):/tmp ubuntu bash
#.  host%
#  

### Docker commands to build gridlabd


git clone https://github.com/dchassin/gridlabd /usr/local/src/gridlabd
cd /usr/local/src/gridlabd/third_party
gunzip xerces-c-3.1.1.tar.gz
tar xf xerces-c-3.1.1.tar
cd xerces-c-3.1.1
ls
(export XERCESCROOT=`pwd`;./configure && make)
cp -r include/xercesc /usr/include
chmod -R a+r /usr/include/xercesc
ln lib/* /usr/lib 
/sbin/ldconfig

