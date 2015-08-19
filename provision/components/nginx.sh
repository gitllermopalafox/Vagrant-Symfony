#!/bin/bash

APP_NAME=$1

echo "Installing Nginx"
apt-get install nginx -y > /dev/null 2>&1

echo "Configuring Nginx"
cat << EOF > "/var/www/provision/config/nginx_vhost"
server {
    listen 80;
    server_name localhost;
     
    root /var/www/src/$APP_NAME/web;
    index index.php index.html;
     
    # Important for VirtualBox
    sendfile off;
     
    location / {
        # try to serve file directly, fallback to app.php
        try_files \$uri /app.php\$is_args\$args;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;
     
    # DEV
    # This rule should only be placed on your development environment
    # In production, don't include this and don't deploy app_dev.php or config.php
    location ~ ^/(app_dev|config)\.php(/|\$) {
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_split_path_info ^(.+\.php)(/.*)\$;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }


    # PROD
    # location ~ ^/app\.php(/|$) {
    #     fastcgi_pass unix:/var/run/php5-fpm.sock;
    #     fastcgi_split_path_info ^(.+\.php)(/.*)$;
    #     include fastcgi_params;
    #     fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    #     # Prevents URIs that include the front controller. This will 404:
    #     # http://domain.tld/app.php/some-path
    #     # Remove the internal directive to allow URIs like this
    #     internal;
    # }   

    location ~* \.php {
        include fastcgi_params;
         
        fastcgi_pass unix:/var/run/php5-fpm.sock;
         
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_cache off;
        fastcgi_index index.php;
    }

    location /phpmyadmin {
       root /usr/share/;
       index index.php index.html index.htm;
       location ~ ^/phpmyadmin/(.+\.php)$ {
           try_files \$uri =404;
           root /usr/share/;
           fastcgi_pass unix:/var/run/php5-fpm.sock;
           fastcgi_index index.php;
           fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
           include /etc/nginx/fastcgi_params;
       }
       location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))$ {
           root /usr/share/;
       }
    }
        
}
EOF

cp /var/www/provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost > /dev/null 2>&1
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/ > /dev/null 2>&1
rm -rf /etc/nginx/sites-available/default > /dev/null 2>&1

