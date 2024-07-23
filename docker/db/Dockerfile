FROM mysql:8.0.33
#mention database password in .env file
ENV MYSQL_ROOT_PASSWORD=${MY_DB_PASS}
ENV MYSQL_DATABASE="accounts"
ADD db_backup.sql /docker-entrypoint-initdb.d/db_backup.sql
EXPOSE 3306