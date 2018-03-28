#
#--------------------------------------------------------------------------
# Base Image Setup
#--------------------------------------------------------------------------
#

FROM phusion/baseimage:latest

MAINTAINER Marius van Zundert <marius.vanzundert@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# Add the "PHP 7" ppa
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#

# Install "PHP Extentions", "libraries", "Software's"
RUN apt-get update && \
    apt-get install -y --allow-downgrades --allow-remove-essential \
        --allow-change-held-packages \
        php7.1-cli \
        php7.1-common \
        php7.1-curl \
        php7.1-json \
        php7.1-xml \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-pgsql \
        php7.1-sqlite \
        php7.1-sqlite3 \
        php7.1-zip \
        php7.1-bcmath \
        php7.1-memcached \
        php7.1-gd \
        php7.1-dev \
        wget \
        build-essential \
        nghttp2 \
        libnghttp2-dev \
        libssl-dev \
        pkg-config \
        libedit-dev \
        libxml2-dev \
        xz-utils \
        libsqlite3-dev \
        sqlite3 \
        git \
        vim \
        nano \
    && apt-get clean

#####################################
# Curl: use a HTTP2 supported version
#####################################
RUN wget https://curl.haxx.se/download/curl-7.58.0.tar.gz && \
    tar -xvf curl-7.58.0.tar.gz && \
    cd curl-7.58.0 && \
    ./configure --with-nghttp2 --prefix=/usr/local --with-ssl=/usr/local/ssl && \
    make && \
    make install && \
    ldconfig

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

# Source the bash
RUN . ~/.bashrc
