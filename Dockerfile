FROM ubuntu:xenial
RUN export DEBIAN_FRONTEND=noninteractive \
	&& locale-gen en_US.UTF-8 \
	&& update-locale LANG=en_US.UTF-8
RUN apt-get update
RUN apt-get install --no-install-recommends --yes \
	ca-certificates \
	php \
	php-mysql \
	php-opcache \
	php-curl \
	php-gd \
	php-mbstring \
	php-xml \
	libfcgi0ldbl \
	nginx \
	logrotate \
	cron \
	rsyslog
RUN apt-get install --no-install-recommends --yes supervisor
COPY www.conf /etc/php/7.0/fpm/pool.d/www.conf
RUN /etc/init.d/php7.0-fpm start && /etc/init.d/php7.0-fpm stop
COPY default /etc/nginx/sites-available/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80 443
VOLUME ["/var/log", "/var/www"]
CMD ["/usr/bin/supervisord"]