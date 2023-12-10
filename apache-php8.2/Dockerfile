FROM ubuntu:22.04

# Setup common packages, repo info, etc
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y screen cron whois sudo vim htop software-properties-common sendmail git iproute2 iputils-ping lsof unzip rsync wget lsyncd openssh-server sshpass cachefilesd && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && wget -q -O - https://packages.blackfire.io/gpg.key | dd of=/usr/share/keyrings/blackfire-archive-keyring.asc && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/blackfire-archive-keyring.asc] http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 apache2-bin apache2-data apache2-utils libapache2-mod-fcgid php8.2-bcmath php8.2-cli php8.2-common php8.2-curl php8.2-fpm php8.2-gd php8.2-intl php8.2-mbstring php8.2-mysql php8.2-opcache php8.2-readline php8.2-soap php8.2-xml php8.2-xsl php8.2-zip php8.2-xdebug php8.2-imagick mariadb-client curl blackfire-agent blackfire-php && apt-get purge -y software-properties-common && apt-get autoremove -y && apt-get clean && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

# Setup PHP and Apache
RUN mkdir /run/php && touch /run/php/php-fpm.sock && ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/proxy.conf && ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load && ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load && ln -s /etc/apache2/mods-available/proxy_fcgi.load /etc/apache2/mods-enabled/proxy_fcgi.load && ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load && ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ssl.conf && ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load && ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/socache_shmcb.load

# Create new user
RUN useradd -m -p `mkpasswd "inchoo"` -s /bin/bash inchoo && adduser inchoo sudo && ln -s /var/www/html /home/inchoo/html && echo "alias php-debug='php -d xdebug.remote_autostart=1'" > /home/inchoo/.bash_aliases && chown -R inchoo:inchoo /var/www/html && rm -rf /var/www/html/* && echo "inchoo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && tee -a /home/inchoo/.profile << ". /etc/bash_completion" && curl -o /etc/bash_completion.d/magento2-bash-completion https://raw.githubusercontent.com/yvoronoy/magento2-bash-completion/master/magento2-bash-completion

# Add custom configuration
ADD config/fpm.conf /etc/php/8.2/fpm/pool.d/www.conf
ADD config/apache.conf /etc/apache2/sites-available/000-default.conf

# Add custom scripts
ADD start.sh /start.sh
ADD scripts/robo.phar /usr/bin/robo
ADD scripts/composer.phar /usr/bin/composer
ADD scripts/n98-magerun2.phar /usr/bin/n98-magerun2
ADD scripts/deployer.phar /usr/bin/deployer

RUN chmod 755 /start.sh && chmod 755 /usr/bin/robo && chmod 755 /usr/bin/composer && chmod 755 /usr/bin/n98-magerun2 && chmod 755 /usr/bin/deployer

WORKDIR /var/www/html

CMD ["/start.sh"]
