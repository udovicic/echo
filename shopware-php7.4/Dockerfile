FROM udovicic/echo:apache-php7.4

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN composer self-update --2

USER inchoo
ENV NVM_DIR /home/inchoo/.nvm
ENV NODE_VERSION 12.21.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

USER root

RUN ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/node /usr/bin/node \
    && ln -s $NVM_DIR/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm

RUN apt update \
    && apt install -y build-essential \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*
