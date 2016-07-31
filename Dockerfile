FROM ubuntu:14.04

MAINTAINER CardinalSins <daxthefirst@gmail.com>

ENV php_conf /etc/php5/php.ini
ENV fpm_conf /etc/php5/php-fpm.conf
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get -y install --no-install-recommends bash openssh-client wget nginx-extras curl git php5-fpm \
                                               php5-mysql php5-mcrypt php5-gd php5-intl php5-memcache php5-xsl \
                                               php5-curl php5-json vim telnet

RUN mkdir -p /etc/nginx /var/www/app /run/nginx /var/log/supervisor /etc/nginx/sites-available/ /etc/nginx/sites-enabled/

RUN chown www-data:www-data /var/www -R

ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/nginx-site.conf /etc/nginx/sites-available/default
ADD conf/www.conf /etc/php5/fpm/pool.d/www.conf
ADD conf/php.ini /etc/php5/fpm/php.ini
ADD conf/php.ini /etc/php5/conf.d/php.ini

RUN apt-get -y autoremove
RUN apt-get -y clean

EXPOSE 80

ENTRYPOINT service php5-fpm start && service nginx start && /bin/bash
