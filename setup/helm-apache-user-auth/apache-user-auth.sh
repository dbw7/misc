#!/bin/bash

set -e

set -o pipefail

# Check for Apache (apache2)
if ! type apache2 >/dev/null 2>&1; then
    echo "Apache is not installed. Exiting."
    exit 1
fi

# Check for Helm
if ! type helm >/dev/null 2>&1; then
    echo "Helm is not installed. Exiting."
    exit 1
fi

sudo mkdir -p /etc/apache2/.htpasswd_files
sudo htpasswd -Bcb /etc/apache2/.htpasswd_files/helm.httpasswd user root


sudo cat << EOF > /etc/apache2/sites-available/helm-charts.conf
<VirtualHost *:8092>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/helm-charts

    <Directory "/var/www/html/helm-charts">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
        AuthType Basic
        AuthName "Restricted Content"
        AuthUserFile /etc/apache2/.htpasswd_files/helm.httpasswd
        Require valid-user
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

echo "Listen 8092" >> /etc/apache2/ports.conf

sudo mkdir -p /var/www/html/helm-charts

# For some reason, it doesn't ask for authentication without this
sudo mkdir -p /var/www/html/helm-charts
sudo cat << EOF > /var/www/html/helm-charts/.htaccess
AuthType Basic
AuthName "Restricted Content"
AuthUserFile /etc/apache2/.htpasswd_files/helm.httpasswd
Require valid-user
EOF


# Disable default site
sudo a2dissite 000-default

sudo a2ensite helm-charts
sudo systemctl reload apache2
sudo systemctl restart apache2

echo "Complete"