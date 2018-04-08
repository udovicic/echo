#!/bin/sh

nohup /usr/sbin/php-fpm7.2 &
/usr/sbin/apache2ctl -D FOREGROUND
