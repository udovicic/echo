#!/bin/sh

nohup /usr/sbin/php-fpm5.6 &
/usr/sbin/apache2ctl -D FOREGROUND
