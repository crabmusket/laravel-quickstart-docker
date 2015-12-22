FROM php:5.6.13-apache

RUN echo '[PHP]' > /usr/local/etc/php/php.ini
RUN sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/app\/public/' /etc/apache2/apache2.conf

RUN apt-get update && apt-get install -y git libmcrypt-dev zlib1g-dev
RUN docker-php-ext-install mbstring mcrypt pdo pdo_mysql zip

WORKDIR /var/www/app

COPY tools/composer.phar /usr/local/bin/composer
COPY tools/phpunit.phar /usr/local/bin/phpunit
COPY composer.* /var/www/app/
RUN composer install --no-scripts --no-autoloader
COPY . /var/www/app
RUN composer dump-autoload
