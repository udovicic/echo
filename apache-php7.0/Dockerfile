FROM ubuntu:17.10

# Setup common packages, repo info, etc
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y whois sudo vim htop
RUN apt-get install -y software-properties-common python-software-properties
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update

# Install PHP 7.0 with Magento dependencies
RUN apt-get install -y php7.0-bcmath php7.0-cli php7.0-common php7.0-curl php7.0-fpm php7.0-gd php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-readline php7.0-soap php7.0-xml php7.0-xsl php7.0-zip php-xdebug
RUN mkdir /run/php
RUN touch /run/php/php-fpm.sock

# Install apache
RUN apt-get install -y apache2 apache2-bin apache2-data apache2-utils libapache2-mod-fcgid
RUN ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/proxy.conf
RUN ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load
RUN ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load
RUN ln -s /etc/apache2/mods-available/proxy_fcgi.load /etc/apache2/mods-enabled/proxy_fcgi.load
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

# Create new user
RUN useradd -m -p `mkpasswd "inchoo"` -s /bin/bash inchoo
RUN adduser inchoo sudo
RUN ln -s /var/www/html /home/inchoo/html

# Boot
ADD start.sh /start.sh
RUN chmod 755 /start.sh
CMD ["/start.sh"]
