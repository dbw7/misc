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

sudo mkdir -p /etc/apache2/ssl
echo -n "Please type in the ip of the host: "
read ip_address

# Generate a self-signed SSL certificate
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt \
    -subj "/C=US/ST=Random/L=Random/O=Dis/CN=$ip_address"
    -addext "subjectAltName=IP:$ip_address"

sudo mkdir -p /etc/apache2/.htpasswd_files
sudo htpasswd -Bcb /etc/apache2/.htpasswd_files/helm.httpasswd user root


sudo tee /etc/apache2/sites-available/helm-charts.conf <<'EOF' > /dev/null
<VirtualHost *:8092>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/helm-charts
    
    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/apache.crt
    SSLCertificateKeyFile /etc/apache2/ssl/apache.key

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

sudo sed -i 's/Listen 80/Listen 8092/g' /etc/apache2/ports.conf

sudo mkdir -p /var/www/html/helm-charts

# For some reason, it doesn't ask for authentication without this
sudo mkdir -p /var/www/html/helm-charts
sudo tee /var/www/html/helm-charts/.htaccess <<'EOF' > /dev/null
AuthType Basic
AuthName "Restricted Content"
AuthUserFile /etc/apache2/.htpasswd_files/helm.httpasswd
Require valid-user
EOF


# Disable default site
sudo a2dissite 000-default
# Enable ssl
sudo a2enmod ssl


sudo a2ensite helm-charts
sudo systemctl reload apache2
sudo systemctl restart apache2

echo "Complete"