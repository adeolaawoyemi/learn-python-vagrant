#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant /var/www

echo -n "PWD :"
pwd


apt-get install make

cd /vagrant/installers && \
tar xzf shellinabox-2.14.tar.gz && \
cd shellinabox-2.14 && \
./configure && make && make install && \
cd ../ && rm -rf shellinabox-2.14
