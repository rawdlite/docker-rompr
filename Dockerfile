FROM debian:buster-slim
MAINTAINER rawdlite@gmail.com

ARG ROMPR_VERSION=1.32
# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install \
      nginx \
      php-fpm \
      curl \
      php-mysql \
      php-curl \
      php-gd \
      unzip \
      imagemagick \
      php-json \
      php-xml \ 
      php-mbstring \
      php-sqlite3 

RUN curl -k -L -o rompr.zip https://github.com/fatg3erman/RompR/releases/download/${ROMPR_VERSION}/rompr-${ROMPR_VERSION}.zip
RUN mkdir -p /app
RUN unzip -d /app rompr.zip && rm rompr.zip
RUN mkdir /app/rompr/prefs
RUN mkdir /app/rompr/albumart
RUN chown -R www-data:www-data /app/rompr
COPY nginx_default /etc/nginx/sites-available/default
RUN mkdir -p /run/php/
#Environment variables to configure php
RUN sed -ri -e  's/^allow_url_fopen =.*/allow_url_fopen = On/g' /etc/php/7.3/fpm/php.ini
RUN sed -ri -e  's/^memory_limit =.*/memory_limit = 128M/g' /etc/php/7.3/fpm/php.ini
RUN sed -ri -e  's/^max_execution_time =.*/max_execution_time = 1800/g' /etc/php/7.3/fpm/php.ini
RUN sed -ri -e  's/^post_max_size =.*/post_max_size = 256M/g' /etc/php/7.3/fpm/php.ini
RUN sed -ri -e  's/^upload_max_filesize =.*/upload_max_filesize = 8M/g' /etc/php/7.3/fpm/php.ini
RUN sed -ri -e  's/^max_file_uploads =.*/max_file_uploads = 50/g' /etc/php/7.3/fpm/php.ini
RUN sed -ri -e  's/^display_errors =.*/display_errors = On/g' /etc/php/7.3/fpm/php.ini
RUN sed -ri -e  's/^display_startup_errors =.*/display_startup_errors = On/g' /etc/php/7.3/fpm/php.ini

RUN echo "<?php phpinfo(); ?>" > /app/rompr/phpinfo.php
RUN update-rc.d php7.3-fpm defaults
COPY run-httpd /usr/local/bin/
RUN chmod 755 /usr/local/bin/run-httpd
EXPOSE 80
CMD ["/usr/local/bin/run-httpd"]

