#!/bin/bash

echo "Installing MySQL"
echo "mysql-server mysql-server/root_password password $1" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $1" | debconf-set-selections
apt-get -y install mysql-server > /dev/null 2>&1