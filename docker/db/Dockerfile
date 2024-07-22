FROM mysql:8
ENV MYSQL_ROOT_PASSWORD=${MY_DB_PASS_SECRET}
ENV MYSQL_DATABASE="accounts"
COPY db_backup.sql /docker-entrypoint-initdb.d/db_backup.sql
EXPOSE 3306