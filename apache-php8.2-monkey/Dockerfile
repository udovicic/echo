FROM udovicic/echo:apache-php8.2

# Add custom scripts
ADD start.sh /start.sh
ADD scripts/robo.phar /usr/bin/robo
ADD scripts/composer.phar /usr/bin/composer
ADD scripts/n98-magerun2.phar /usr/bin/n98-magerun2
ADD scripts/deployer.phar /usr/bin/deployer

RUN chmod 755 /start.sh && chmod 755 /usr/bin/robo && chmod 755 /usr/bin/composer && chmod 755 /usr/bin/n98-magerun2 && chmod 755 /usr/bin/deployer

WORKDIR /var/www/html

CMD ["/start.sh"]
