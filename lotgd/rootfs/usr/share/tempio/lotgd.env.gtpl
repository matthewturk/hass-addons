MYSQL_DATABASE={{ .db_name }}
MYSQL_HOST={{ .db_host }}
MYSQL_USER={{ .db_user }}
MYSQL_PASSWORD={{ .db_password }}
MYSQL_USEDATACACHE={{ if .db_use_data_cache }}1{{ else }}0{{ end }}
MYSQL_DATACACHEPATH=/var/www/localhost/htdocs/data/cache
