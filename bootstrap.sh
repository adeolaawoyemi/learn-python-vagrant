#!/usr/bin/env bash

apt-get update

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo installing apache...
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
apt-get install -y apache2
rm -rf /var/www
ln -fs /vagrant /var/www

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo installing make...
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
apt-get install make

echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo installing supervisor...
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
apt-get install supervisor


echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo installing shellinabox...
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

cd /vagrant/installers && \
tar xzf shellinabox-2.14.tar.gz && \
cd shellinabox-2.14 && \
./configure && make && make install && \
cd ../ && rm -rf shellinabox-2.14


echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo installing shellinaboxd supervisor config...
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

CONF_DIR=/etc/supervisor/conf.d

if [ ! -d "$CONF_DIR" ]; then
	mkdir -p $CONF_DIR
fi

SUPERVISOR_CONF=/etc/supervisor/conf.d/shellinaboxd.conf
SHELLINABOX=`which shellinaboxd`

(
cat <<EOF
[program:shellinaboxd]
command=${SHELLINABOX} -t -b

numprocs=1
priority=999
process_name=%(program_name)s_%(process_num)02d
user=vagrant
autorestart=true
autostart=true
startsecs=1
stopsignal=QUIT
stopwaitsecs=10
redirect_stderr=true
stdout_logfile=/var/log/shellinaboxd/supervisor.log
stdout_logfile_maxbytes=10MB
EOF
) > $SUPERVISOR_CONF
