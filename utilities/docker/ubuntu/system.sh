#!/bin/bash
#
# To use this script run "docker build .""

# update first
apt-get update -y

# install python 3.7
apt-get install software-properties-common -y
add-apt-repository ppa:deadsnakes/ppa
apt update
apt install python3.7 -y
apt install python3-pip -y
apt install python3.7-dev -y

# change default python3 to python3.7 for validation
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1

# install python libraries by validation
pip3 install --upgrade pip
pip install pandas
pip install matplotlib
pip install mysql-client

# install system build tools needed by gridlabd
apt-get install git -y
apt-get install unzip -y
apt-get install autoconf -y
apt-get install libtool -y
apt-get install g++ -y
apt-get install cmake -y 

