#!/usr/bin/with-contenv bashio
# ==============================================================================
# Legend of the Green Dragon Add-on
# ==============================================================================
bashio::log.info "Configuring Legend of the Green Dragon..."

# Generate .env file
tempio \
    -conf /data/options.json \
    -template /usr/share/tempio/lotgd.env.gtpl \
    -out /var/www/localhost/htdocs/.env

# Fix permissions
chown -R apache:apache /var/www/localhost/htdocs
chmod -R 777 /var/www/localhost/htdocs/data

# Run migrations if possible (maybe later)
# php /var/www/localhost/htdocs/bin/doctrine migrations:migrate --no-interaction
