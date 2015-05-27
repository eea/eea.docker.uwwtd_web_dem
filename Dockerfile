FROM mysql:5.5

MAINTAINER michimau <mauro.michielon@eea.europa.eu>

RUN apt-get -y update && apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
        apache2 \
        php5 \
        php5-mysql \
        libapache2-mod-php5 \
        php5-ldap \
        #php5-xsl \
        nano \
        vim \
        zendframework

COPY default /etc/apache2/sites-available/default

RUN a2enmod php5 ldap rewrite

RUN mkdir /run/mysqld && chmod 777 /run/mysqld

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY ./my.cnf /etc/mysql/my.cnf

CMD apachectl start && mysqld
