FROM php:5.6-apache
MAINTAINER php apache2 weblfe dev

COPY deploy/scripts/init.sh /bin/init.sh
#COPY deploy/apache/apache2.conf /etc/apache2/apache2.conf

RUN a2enmod rewrite expires include && mv /etc/apt/sources.list /etc/apt/sources.list.bck

# [china] switch aliyun apt source
RUN { \
        echo '# [163]'; \
        echo 'deb http://mirrors.163.com/debian/ stretch main non-free contrib'; \
        echo 'deb-src http://mirrors.163.com/debian/ stretch main non-free contrib'; \
        echo 'deb http://mirrors.163.com/debian-security stretch/updates main'; \
        echo 'deb-src http://mirrors.163.com/debian-security stretch/updates main'; \
        echo 'deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib'; \
        echo 'deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib'; \
        echo 'deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib'; \
    } > /etc/apt/sources.list

# install the PHP extensions we need
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         libpng-dev \
         libjpeg-dev \
         libpcre3-dev \
         libpq-dev \
         libmcrypt-dev \
         libldap-dev \
         libldb-dev \
         libicu-dev \
         openssl \
         libssl-dev \
         libssl1.1 \
         libsasl2-2 \
         libsasl2-dev \
         libcurl3-openssl-dev \
         libgmp-dev \
         libmagickwand-dev \
    && chmod 755 /bin/init.sh \
    && echo "root:Docker!" | chpasswd \
    && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && rm -rf /var/lib/apt/lists/* \
    && export PHP_OPENSSL_DIR=yes \
    && pecl install redis-2.2.8 \
    && pecl install imagick-3.4.4 \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr  --with-freetype-dir=/usr/include/freetype2  \
    && docker-php-ext-install gd \
         mysqli \
         opcache \
         pdo \
         pdo_mysql \
         pdo_pgsql \
         pgsql \
         ldap \
         intl \
         gmp \
         zip \
         mcrypt \
         bcmath \
         mbstring \
         fileinfo \
         pcntl \
    && docker-php-ext-enable imagick \
            redis

RUN   \
   rm -f /var/log/apache2/* \
   && rmdir /var/lock/apache2 \
   && rmdir /var/run/apache2 \
   && rmdir /var/log/apache2 \
   && chmod 777 /var/log \
   && chmod 777 /var/run \
   && chmod 777 /var/lock \
   && chmod 777 /bin/init.sh \
   && rm -rf /var/www/html \
   && rm -rf /var/log/apache2 \
   && mkdir -p /home/LogFiles \
   && ln -s /home/site/wwwroot /var/www/html \
   && ln -s /home/LogFiles /var/log/apache2

RUN { \
                echo 'opcache.memory_consumption=128'; \
                echo 'opcache.interned_strings_buffer=8'; \
                echo 'opcache.max_accelerated_files=4000'; \
                echo 'opcache.revalidate_freq=60'; \
                echo 'opcache.fast_shutdown=1'; \
                echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
                echo 'error_log=/var/log/apache2/php-error.log'; \
                echo 'display_errors=Off'; \
                echo 'log_errors=On'; \
                echo 'display_startup_errors=Off'; \
                echo 'date.timezone=UTC'; \
    } > /usr/local/etc/php/conf.d/php.ini

EXPOSE 443 80 8080

ENV APACHE_RUN_USER www-data
ENV PHP_VERSION 7.2

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance

WORKDIR /var/www/html

ENTRYPOINT ["/bin/init.sh"]
