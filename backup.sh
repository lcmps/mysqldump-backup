#!/bin/bash

USER="user"
PASSWORD="password"
HOST="localhost"
ExcludeDatabases="Database|information_schema|performance_schema|mysql"
databases=`mysql -h $HOST -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | egrep -v $ExcludeDatabases`

for db in $databases; do
    echo "Dumping database: $db"
    mysqldump -h $HOST -u $USER -p$PASSWORD --databases $db > `date +%Y%m%d-%H:%m:%S`.$db.sql
    sleep 5
done

echo "Dumping completed"
