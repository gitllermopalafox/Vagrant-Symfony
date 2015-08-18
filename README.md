# Vagrant-Symfony

Ubuntu vagrant for dev environment for Symfony with some provision scripts:

## Test environment for this configuration
	MacOS X 10.9.5 (Mavericks)
	Vagrant version 1.7.2
	Vagrant image "hashicorp/precise32"




## git.sh
Install Git

`config.vm.provision "shell", path: "provision/components/git.sh"`




## nginx.sh
Install Nginx server

###Parameters
1. App Symfony name

`config.vm.provision "shell", path: "provision/components/nginx.sh", args: ["symfony_app_name"]`




## curl.sh
Install cURL library

`config.vm.provision "shell", path: "provision/components/curl.sh"`




## php.sh

Install PHP and extensions

`config.vm.provision "shell", path: "provision/components/php.sh"`

> PHP Installation

php5-common, php5-dev, php5-cli, php5-fpm

> PHP Extensions

php5-curl, php5-gd, php5-mcrypt, php5-mysql




## mysql.sh
Install MySql

###Parameters
1. root password

`config.vm.provision "shell", path: "provision/components/mysql.sh", args: ["root"]`




## phpmyadmin.sh
Install PhpMyAdmin

###Parameters
1. root password

`config.vm.provision "shell", path: "provision/components/phpmyadmin.sh", args: ["root"]`




## zip.sh
Install ZIP library

`config.vm.provision "shell", path: "provision/components/zip.sh"`




## composer.sh
Install composer

`config.vm.provision "shell", path: "provision/components/composer.sh"`




## symfony.sh
Install Symfony

###Parameters
1. Symfony App name
2. Symfony version (default: 'lts')

`config.vm.provision "shell", path: "provision/components/symfony.sh", args: ["symfony_app_name", "symfony_version"]`




## postinstall.sh
Script for general purpose at the end of the queue
`config.vm.provision "shell", path: "provision/components/postinstall.sh"`




## Notes

**Check the "Vagrantfile" file if you need to customize the settings**

***You need to add a valid github access token to the "Vagrantfile" (for composer)

**URL/Port**

[http://localhost:8080](http://localhost:8080) 

(if the installation was successful then you'll see the symfony's homepage)

**PhpMyAdmin**

[http://localhost:8080/phpmyadmin](http://localhost:8080/phpmyadmin)

**Sync Folders**

/var/www

**Nginx root**

/var/www/src/symfony_app_name/public

**Database credentials**

user: root
pass: root

**Directory structure**

	├── provision
	│   ├── components
	│   │   ├── composer.sh
	│   │   ├── curl.sh
	│   │   ├── git.sh
	│   │   ├── init.sh
	│   │   ├── symfony.sh
	│   │   ├── mysql.sh
	│   │   ├── nginx.sh
	│   │   ├── php.sh
	│   │   ├── phpmyadmin.sh
	│   │   ├── postinstall.sh
	│   │   └── zip.sh
	│   └── config
	│       └── nginx_vhost
	├── src
	├── README.md
	└── Vagrantfile

<br/><br/>

####Based on: [https://github.com/amenophis/vagrant-ubuntu](https://github.com/amenophis/vagrant-ubuntu)
