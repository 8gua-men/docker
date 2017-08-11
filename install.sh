#!/bin/bash

function INIT_USER{
groupadd -g $2 $1
useradd -u $2 -g $USER_PID -s /bin/bash -m $1
echo "$1 ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers ;
cp /root/.bashrc /home/$1/
chown -R $1:$1 /home/$1/*
}

INIT_USER ol 5188
INIT_USER dev 6188

if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
exit 0
fi

mkdir -p /var/log/supervisor/

#supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[include]
files = /etc/supervisor/conf.d/*.conf

[supervisord]
logfile=/var/log/supervisor/supervisord.log
pidfile=/var/run/supervisord.pid
childlogdir=/var/log/supervisor
EOF

