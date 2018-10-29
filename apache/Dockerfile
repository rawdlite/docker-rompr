FROM debian:stretch-slim
MAINTAINER rawdlite@gmail.com

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get -yq install \
        curl \
        libapache2-mod-php \
        php-mysql \
        php-curl \
        php-gd \
        unzip \
        imagemagick \
        php-json \
        php-xml \
        php-mbstring \
        php-sqlite3 \
    && rm -rf /var/lib/apt/lists/*  /usr/share/doc/* /usr/share/doc-base/*
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
RUN a2enmod expires
RUN a2enmod headers
RUN curl -L -o rompr.zip https://github.com/fatg3erman/RompR/releases/download/1.22/rompr-1.22.zip
RUN mkdir -p /app
RUN unzip -d /app rompr.zip && rm rompr.zip
RUN mkdir /app/rompr/prefs
RUN mkdir /app/rompr/albumart
RUN chown -R www-data:www-data /app/rompr
ENV APACHE_DOCUMENT_ROOT /app/rompr

RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 32M
ENV PHP_POST_MAX_SIZE 32M
ENV PHP_REGISTER_GLOBALS Off
ENV PHP_MEMORY_LIMIT 256M
ENV PHP_MAX_EXECUTION_TIME  300
RUN echo "<?php phpinfo(); ?>" > /app/rompr/phpinfo.php

COPY httpd-foreground /usr/local/bin/
RUN chmod 755 /usr/local/bin/httpd-foreground
EXPOSE 80
CMD ["httpd-foreground"]

