#!/bin/bash
service postgresql initdb
echo 'local all all trust' > /var/lib/pgsql/data/pg_hba.conf
echo 'host all all 0.0.0.0/0 md5' >> /var/lib/pgsql/data/pg_hba.conf
service postgresql start
sleep 5
su postgres sh -c "psql -c \"CREATE USER brpmuser WITH PASSWORD 'sa' CREATEDB\""
su postgres sh -c "psql -c \"CREATE DATABASE brpm26 OWNER=brpmuser\""

export DB_SERVER=localhost
export DB_PORT=5432
cd /usr/share/tomcat6/webapps/brpm/WEB-INF
export BUNDLE_GEMFILE=Gemfile
export GEM_HOME=gems
export RAILS_ENV=production
java -classpath "lib/*" org.jruby.Main -S rake --verbose --trace app:setup:smartrelease_no_drop
java -classpath "lib/*" org.jruby.Main -S rake --verbose --trace db:migrate
java -classpath "lib/*" org.jruby.Main -S rake --verbose --trace app:reset_password <<InputValues
admin
$ADMIN_PASSWORD
$ADMIN_PASSWORD
InputValues
service postgresql stop