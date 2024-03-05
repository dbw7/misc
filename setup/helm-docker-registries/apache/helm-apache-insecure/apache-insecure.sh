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

sudo tee /etc/apache2/sites-available/helm-charts.conf <<'EOF' > /dev/null
<VirtualHost *:8092>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/helm-charts

    <Directory "/var/www/html/helm-charts">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo sed -i 's/Listen 80/Listen 8092/g' /etc/apache2/ports.conf

sudo mkdir -p /var/www/html/helm-charts



# Disable default site
sudo a2dissite 000-default

sudo a2ensite helm-charts
sudo systemctl reload apache2
sudo systemctl restart apache2

echo "Complete"