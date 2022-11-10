FROM php:7.4.32-apache

RUN apt-get update && apt-get install -y git zip unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN \
  curl -L https://download.newrelic.com/php_agent/release/newrelic-php5-10.3.0.315-linux.tar.gz | tar -C /tmp -zx && \
  export NR_INSTALL_USE_CP_NOT_LN=1 && \
  export NR_INSTALL_SILENT=1 && \
  /tmp/newrelic-php5-*/newrelic-install install && \
  rm -rf /tmp/newrelic-php5-* /tmp/nrinstall* && \
  sed -i \
      -e 's/"REPLACE_WITH_REAL_KEY"/"XXX"/' \
      -e 's/newrelic.appname = "PHP Application"/newrelic.appname = "Hello PHP ECS"/' \
      -e 's/;newrelic.daemon.app_connect_timeout =.*/newrelic.daemon.app_connect_timeout=15s/' \
      -e 's/;newrelic.daemon.start_timeout =.*/newrelic.daemon.start_timeout=5s/' \
      -e 's/;newrelic.application_logging.forwarding.log_level = "WARNING"/newrelic.application_logging.forwarding.log_level = "INFO"/' \
      /usr/local/etc/php/conf.d/newrelic.ini

COPY src/ /var/www/html
COPY composer.json /var/www/composer.json
COPY composer.lock /var/www/composer.lock

RUN composer install --working-dir=/var/www

EXPOSE 80