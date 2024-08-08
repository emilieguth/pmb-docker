FROM node:latest AS node
# Use an official PHP runtime
FROM php:8.2-apache
RUN apt-get -y update
RUN apt-get -y install git
# Enable Apache modules
RUN a2enmod rewrite

# Install any extensions you need
RUN apt-get -y update \
&& apt-get install -y libicu-dev \
&& docker-php-ext-configure intl \
&& docker-php-ext-install intl \
&& docker-php-ext-install mysqli pdo pdo_mysql

# Install Node.js
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

# Install Composer
COPY --from=composer/composer:latest-bin /composer /usr/bin/composer

# Set the working directory to /var/www/html
WORKDIR /var/www/html
# Copy the source code in /www into the container at /var/www/html
COPY ../www .

# Install any dependencies (to be run in the container)
#RUN composer update tecnickcom/tcpdf --ignore-platform-reqs
#RUN composer install --ignore-platform-reqs

RUN npm install
RUN npm i -g npx
RUN npm run customstylesbuild