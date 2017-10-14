#!/bin/sh

nohup /usr/sbin/php-fpm7.1 &
/usr/sbin/apache2ctl -D FOREGROUND
