# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM composer:2 AS composer

WORKDIR /app
RUN git clone https://github.com/NB-Core/lotgd.git . \
    && composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

FROM $BUILD_FROM

# Install PHP 8.3 and Apache
RUN apk add --no-cache \
    apache2 \
    php83 \
    php83-apache2 \
    php83-mysqli \
    php83-pdo_mysql \
    php83-gd \
    php83-mbstring \
    php83-zip \
    php83-session \
    php83-ctype \
    php83-iconv \
    php83-curl \
    php83-dom \
    php83-xml \
    php83-xmlreader \
    php83-xmlwriter \
    php83-simplexml \
    php83-tokenizer \
    php83-fileinfo \
    php83-phar \
    php83-openssl \
    php83-posix \
    php83-intl \
    php83-xsl \
    git \
    curl

# Configure Apache
RUN sed -i 's/#LoadModule rewrite_module/LoadModule rewrite_module/' /etc/apache2/httpd.conf \
    && sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/httpd.conf \
    && sed -i 's/Options Indexes/Options /g' /etc/apache2/httpd.conf \
    && mkdir -p /run/apache2 \
    && ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log \
    && ln -sf /usr/bin/php83 /usr/bin/php

# Set up app directory
WORKDIR /var/www/localhost/htdocs
COPY --from=composer /app /var/www/localhost/htdocs
RUN chown -R apache:apache /var/www/localhost/htdocs \
    && chmod -R 777 /var/www/localhost/htdocs/data

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

EXPOSE 80
