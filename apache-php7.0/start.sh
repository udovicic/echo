#!/bin/sh

nohup /usr/sbin/php-fpm7.0 &
/usr/sbin/apache2ctl -D FOREGROUND
