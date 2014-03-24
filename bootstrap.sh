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

# install supervisor
# install shellinaboxd supervisor config into /etc/supervisor/conf.d/shellinaboxd.conf
# [program:shellinaboxd]
# command=/path/to/shellinaboxd -t -b
# 
# numprocs=1
# priority=999
# process_name=%(program_name)s_%(process_num)02d
# user=vagrant
# autorestart=true
# autostart=true
# startsecs=1
# stopsignal=QUIT
# stopwaitsecs=10
# redirect_stderr=true
# stdout_logfile=/var/log/shellinaboxd/supervisor.log
# stdout_logfile_maxbytes=10MB
