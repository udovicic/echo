#!/bin/sh

if ! grep -q "host.internal" /etc/hosts; then
    echo -e "`/sbin/ip route|awk '/default/ { print $3 }'`\tinchoo.host.internal" | sudo tee -a /etc/hosts > /dev/null
fi

nohup /usr/sbin/php-fpm7.1 &
/usr/sbin/apache2ctl -D FOREGROUND
