FROM ubuntu:18.04

# Setup common packages, repo info, etc
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y whois sudo vim htop software-properties-common sendmail git iproute2 iputils-ping lsof unzip rsync wget lsyncd openssh-server sshpass cachefilesd
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update

# Install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 apache2-bin apache2-data apache2-utils libapache2-mod-fcgid php5.6-bcmath php5.6-cli php5.6-common php5.6-curl php5.6-fpm php5.6-gd php5.6-intl php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-opcache php5.6-readline php5.6-soap php5.6-xml php5.6-xsl php5.6-zip php-xdebug mariadb-client curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Setup PHP
RUN mkdir /run/php && touch /run/php/php-fpm.sock

# Setup apache
RUN ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/proxy.conf && ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load && ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load && ln -s /etc/apache2/mods-available/proxy_fcgi.load /etc/apache2/mods-enabled/proxy_fcgi.load && ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load && ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ssl.conf && ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load && ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/socache_shmcb.load

# Create new user
RUN useradd -m -p `mkpasswd "inchoo"` -s /bin/bash inchoo && adduser inchoo sudo && ln -s /var/www/html /home/inchoo/html && echo "alias php-debug='php -d xdebug.remote_autostart=1'" > /home/inchoo/.bash_aliases && chown -R inchoo:inchoo /var/www/html && rm -rf /var/www/html/*

# Add custom configuration
ADD config/fpm.conf /etc/php/5.6/fpm/pool.d/www.conf 
ADD config/apache.conf /etc/apache2/sites-available/000-default.conf

# Add custom scripts
ADD start.sh /start.sh
ADD scripts/robo.phar /usr/bin/robo
ADD scripts/composer.phar /usr/bin/composer
ADD scripts/n98-magerun.phar /usr/bin/n98-magerun
ADD scripts/n98-magerun2.phar /usr/bin/n98-magerun2

RUN chmod 755 /start.sh && chmod 755 /usr/bin/robo && chmod 755 /usr/bin/composer && chmod 755 /usr/bin/n98-magerun && chmod 755 /usr/bin/n98-magerun2

# Cleanup
RUN apt-get autoremove -y && apt-get clean && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

WORKDIR /var/www/html

CMD ["/start.sh"]
