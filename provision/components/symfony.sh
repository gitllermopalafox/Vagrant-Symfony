#!/bin/bash

APP_NAME=$1
VERSION=$2

echo "Installing Symfony"

curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony

cd /var/www/src > /dev/null 2>&1

symfony new $APP_NAME