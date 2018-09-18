FROM ubuntu:17.10

# Setup common packages, repo info, etc
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y whois sudo vim htop software-properties-common python-software-properties sendmail git iproute iputils-ping
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update

# Install packages
RUN apt-get install -y apache2 apache2-bin apache2-data apache2-utils libapache2-mod-fcgid php7.0-bcmath php7.0-cli php7.0-common php7.0-curl php7.0-fpm php7.0-gd php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-readline php7.0-soap php7.0-xml php7.0-xsl php7.0-zip php-xdebug mariadb-client curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Setup PHP
RUN mkdir /run/php
RUN touch /run/php/php-fpm.sock

# Setup apache
RUN ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/proxy.conf
RUN ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load
RUN ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load
RUN ln -s /etc/apache2/mods-available/proxy_fcgi.load /etc/apache2/mods-enabled/proxy_fcgi.load
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
RUN ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ssl.conf
RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load
RUN ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/socache_shmcb.load

# Create new user
RUN useradd -m -p `mkpasswd "inchoo"` -s /bin/bash inchoo
RUN adduser inchoo sudo
RUN ln -s /var/www/html /home/inchoo/html
RUN echo "alias php-debug='php -d xdebug.remote_autostart=1'" > /home/inchoo/.bash_aliases

# Add custom configuration
ADD config/fpm.conf /etc/php/7.0/fpm/pool.d/www.conf

# Add custom scripts
ADD start.sh /start.sh
ADD scripts/robo.phar /usr/bin/robo
ADD scripts/composer.phar /usr/bin/composer
ADD scripts/n98-magerun.phar /usr/bin/n98-magerun
ADD scripts/n98-magerun2.phar /usr/bin/n98-magerun2

RUN chmod 755 /start.sh
RUN chmod 755 /usr/bin/robo
RUN chmod 755 /usr/bin/composer
RUN chmod 755 /usr/bin/n98-magerun
RUN chmod 755 /usr/bin/n98-magerun2

# Cleanup
RUN apt-get autoremove -y
RUN apt-get clean

CMD ["/start.sh"]
