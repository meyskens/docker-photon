ARG ARCHREPO
FROM ${ARCHREPO}/php:7-fpm

ARG QEMU_ARCH
COPY qemu-${QEMU_ARCH}-static /usr/bin/

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmagickwand-dev \
        imagemagick \
        graphicsmagick \
        libgraphicsmagick1-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install gmagick-2.0.5RC1 && docker-php-ext-enable gmagick


COPY ./photon /var/www/photon/