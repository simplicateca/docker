# Stage 1: Builder
FROM php:8.3-fpm-bookworm AS builder

LABEL maintainer="Steve Comrie <steve@simplicate.ca>"

# Install build dependencies
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        g++ \
        make \
        pkg-config \
        libbz2-dev \
        libcurl4-gnutls-dev \
        libedit-dev \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libkrb5-dev \
        libldap2-dev \
        libldb-dev \
        libmagickwand-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        libsqlite3-dev \
        libssl-dev \
        libreadline-dev \
        libxslt1-dev \
        libzip-dev \
        zlib1g-dev \
        wget \
        unzip \
        git \
        default-mysql-client \
    && docker-php-ext-install \
        bcmath \
        bz2 \
        calendar \
        exif \
        gettext \
        mysqli \
        opcache \
        pdo_mysql \
        soap \
        xsl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install ldap \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && CFLAGS="$CFLAGS -D_GNU_SOURCE" docker-php-ext-install sockets \
    && pecl install xdebug redis xmlrpc-1.0.0RC3 \
    && docker-php-ext-enable xdebug redis xmlrpc \
    && yes '' | pecl install imagick && docker-php-ext-enable imagick \
    && docker-php-source delete

# Stage 2: Runtime
FROM php:8.3-fpm-bookworm

LABEL maintainer="Steve Comrie <steve@simplicate.ca>"

# Copy compiled extensions from builder
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Install only runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        libfreetype6 \
        libjpeg62-turbo \
        libpng16-16 \
        libicu72 \
        libldap-2.5-0 \
        libmagickwand-6.q16-6 \
        libpq5 \
        libxslt1.1 \
        libzip4 \
        zlib1g \
        ghostscript \
        imagemagick \
        nano \
        curl \
        wget \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/html

CMD ["php-fpm"]
