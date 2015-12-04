FROM debian:6.0

MAINTAINER michimau <mauro.michielon@eea.europa.eu>

RUN apt-get -y update && apt-get install -y apache2 \
        php5 \
        php5-mysql \
        libapache2-mod-php5 \
        php5-ldap \
        nano \
        vim \
        zendframework \
        mysql-client  \
        subversion

COPY default /etc/apache2/sites-available/default
COPY php.ini /etc/php5/apache2/php.ini

#COPY application.ini /var/www/UWWTD-WEB-DEM/application/configs/application.ini

RUN a2enmod php5 ldap rewrite proxy_http

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

#RUN chown -R www-data /var/www/UWWTD-WEB-DEM
#RUN chgrp -R www-data /var/www/UWWTD-WEB-DEM

ENTRYPOINT [ "/usr/sbin/apache2", "-DFOREGROUND" ]
