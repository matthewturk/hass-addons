#!/usr/bin/with-contenv bashio
# ==============================================================================
# Legend of the Green Dragon Add-on
# ==============================================================================
bashio::log.info "Configuring Legend of the Green Dragon..."

# Set timezone
if [ -n "${TZ}" ]; then
    bashio::log.info "Setting timezone to ${TZ}"
    cp "/usr/share/zoneinfo/${TZ}" /etc/localtime
    echo "${TZ}" > /etc/timezone
    echo "date.timezone=${TZ}" > /etc/php83/conf.d/00_timezone.ini
fi

# Generate .env file
tempio \
    -conf /data/options.json \
    -template /usr/share/tempio/lotgd.env.gtpl \
    -out /var/www/localhost/htdocs/.env

# Persist dbconnect.php
if [ ! -L /var/www/localhost/htdocs/dbconnect.php ]; then
    rm -f /var/www/localhost/htdocs/dbconnect.php
    ln -s /data/dbconnect.php /var/www/localhost/htdocs/dbconnect.php
fi

# Ensure apache can write to /data (to create dbconnect.php via symlink)
chown apache:apache /data

# Fix permissions
chown -R apache:apache /var/www/localhost/htdocs
chmod -R 777 /var/www/localhost/htdocs/data

# Ensure persistent file is owned by apache if it exists
if [ -f /data/dbconnect.php ]; then
    chown apache:apache /data/dbconnect.php
fi

# Run migrations if possible (maybe later)
# php /var/www/localhost/htdocs/bin/doctrine migrations:migrate --no-interaction
